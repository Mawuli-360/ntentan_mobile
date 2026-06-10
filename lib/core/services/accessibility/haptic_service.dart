import 'package:vibration/vibration.dart';

class HapticService {
  bool _hasVibrator = false;

  Future<void> init() async {
    _hasVibrator = await Vibration.hasVibrator();
  }

  Future<void> tapFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(duration: 50);
  }

  Future<void> navigationFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 50, 80, 50]);
  }

  Future<void> successFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 150, 60, 80]);
  }

  Future<void> errorFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 40, 50, 40, 50, 40]);
  }

  Future<void> warningFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(pattern: [0, 100, 100, 100]);
  }

  Future<void> longPressFeedback() async {
    if (!_hasVibrator) return;
    await Vibration.vibrate(duration: 200);
  }
}
