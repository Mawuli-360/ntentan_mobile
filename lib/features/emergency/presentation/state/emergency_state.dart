import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/core/constants/enums.dart';

import 'package:ntentan/features/emergency/data/medical_alert_response.dart';

part 'emergency_state.freezed.dart';

@freezed
sealed class EmergencyState with _$EmergencyState {
  const EmergencyState._();

  const factory EmergencyState.idle() = EmergencyIdle;

  const factory EmergencyState.countingDown({
    @Default(5) int countdown,
    required SosTrigger lastTrigger,
    @Default(false) bool silentMode,
  }) = EmergencyCountingDown;

  const factory EmergencyState.sending({
    required SosTrigger lastTrigger,
    @Default(false) bool silentMode,
    @Default(false) bool gpsShared,
    @Default(false) bool medicalInfoShared,
  }) = EmergencySending;

  const factory EmergencyState.sent({
    required SosTrigger lastTrigger,
    @Default(false) bool silentMode,
    @Default(false) bool gpsShared,
    @Default(false) bool medicalInfoShared,
    @Default(false) bool contactsNotified,
    @Default([]) List<NotifiedContact> notifiedContacts,
    @Default(false) bool showHelperCard,
  }) = EmergencySent;

  const factory EmergencyState.error({
    required SosTrigger lastTrigger,
    @Default(false) bool silentMode,
    required String message,
  }) = EmergencyError;

  const factory EmergencyState.postEmergency() = EmergencyPostActive;

  // --- UI Backward Compatibility Getters ---
  bool get sosActive =>
      this is EmergencyCountingDown ||
      this is EmergencySending ||
      this is EmergencySent ||
      this is EmergencyError;

  bool get sending => this is EmergencySending;
  bool get sent => this is EmergencySent;
  bool get postEmergencyActive => this is EmergencyPostActive;

  int get countdown => switch (this) {
        EmergencyCountingDown(countdown: final c) => c,
        _ => 0,
      };

  SosTrigger get lastTrigger => switch (this) {
        EmergencyCountingDown(lastTrigger: final t) => t,
        EmergencySending(lastTrigger: final t) => t,
        EmergencySent(lastTrigger: final t) => t,
        EmergencyError(lastTrigger: final t) => t,
        _ => SosTrigger.button,
      };

  bool get silentMode => switch (this) {
        EmergencyCountingDown(silentMode: final s) => s,
        EmergencySending(silentMode: final s) => s,
        EmergencySent(silentMode: final s) => s,
        EmergencyError(silentMode: final s) => s,
        _ => false,
      };

  bool get gpsShared => switch (this) {
        EmergencySending(gpsShared: final s) => s,
        EmergencySent(gpsShared: final s) => s,
        _ => false,
      };

  bool get medicalInfoShared => switch (this) {
        EmergencySending(medicalInfoShared: final s) => s,
        EmergencySent(medicalInfoShared: final s) => s,
        _ => false,
      };

  bool get contactsNotified => switch (this) {
        EmergencySent(contactsNotified: final s) => s,
        _ => false,
      };

  List<NotifiedContact> get notifiedContacts => switch (this) {
        EmergencySent(notifiedContacts: final c) => c,
        _ => [],
      };

  bool get showHelperCard => switch (this) {
        EmergencySent(showHelperCard: final s) => s,
        _ => false,
      };

  String? get errorMessage => switch (this) {
        EmergencyError(message: final m) => m,
        _ => null,
      };
}
