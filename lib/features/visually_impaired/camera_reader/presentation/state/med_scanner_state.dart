//
//  med_scanner_state.dart
//  ntentan
//

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_response.dart';

part 'med_scanner_state.freezed.dart';

enum ScanPhase { idle, connecting, scanning, success, error }

@freezed
sealed class MedScannerState with _$MedScannerState {
  const MedScannerState._();

  const factory MedScannerState.idle({
    @Default(false) bool isCameraReady,
    @Default(false) bool isFlashOn,
    @Default('Initializing camera...') String guidanceText,
    @Default('none') String instruction,
    MedScannerResponse? lastResponse,
  }) = MedScannerIdle;

  const factory MedScannerState.connecting({
    @Default(false) bool isCameraReady,
    @Default(false) bool isFlashOn,
    @Default('Connecting to scanner...') String guidanceText,
    @Default('none') String instruction,
    MedScannerResponse? lastResponse,
  }) = MedScannerConnecting;

  const factory MedScannerState.scanning({
    @Default(false) bool isCameraReady,
    @Default(false) bool isFlashOn,
    @Default('Move camera to find the label...') String guidanceText,
    @Default('none') String instruction,
    MedScannerResponse? lastResponse,
  }) = MedScannerScanning;

  const factory MedScannerState.success({
    @Default(false) bool isCameraReady,
    @Default(false) bool isFlashOn,
    @Default('') String guidanceText,
    @Default('none') String instruction,
    MedScannerResponse? lastResponse,
  }) = MedScannerSuccess;

  const factory MedScannerState.error({
    @Default(false) bool isCameraReady,
    @Default(false) bool isFlashOn,
    @Default('Error occurred') String guidanceText,
    @Default('none') String instruction,
    MedScannerResponse? lastResponse,
    required String errorMessage,
  }) = MedScannerError;

  ScanPhase get phase => switch (this) {
        MedScannerIdle() => ScanPhase.idle,
        MedScannerConnecting() => ScanPhase.connecting,
        MedScannerScanning() => ScanPhase.scanning,
        MedScannerSuccess() => ScanPhase.success,
        MedScannerError() => ScanPhase.error,
      };

  String? get errorMessage => switch (this) {
        MedScannerError(errorMessage: final e) => e,
        _ => null,
      };
}
