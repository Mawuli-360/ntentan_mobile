import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/emergency/presentation/state/emergency_state.dart';
import 'package:ntentan/features/emergency/data/medical_alert_rest_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/constants/app_strings.dart';
import 'package:ntentan/core/constants/logger.dart';

/// Emergency controller — manages SOS state, countdown, and post-emergency flow.
class EmergencyController extends ChangeNotifier {
  final MedicalAlertRestService _alertRestService;
  EmergencyState _state = const EmergencyState.idle();

  EmergencyController({required MedicalAlertRestService alertRestService})
      : _alertRestService = alertRestService;

  // ── Getters ──
  EmergencyState get state => _state;

  // ── State Mutator ──
  void updateState(EmergencyState newState) {
    _state = newState;
    notifyListeners();
  }

  // ── Actions ──

  void activateSOS(SosTrigger trigger) {
    updateState(EmergencyState.countingDown(
      countdown: 5,
      lastTrigger: trigger,
      silentMode: false,
    ));
  }

  void updateCountdown(int value) {
    if (state is EmergencyCountingDown) {
      final s = state as EmergencyCountingDown;
      updateState(s.copyWith(countdown: value));

      if (value <= 0) {
        sendEmergencyAlert();
      }
    }
  }

  Future<void> sendEmergencyAlert() async {
    if (state is EmergencySending || state is EmergencySent) return;

    final trigger = state.lastTrigger;
    final isSilent = state.silentMode;

    updateState(EmergencyState.sending(
      lastTrigger: trigger,
      silentMode: isSilent,
      gpsShared: state.gpsShared,
      medicalInfoShared: state.medicalInfoShared,
    ));

    double lat = 0.0;
    double lng = 0.0;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          Position position = await Geolocator.getCurrentPosition(
              locationSettings:
                  const LocationSettings(accuracy: LocationAccuracy.high));
          lat = position.latitude;
          lng = position.longitude;
          markGPSShared();
        } else {
          AppLogger.w('Location permission denied, using default 0.0, 0.0');
        }
      } else {
        AppLogger.w('Location services disabled, using default 0.0, 0.0');
      }
    } catch (e) {
      AppLogger.e('Failed to get location: $e');
    }

    try {
      final baseUrl = dotenv.env[EnvKeys.baseUrl]!;
      final response = await _alertRestService.sendAlert(
        baseUrl: baseUrl,
        latitude: lat,
        longitude: lng,
      );

      updateState(EmergencyState.sent(
        lastTrigger: state.lastTrigger,
        silentMode: state.silentMode,
        gpsShared: state.gpsShared,
        medicalInfoShared: state.medicalInfoShared,
        contactsNotified: true,
        notifiedContacts: response.notifiedContacts,
        showHelperCard: false,
      ));
    } catch (e) {
      updateState(EmergencyState.error(
        lastTrigger: state.lastTrigger,
        silentMode: state.silentMode,
        message: 'Failed to send alert: $e',
      ));
    }
  }

  void cancelSOS() {
    updateState(const EmergencyState.idle());
  }

  void markGPSShared() {
    switch (state) {
      case EmergencySending s:
        updateState(s.copyWith(gpsShared: true));
      case EmergencySent s:
        updateState(s.copyWith(gpsShared: true));
      default:
        break;
    }
  }

  void markMedicalInfoShared() {
    switch (state) {
      case EmergencySending s:
        updateState(s.copyWith(medicalInfoShared: true));
      case EmergencySent s:
        updateState(s.copyWith(medicalInfoShared: true));
      default:
        break;
    }
  }

  void activateSilentMode() {
    switch (state) {
      case EmergencyCountingDown s:
        updateState(s.copyWith(silentMode: true));
      case EmergencySending s:
        updateState(s.copyWith(silentMode: true));
      case EmergencySent s:
        updateState(s.copyWith(silentMode: true));
      case EmergencyError s:
        updateState(s.copyWith(silentMode: true));
      default:
        break;
    }
  }

  void toggleHelperCard() {
    if (state is EmergencySent) {
      final s = state as EmergencySent;
      updateState(s.copyWith(showHelperCard: !s.showHelperCard));
    }
  }

  void startPostEmergency() {
    updateState(const EmergencyState.postEmergency());
  }

  void confirmSafe() {
    updateState(const EmergencyState.idle());
  }
}
