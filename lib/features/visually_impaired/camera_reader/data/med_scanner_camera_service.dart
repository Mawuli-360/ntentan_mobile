import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:ntentan/core/constants/logger.dart';

/// Service responsible for managing camera hardware, flash state,
/// and periodic frame capturing for the medication scanner.
class MedScannerCameraService {
  CameraController? _cameraController;
  Timer? _frameTimer;

  CameraController? get controller => _cameraController;

  /// Initializes the back camera and prepares it for scanning.
  Future<bool> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return false;

      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      return true;
    } catch (e) {
      AppLogger.e('Camera initialization failed: $e');
      return false;
    }
  }

  /// Toggles the device flashlight.
  Future<bool> toggleFlash(bool turnOn) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return false;
    }
    try {
      await _cameraController!.setFlashMode(
        turnOn ? FlashMode.torch : FlashMode.off,
      );
      return true;
    } catch (e) {
      AppLogger.e('Failed to set flash mode: $e');
      return false;
    }
  }

  /// Starts a periodic timer that captures frames and passes them to [onFrame].
  void startFrameStream(void Function(Uint8List frameBytes) onFrame) {
    _frameTimer?.cancel();
    bool isProcessingFrame = false;

    // Server buffers frames. We stream roughly 1.5 frames per second (~600ms).
    _frameTimer =
        Timer.periodic(const Duration(milliseconds: 600), (timer) async {
      if (_cameraController == null ||
          !_cameraController!.value.isInitialized ||
          _cameraController!.value.isTakingPicture ||
          isProcessingFrame) {
        return;
      }

      isProcessingFrame = true;
      try {
        if (_cameraController == null) return;
        final xFile = await _cameraController!.takePicture();
        final bytes = await xFile.readAsBytes();
        onFrame(bytes);
      } catch (e) {
        if (!e.toString().contains('disposed')) {
          AppLogger.e('Failed to capture frame: $e');
        }
      } finally {
        isProcessingFrame = false;
      }
    });
  }

  /// Stops capturing frames.
  void stopFrameStream() {
    _frameTimer?.cancel();
    _frameTimer = null;
  }

  /// Cleans up hardware resources.
  void dispose() {
    stopFrameStream();
    final oldController = _cameraController;
    _cameraController = null;
    // Delay disposal so the CameraPreview widget has time to fully unmount
    // during route transitions without throwing a "used after being disposed" error.
    Future.delayed(const Duration(milliseconds: 500), () {
      oldController?.dispose();
    });
  }
}
