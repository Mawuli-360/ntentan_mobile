import 'dart:convert';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ntentan/core/constants/logger.dart';

/// Service responsible for all audio/microphone hardware manipulation
/// and file system operations for the Voice Assistant.
class AssistantMediaService {
  late final RecorderController _recorderController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AssistantMediaService() {
    _recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  /// Exposes the RecorderController so the UI can render audio waveforms.
  RecorderController get recorderController => _recorderController;

  /// Checks if microphone permissions are granted.
  Future<bool> checkPermission() async {
    return await _recorderController.checkPermission();
  }

  /// Stops any currently playing audio and starts recording.
  Future<void> startRecording() async {
    await stopAudio();
    await _recorderController.record();
  }

  /// Stops recording, reads the temporary file bytes, and returns a Base64 string.
  /// Returns null if the recording failed or was too short.
  Future<String?> stopRecordingAndGetBase64() async {
    final path = await _recorderController.stop();
    if (path == null) return null;

    try {
      final file = File(path);
      final bytes = await file.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      AppLogger.e('Failed to read recording file: $e');
      return null;
    }
  }

  /// Stops the current audio playback.
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  /// Decodes a Base64 audio string, writes it to a temporary file, and plays it.
  Future<void> playBase64Audio(String base64Audio) async {
    try {
      final bytes = base64Decode(base64Audio);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/assistant_response.mp3');
      await file.writeAsBytes(bytes);

      await _audioPlayer.play(DeviceFileSource(file.path));
    } catch (e) {
      AppLogger.e('Failed to play assistant audio: $e');
    }
  }

  /// Cleans up hardware resources.
  void dispose() {
    _recorderController.dispose();
    _audioPlayer.dispose();
  }
}
