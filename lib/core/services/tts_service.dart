import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/semantics.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/utils/tts_text_cleaner.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    init();
  }

  Future<void> init() async {
    try {
      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
      );
      await _flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      AppLogger.e('Failed to initialize TTS: $e');
    }
  }

  /// Map common app languages to TTS engine languages.
  String _mapLanguageCode(String? language) {
    if (language == null) return 'en-US';

    final normalized = language.trim().toLowerCase();
    switch (normalized) {
      case 'twi':
        return 'tw-GH'; // Akan / Twi language code (if supported by the device)
      case 'english':
      default:
        return 'en-US';
    }
  }

  Future<void> speak(String text, {String? language}) async {
    if (text.trim().isEmpty) return;

    final cleanText = TtsTextCleaner.clean(text);

    try {
      await stop();
      final isTalkBackActive =
          SemanticsBinding.instance.accessibilityFeatures.accessibleNavigation;
      final langCode = _mapLanguageCode(language);
      await _flutterTts.setLanguage(langCode);
      if (isTalkBackActive) {
        await _flutterTts.setVolume(0.3);
      } else {
        await _flutterTts.setVolume(1.0);
      }
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.5); // Slower, more natural reading pace
      await _flutterTts.speak(cleanText);
    } catch (e) {
      AppLogger.e('Failed to speak text: $e');
    }
  }

  Future<void> pause() async {
    await _flutterTts.pause();
  }

  Future<void> resume() async {}

  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate.clamp(0.1, 1.0));
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      AppLogger.e('Failed to stop TTS: $e');
    }
  }
}
