//
//  assistant_controller.dart
//  ntentan
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/constants/app_strings.dart';
import 'package:ntentan/core/constants/logger.dart';

import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_message.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_rest_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_media_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/state/assistant_state.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/widgets/voice_chat_history.dart';

import 'package:ntentan/core/services/tts_service.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class AssistantController extends ChangeNotifier {
  final AssistantRestService _restService;
  final AssistantMediaService _mediaService;
  final TtsService _ttsService;

  AssistantState _state = const AssistantState.idle();

  AssistantController({
    required AssistantRestService restService,
    required AssistantMediaService mediaService,
    required TtsService ttsService,
  })  : _restService = restService,
        _mediaService = mediaService,
        _ttsService = ttsService;

  bool _isDisposed = false;

  // ── Getters ──

  AssistantState get state => _state;

  /// Expose the recorder controller to the UI for waveform rendering
  RecorderController get recorderController => _mediaService.recorderController;

  // ── State Mutators ──

  void updateState(AssistantState newState) {
    if (_isDisposed) return;
    _state = newState;
    notifyListeners();
  }

  void _setIdle() => updateState(AssistantState.idle(
        messages: state.messages,
        selectedLanguage: state.selectedLanguage,
      ));

  void _setListening() => updateState(AssistantState.listening(
        messages: state.messages,
        selectedLanguage: state.selectedLanguage,
      ));

  void _setSending() => updateState(AssistantState.sending(
        messages: state.messages,
        selectedLanguage: state.selectedLanguage,
      ));

  void _setThinking() => updateState(AssistantState.thinking(
        messages: state.messages,
        selectedLanguage: state.selectedLanguage,
      ));

  void _setStateError(String msg) {
    updateState(AssistantState.error(
      messages: state.messages,
      selectedLanguage: state.selectedLanguage,
      errorMessage: msg,
    ));

    // Auto-clear error after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (_isDisposed) return;
      if (state is AssistantError) {
        _setIdle();
      }
    });
  }

  // ── Initialization ──

  Future<void> init() async {}

  void setLanguage(String lang) {
    updateState(state.copyWith(selectedLanguage: lang));
  }

  // ── Messaging ──

  Future<void> sendText(String text) async {
    if (text.trim().isEmpty) return;

    _addMessageToHistory(VoiceChatMessage(true, text));
    _setThinking();

    await _sendMessage(UserMessage(
      type: 'text',
      content: text,
      language: state.selectedLanguage,
    ));
  }

  // ── Audio Recording ──

  Future<void> startRecording() async {
    final hasPermission = await _mediaService.checkPermission();
    if (!hasPermission) {
      _setStateError('Microphone permission required.');
      return;
    }

    try {
      await _ttsService.stop();
      await _mediaService.startRecording();
      _setListening();
    } catch (e) {
      AppLogger.e('Failed to start recording: $e');
      _setStateError('Failed to start recording.');
    }
  }

  Future<void> stopRecording() async {
    if (state is! AssistantListening) return;

    try {
      _setSending();

      final base64Audio = await _mediaService.stopRecordingAndGetBase64();

      if (base64Audio != null) {
        if (_isDisposed) return;

        // Add a placeholder user message for the audio clip
        _addMessageToHistory(VoiceChatMessage(
            true, '🎤 Audio message (${state.selectedLanguage})'));

        _setThinking();

        await _sendMessage(UserMessage(
          type: 'audio',
          content: base64Audio,
          language: state.selectedLanguage,
        ));
      } else {
        // Recording failed or was too short
        _setIdle();
      }
    } catch (e) {
      AppLogger.e('Failed to stop recording: $e');
      _setStateError('Failed to process recording.');
    }
  }

  Future<void> _sendMessage(UserMessage message) async {
    try {
      final baseUrl = dotenv.env[EnvKeys.baseUrl];

      final response = await _restService.chat(
        baseUrl: baseUrl!,
        message: message,
      );

      if (_isDisposed) return;
      _handleResponse(response);
    } catch (e) {
      if (_isDisposed) return;
      _setStateError('Failed to send message: $e');
    }
  }

  Future<void> _handleResponse(AssistantResponse response) async {
    if (response.content.isNotEmpty) {
      _addMessageToHistory(VoiceChatMessage(false, response.content));
    }

    if (response.audioBase64 != null && response.audioBase64!.isNotEmpty) {
      if (!_isDisposed) {
        await _mediaService.playBase64Audio(response.audioBase64!);
      }
    } else if (response.content.isNotEmpty) {
      if (!_isDisposed) {
        await _ttsService.speak(response.content,
            language: state.selectedLanguage);
      }
    }

    if (_isDisposed) return;
    _setIdle();
  }

  void _addMessageToHistory(VoiceChatMessage msg) {
    final updatedMessages = List<VoiceChatMessage>.from(state.messages)
      ..add(msg);
    updateState(state.copyWith(messages: updatedMessages));
  }

  // ── Cleanup ──

  @override
  void dispose() {
    _isDisposed = true;
    _ttsService.stop();
    super.dispose();
  }
}
