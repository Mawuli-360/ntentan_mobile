import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';

part 'accessibility_state.freezed.dart';

@freezed
abstract class AccessibilityState with _$AccessibilityState {
  const AccessibilityState._(); // Needed for methods in freezed classes

  const factory AccessibilityState({
    @Default(false) bool screenReaderEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(1.0) double fontScale,
    @Default(ColorBlindnessMode.none) ColorBlindnessMode colorBlindnessMode,
    @Default(true) bool visualFlashEnabled,
    @Default(true) bool medicationRemindersEnabled,
    @Default(false) bool magnifyScreenEnabled,
    @Default(1.3) double savedFontScale,

    @Default(false) bool isLoading,
    String? error,
  }) = _AccessibilityState;

  factory AccessibilityState.fromEntity(UserEntity user) {
    final acc = user.accessibility;
    return AccessibilityState(
      fontScale: acc.fontScale,
      colorBlindnessMode: acc.colorBlindnessMode,
      vibrationEnabled: acc.vibrationEnabled,
      visualFlashEnabled: acc.visualFlashEnabled,
      medicationRemindersEnabled: acc.medicationRemindersEnabled,
      magnifyScreenEnabled: acc.magnifyScreenEnabled,
      savedFontScale: acc.savedFontScale,
      screenReaderEnabled: acc.screenReaderEnabled,

    );
  }

  AccessibilitySettings toSettings() {
    return AccessibilitySettings(
      fontScale: fontScale,
      colorBlindnessMode: colorBlindnessMode,
      vibrationEnabled: vibrationEnabled,
      visualFlashEnabled: visualFlashEnabled,
      medicationRemindersEnabled: medicationRemindersEnabled,
      magnifyScreenEnabled: magnifyScreenEnabled,
      savedFontScale: savedFontScale,
      screenReaderEnabled: screenReaderEnabled,
    );
  }
}
