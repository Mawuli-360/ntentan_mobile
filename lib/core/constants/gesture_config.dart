class GestureConfig {
  // Timing
  static const Duration holdThreshold = Duration(milliseconds: 500);
  static const Duration pollInterval = Duration(milliseconds: 100);

  // Feature flags
  static const bool enableHoldGestureByDefault = true;
  static const bool enableHapticFeedback = true;
  static const bool enableSoundFeedback = false;

  // Accessibility
  static const bool announceHoldProgress = true;
  static const String holdGestureSemanticsLabel =
      'Long press screen to open AI assistant';
}
