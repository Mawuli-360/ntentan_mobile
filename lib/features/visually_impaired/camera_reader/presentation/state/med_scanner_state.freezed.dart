// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'med_scanner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedScannerState {
  bool get isCameraReady;
  bool get isFlashOn;
  String get guidanceText;
  String get instruction;
  MedScannerResponse? get lastResponse;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerStateCopyWith<MedScannerState> get copyWith =>
      _$MedScannerStateCopyWithImpl<MedScannerState>(
          this as MedScannerState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerState &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse);

  @override
  String toString() {
    return 'MedScannerState(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse)';
  }
}

/// @nodoc
abstract mixin class $MedScannerStateCopyWith<$Res> {
  factory $MedScannerStateCopyWith(
          MedScannerState value, $Res Function(MedScannerState) _then) =
      _$MedScannerStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse});
}

/// @nodoc
class _$MedScannerStateCopyWithImpl<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  _$MedScannerStateCopyWithImpl(this._self, this._then);

  final MedScannerState _self;
  final $Res Function(MedScannerState) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
  }) {
    return _then(_self.copyWith(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
    ));
  }
}

/// @nodoc

class MedScannerIdle extends MedScannerState {
  const MedScannerIdle(
      {this.isCameraReady = false,
      this.isFlashOn = false,
      this.guidanceText = 'Initializing camera...',
      this.instruction = 'none',
      this.lastResponse})
      : super._();

  @override
  @JsonKey()
  final bool isCameraReady;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  @JsonKey()
  final String guidanceText;
  @override
  @JsonKey()
  final String instruction;
  @override
  final MedScannerResponse? lastResponse;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerIdleCopyWith<MedScannerIdle> get copyWith =>
      _$MedScannerIdleCopyWithImpl<MedScannerIdle>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerIdle &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse);

  @override
  String toString() {
    return 'MedScannerState.idle(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse)';
  }
}

/// @nodoc
abstract mixin class $MedScannerIdleCopyWith<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  factory $MedScannerIdleCopyWith(
          MedScannerIdle value, $Res Function(MedScannerIdle) _then) =
      _$MedScannerIdleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse});
}

/// @nodoc
class _$MedScannerIdleCopyWithImpl<$Res>
    implements $MedScannerIdleCopyWith<$Res> {
  _$MedScannerIdleCopyWithImpl(this._self, this._then);

  final MedScannerIdle _self;
  final $Res Function(MedScannerIdle) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
  }) {
    return _then(MedScannerIdle(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
    ));
  }
}

/// @nodoc

class MedScannerConnecting extends MedScannerState {
  const MedScannerConnecting(
      {this.isCameraReady = false,
      this.isFlashOn = false,
      this.guidanceText = 'Connecting to scanner...',
      this.instruction = 'none',
      this.lastResponse})
      : super._();

  @override
  @JsonKey()
  final bool isCameraReady;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  @JsonKey()
  final String guidanceText;
  @override
  @JsonKey()
  final String instruction;
  @override
  final MedScannerResponse? lastResponse;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerConnectingCopyWith<MedScannerConnecting> get copyWith =>
      _$MedScannerConnectingCopyWithImpl<MedScannerConnecting>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerConnecting &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse);

  @override
  String toString() {
    return 'MedScannerState.connecting(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse)';
  }
}

/// @nodoc
abstract mixin class $MedScannerConnectingCopyWith<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  factory $MedScannerConnectingCopyWith(MedScannerConnecting value,
          $Res Function(MedScannerConnecting) _then) =
      _$MedScannerConnectingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse});
}

/// @nodoc
class _$MedScannerConnectingCopyWithImpl<$Res>
    implements $MedScannerConnectingCopyWith<$Res> {
  _$MedScannerConnectingCopyWithImpl(this._self, this._then);

  final MedScannerConnecting _self;
  final $Res Function(MedScannerConnecting) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
  }) {
    return _then(MedScannerConnecting(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
    ));
  }
}

/// @nodoc

class MedScannerScanning extends MedScannerState {
  const MedScannerScanning(
      {this.isCameraReady = false,
      this.isFlashOn = false,
      this.guidanceText = 'Move camera to find the label...',
      this.instruction = 'none',
      this.lastResponse})
      : super._();

  @override
  @JsonKey()
  final bool isCameraReady;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  @JsonKey()
  final String guidanceText;
  @override
  @JsonKey()
  final String instruction;
  @override
  final MedScannerResponse? lastResponse;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerScanningCopyWith<MedScannerScanning> get copyWith =>
      _$MedScannerScanningCopyWithImpl<MedScannerScanning>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerScanning &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse);

  @override
  String toString() {
    return 'MedScannerState.scanning(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse)';
  }
}

/// @nodoc
abstract mixin class $MedScannerScanningCopyWith<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  factory $MedScannerScanningCopyWith(
          MedScannerScanning value, $Res Function(MedScannerScanning) _then) =
      _$MedScannerScanningCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse});
}

/// @nodoc
class _$MedScannerScanningCopyWithImpl<$Res>
    implements $MedScannerScanningCopyWith<$Res> {
  _$MedScannerScanningCopyWithImpl(this._self, this._then);

  final MedScannerScanning _self;
  final $Res Function(MedScannerScanning) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
  }) {
    return _then(MedScannerScanning(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
    ));
  }
}

/// @nodoc

class MedScannerSuccess extends MedScannerState {
  const MedScannerSuccess(
      {this.isCameraReady = false,
      this.isFlashOn = false,
      this.guidanceText = '',
      this.instruction = 'none',
      this.lastResponse})
      : super._();

  @override
  @JsonKey()
  final bool isCameraReady;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  @JsonKey()
  final String guidanceText;
  @override
  @JsonKey()
  final String instruction;
  @override
  final MedScannerResponse? lastResponse;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerSuccessCopyWith<MedScannerSuccess> get copyWith =>
      _$MedScannerSuccessCopyWithImpl<MedScannerSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerSuccess &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse);

  @override
  String toString() {
    return 'MedScannerState.success(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse)';
  }
}

/// @nodoc
abstract mixin class $MedScannerSuccessCopyWith<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  factory $MedScannerSuccessCopyWith(
          MedScannerSuccess value, $Res Function(MedScannerSuccess) _then) =
      _$MedScannerSuccessCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse});
}

/// @nodoc
class _$MedScannerSuccessCopyWithImpl<$Res>
    implements $MedScannerSuccessCopyWith<$Res> {
  _$MedScannerSuccessCopyWithImpl(this._self, this._then);

  final MedScannerSuccess _self;
  final $Res Function(MedScannerSuccess) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
  }) {
    return _then(MedScannerSuccess(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
    ));
  }
}

/// @nodoc

class MedScannerError extends MedScannerState {
  const MedScannerError(
      {this.isCameraReady = false,
      this.isFlashOn = false,
      this.guidanceText = 'Error occurred',
      this.instruction = 'none',
      this.lastResponse,
      required this.errorMessage})
      : super._();

  @override
  @JsonKey()
  final bool isCameraReady;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  @JsonKey()
  final String guidanceText;
  @override
  @JsonKey()
  final String instruction;
  @override
  final MedScannerResponse? lastResponse;
  final String errorMessage;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedScannerErrorCopyWith<MedScannerError> get copyWith =>
      _$MedScannerErrorCopyWithImpl<MedScannerError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedScannerError &&
            (identical(other.isCameraReady, isCameraReady) ||
                other.isCameraReady == isCameraReady) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.guidanceText, guidanceText) ||
                other.guidanceText == guidanceText) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.lastResponse, lastResponse) ||
                other.lastResponse == lastResponse) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCameraReady, isFlashOn,
      guidanceText, instruction, lastResponse, errorMessage);

  @override
  String toString() {
    return 'MedScannerState.error(isCameraReady: $isCameraReady, isFlashOn: $isFlashOn, guidanceText: $guidanceText, instruction: $instruction, lastResponse: $lastResponse, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $MedScannerErrorCopyWith<$Res>
    implements $MedScannerStateCopyWith<$Res> {
  factory $MedScannerErrorCopyWith(
          MedScannerError value, $Res Function(MedScannerError) _then) =
      _$MedScannerErrorCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isCameraReady,
      bool isFlashOn,
      String guidanceText,
      String instruction,
      MedScannerResponse? lastResponse,
      String errorMessage});
}

/// @nodoc
class _$MedScannerErrorCopyWithImpl<$Res>
    implements $MedScannerErrorCopyWith<$Res> {
  _$MedScannerErrorCopyWithImpl(this._self, this._then);

  final MedScannerError _self;
  final $Res Function(MedScannerError) _then;

  /// Create a copy of MedScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCameraReady = null,
    Object? isFlashOn = null,
    Object? guidanceText = null,
    Object? instruction = null,
    Object? lastResponse = freezed,
    Object? errorMessage = null,
  }) {
    return _then(MedScannerError(
      isCameraReady: null == isCameraReady
          ? _self.isCameraReady
          : isCameraReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _self.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      guidanceText: null == guidanceText
          ? _self.guidanceText
          : guidanceText // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      lastResponse: freezed == lastResponse
          ? _self.lastResponse
          : lastResponse // ignore: cast_nullable_to_non_nullable
              as MedScannerResponse?,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
