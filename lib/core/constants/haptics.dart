import 'package:flutter/services.dart';
import 'package:ntentan/core/constants/enums.dart';

/// Ntentan Global Haptic Vocabulary
/// Every module draws from this vocabulary — no ad-hoc haptics.
/// Testable from settings. Documented in-app.
class AppHaptics {
  AppHaptics._();

  /// Success / Confirmed — 2 short pulses
  static Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.lightImpact();
  }

  /// Warning / Attention needed — 1 long + 1 short
  static Future<void> warning() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 120));
    await HapticFeedback.lightImpact();
  }

  /// Error / Failed — 3 long pulses
  static Future<void> error() async {
    for (int i = 0; i < 3; i++) {
      await HapticFeedback.heavyImpact();
      if (i < 2) await Future.delayed(const Duration(milliseconds: 150));
    }
  }

  /// New notification — 3 short pulses
  static Future<void> notification() async {
    for (int i = 0; i < 3; i++) {
      await HapticFeedback.selectionClick();
      if (i < 2) await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  /// SOS activated — strong continuous vibration
  static Future<void> sosActivated() async {
    await HapticFeedback.vibrate();
  }

  /// Medication reminder by time slot
  static Future<void> medicationReminder(MedTimeSlot slot) async {
    switch (slot) {
      case MedTimeSlot.morning: // · — ·  (short-long-short)
        await HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 100));
        await HapticFeedback.heavyImpact();
        await Future.delayed(const Duration(milliseconds: 100));
        await HapticFeedback.lightImpact();
        break;
      case MedTimeSlot.evening: // — · ·  (long-short-short)
        await HapticFeedback.heavyImpact();
        await Future.delayed(const Duration(milliseconds: 100));
        await HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 60));
        await HapticFeedback.lightImpact();
        break;
      case MedTimeSlot.afternoon: // · ·  (short-short)
        await HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 80));
        await HapticFeedback.lightImpact();
        break;
      case MedTimeSlot.night: // — — (two heavy)
        await HapticFeedback.heavyImpact();
        await Future.delayed(const Duration(milliseconds: 150));
        await HapticFeedback.heavyImpact();
        break;
      case MedTimeSlot.asNeeded: // · · · (three short)
        await HapticFeedback.selectionClick();
        await Future.delayed(const Duration(milliseconds: 60));
        await HapticFeedback.selectionClick();
        await Future.delayed(const Duration(milliseconds: 60));
        await HapticFeedback.selectionClick();
        break;
    }
  }

  /// Button tap — light feedback
  static Future<void> tap() async {
    await HapticFeedback.selectionClick();
  }

  /// Light impact — for sliders or subtle feedback
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Navigation — medium impact
  static Future<void> navigate() async {
    await HapticFeedback.mediumImpact();
  }

  /// Appointment reminder — 4-part pattern · · — ·
  static Future<void> appointmentReminder() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 60));
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }
}
