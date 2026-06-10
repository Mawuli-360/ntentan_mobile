//
//  med_scanner_controller.dart
//  ntentan
//

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/constants/app_strings.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/manager/token_manager.dart';

import 'package:ntentan/core/services/tts_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_socket_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_camera_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/state/med_scanner_state.dart';

class MedScannerController extends ChangeNotifier {
  final MedScannerSocketService _socketService;
  final MedScannerCameraService _cameraService;
  final TtsService _ttsService;

  StreamSubscription? _socketSubscription;
  bool _isDisposed = false;
  String _selectedLanguage = 'english';
  String? _lastSpokenGuidance;

  MedScannerState _state = const MedScannerState.idle();

  MedScannerController({
    required MedScannerSocketService socketService,
    required MedScannerCameraService cameraService,
    required TtsService ttsService,
  })  : _socketService = socketService,
        _cameraService = cameraService,
        _ttsService = ttsService;

  void setLanguage(String lang) {
    _selectedLanguage = lang;
  }

  // ── Getters ──

  MedScannerState get state => _state;
  CameraController? get cameraController => _cameraService.controller;

  // ── State Mutators ──

  void updateState(MedScannerState newState) {
    if (_isDisposed) return;
    _state = newState;
    notifyListeners();
  }

  void _setIdle({String? guidanceText}) {
    updateState(MedScannerState.idle(
      isCameraReady: state.isCameraReady,
      isFlashOn: state.isFlashOn,
      guidanceText: guidanceText ?? 'Scanning paused',
      instruction: state.instruction,
      lastResponse: state.lastResponse,
    ));
  }

  void _setConnecting({String? guidanceText}) {
    updateState(MedScannerState.connecting(
      isCameraReady: state.isCameraReady,
      isFlashOn: state.isFlashOn,
      guidanceText: guidanceText ?? 'Connecting to scanner...',
      instruction: state.instruction,
      lastResponse: state.lastResponse,
    ));
  }

  void _setScanning({String? guidanceText}) {
    updateState(MedScannerState.scanning(
      isCameraReady: state.isCameraReady,
      isFlashOn: state.isFlashOn,
      guidanceText: guidanceText ?? state.guidanceText,
      instruction: state.instruction,
      lastResponse: state.lastResponse,
    ));
  }

  void _setSuccess({String? guidanceText}) {
    updateState(MedScannerState.success(
      isCameraReady: state.isCameraReady,
      isFlashOn: state.isFlashOn,
      guidanceText: guidanceText ?? state.guidanceText,
      instruction: state.instruction,
      lastResponse: state.lastResponse,
    ));
  }

  void _setError(String msg) {
    updateState(MedScannerState.error(
      isCameraReady: state.isCameraReady,
      isFlashOn: state.isFlashOn,
      errorMessage: msg,
      guidanceText: 'Error occurred',
      instruction: state.instruction,
      lastResponse: state.lastResponse,
    ));
  }

  // ── Initialization ──

  Future<void> initCameraAndService() async {
    updateState(const MedScannerState.idle(
      isCameraReady: false,
      guidanceText: 'Initializing camera...',
    ));

    final initialized = await _cameraService.initializeCamera();

    if (!initialized) {
      _setError('Failed to initialize camera.');
      return;
    }

    updateState(const MedScannerState.idle(
      isCameraReady: true,
      guidanceText: 'Point camera at a medication label.',
    ));

    // Listen to server responses
    _socketSubscription =
        _socketService.responseStream.listen(_handleServerResponse);
  }

  // ── Actions ──

  Future<void> startScanning() async {
    if (state is MedScannerScanning || _cameraService.controller == null) {
      return;
    }

    _setConnecting();

    final wsBaseUrl = dotenv.env[EnvKeys.webSocketUrl] ?? 'wss://api.trylee.ai';

    final token = await TokenManager.getToken();
    if (token != null) {
      _socketService.connect(wsBaseUrl, token);
    } else {
      _setError("Could not retrieve authentication token.");
      return;
    }

    _setScanning(guidanceText: 'Move camera to find the label...');

    _cameraService.startFrameStream((bytes) {
      if (!_isDisposed && _socketService.isConnected) {
        _socketService.sendFrame(bytes);
      }
    });
  }

  void stopScanning() {
    _cameraService.stopFrameStream();
    _socketService.disconnect();

    // Only reset state if not already success or error
    if (state is MedScannerScanning || state is MedScannerConnecting) {
      _setIdle(guidanceText: 'Scanning paused');
    }
  }

  Future<void> toggleFlash() async {
    final newState = !state.isFlashOn;
    final success = await _cameraService.toggleFlash(newState);
    if (success) {
      updateState(state.copyWith(isFlashOn: newState));
    }
  }

  // ── Internal Handlers ──

  void _handleServerResponse(response) {
    if (state is! MedScannerScanning && state is! MedScannerSuccess) {
      return;
    }

    // Temporarily update instruction and lastResponse using current state's copyWith
    updateState(state.copyWith(
      instruction: response.instruction,
      lastResponse: response,
    ));

    if (response.status == 'success') {
      stopScanning(); // Stop streaming frames upon success

      String textToSpeak = response.guidanceText ?? 'Medicine detected.';
      final match = response.prescriptionMatch;

      if (match == null) {
        textToSpeak +=
            ' However, this medicine is not found in your saved medications.';
      } else {
        final med = match.medication;
        final sentence = StringBuffer('I found ${med.name}. ');

        if (med.frequency != null && med.frequency! > 0) {
          sentence.write('It is to be taken ${med.frequency} times a day. ');
        }

        if (med.unitsPerDose != null && med.unitsPerDose! > 0) {
          AppLogger.i('This is the dosage: ${med.dosage}');
          AppLogger.i('This is the units: ${med.unitsPerDose}');
          AppLogger.i(
              'This is the ${med.dosage.isNotEmpty ? med.dosage : "units"}');
          sentence.write('You are to take ${med.unitsPerDose}}');
          if (med.timeSlots.isNotEmpty) {
            if (med.timeSlots.length == 1) {
              sentence.write(' in the ${med.timeSlots.first}. ');
            } else {
              final last = med.timeSlots.last;
              final others =
                  med.timeSlots.sublist(0, med.timeSlots.length - 1).join(', ');
              sentence.write(' in the $others, and $last. ');
            }
          } else {
            sentence.write('. ');
          }
        } else if (med.timeSlots.isNotEmpty) {
          sentence.write('It is scheduled for ${med.timeSlots.join(", ")}. ');
        }

        if (med.instruction.isNotEmpty) {
          sentence.write('Instructions: ${med.instruction}.');
        }

        textToSpeak = sentence.toString().trim();
      }

      _setSuccess(guidanceText: textToSpeak);

      if (!_isDisposed) {
        _ttsService.speak(textToSpeak, language: _selectedLanguage);
      }
    } else if (response.status == 'positioning') {
      _setScanning(guidanceText: response.guidanceText);

      if (response.guidanceText != null &&
          response.guidanceText != _lastSpokenGuidance) {
        _lastSpokenGuidance = response.guidanceText;
        if (!_isDisposed) {
          _ttsService.speak(response.guidanceText, language: _selectedLanguage);
        }
      }
    } else {
      // 'no_object' or 'processing' doesn't change phase, just updates text if needed
      _setScanning(guidanceText: response.guidanceText);
    }
  }

  // ── Cleanup ──

  @override
  void dispose() {
    _isDisposed = true;
    _ttsService.stop();
    _socketSubscription?.cancel();
    _socketService.disconnect();
    _cameraService.dispose();
    super.dispose();
  }
}
