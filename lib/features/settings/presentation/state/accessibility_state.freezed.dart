// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accessibility_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccessibilityState {
  bool get screenReaderEnabled;
  bool get vibrationEnabled;
  double get fontScale;
  ColorBlindnessMode get colorBlindnessMode;
  bool get visualFlashEnabled;
  bool get medicationRemindersEnabled;
  bool get magnifyScreenEnabled;
  double get savedFontScale;
  bool get isLoading;
  String? get error;

  /// Create a copy of AccessibilityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccessibilityStateCopyWith<AccessibilityState> get copyWith =>
      _$AccessibilityStateCopyWithImpl<AccessibilityState>(
          this as AccessibilityState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccessibilityState &&
            (identical(other.screenReaderEnabled, screenReaderEnabled) ||
                other.screenReaderEnabled == screenReaderEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.fontScale, fontScale) ||
                other.fontScale == fontScale) &&
            (identical(other.colorBlindnessMode, colorBlindnessMode) ||
                other.colorBlindnessMode == colorBlindnessMode) &&
            (identical(other.visualFlashEnabled, visualFlashEnabled) ||
                other.visualFlashEnabled == visualFlashEnabled) &&
            (identical(other.medicationRemindersEnabled,
                    medicationRemindersEnabled) ||
                other.medicationRemindersEnabled ==
                    medicationRemindersEnabled) &&
            (identical(other.magnifyScreenEnabled, magnifyScreenEnabled) ||
                other.magnifyScreenEnabled == magnifyScreenEnabled) &&
            (identical(other.savedFontScale, savedFontScale) ||
                other.savedFontScale == savedFontScale) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      screenReaderEnabled,
      vibrationEnabled,
      fontScale,
      colorBlindnessMode,
      visualFlashEnabled,
      medicationRemindersEnabled,
      magnifyScreenEnabled,
      savedFontScale,
      isLoading,
      error);

  @override
  String toString() {
    return 'AccessibilityState(screenReaderEnabled: $screenReaderEnabled, vibrationEnabled: $vibrationEnabled, fontScale: $fontScale, colorBlindnessMode: $colorBlindnessMode, visualFlashEnabled: $visualFlashEnabled, medicationRemindersEnabled: $medicationRemindersEnabled, magnifyScreenEnabled: $magnifyScreenEnabled, savedFontScale: $savedFontScale, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $AccessibilityStateCopyWith<$Res> {
  factory $AccessibilityStateCopyWith(
          AccessibilityState value, $Res Function(AccessibilityState) _then) =
      _$AccessibilityStateCopyWithImpl;
  @useResult
  $Res call(
      {bool screenReaderEnabled,
      bool vibrationEnabled,
      double fontScale,
      ColorBlindnessMode colorBlindnessMode,
      bool visualFlashEnabled,
      bool medicationRemindersEnabled,
      bool magnifyScreenEnabled,
      double savedFontScale,
      bool isLoading,
      String? error});
}

/// @nodoc
class _$AccessibilityStateCopyWithImpl<$Res>
    implements $AccessibilityStateCopyWith<$Res> {
  _$AccessibilityStateCopyWithImpl(this._self, this._then);

  final AccessibilityState _self;
  final $Res Function(AccessibilityState) _then;

  /// Create a copy of AccessibilityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenReaderEnabled = null,
    Object? vibrationEnabled = null,
    Object? fontScale = null,
    Object? colorBlindnessMode = null,
    Object? visualFlashEnabled = null,
    Object? medicationRemindersEnabled = null,
    Object? magnifyScreenEnabled = null,
    Object? savedFontScale = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      screenReaderEnabled: null == screenReaderEnabled
          ? _self.screenReaderEnabled
          : screenReaderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _self.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fontScale: null == fontScale
          ? _self.fontScale
          : fontScale // ignore: cast_nullable_to_non_nullable
              as double,
      colorBlindnessMode: null == colorBlindnessMode
          ? _self.colorBlindnessMode
          : colorBlindnessMode // ignore: cast_nullable_to_non_nullable
              as ColorBlindnessMode,
      visualFlashEnabled: null == visualFlashEnabled
          ? _self.visualFlashEnabled
          : visualFlashEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      medicationRemindersEnabled: null == medicationRemindersEnabled
          ? _self.medicationRemindersEnabled
          : medicationRemindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      magnifyScreenEnabled: null == magnifyScreenEnabled
          ? _self.magnifyScreenEnabled
          : magnifyScreenEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      savedFontScale: null == savedFontScale
          ? _self.savedFontScale
          : savedFontScale // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _AccessibilityState extends AccessibilityState {
  const _AccessibilityState(
      {this.screenReaderEnabled = false,
      this.vibrationEnabled = true,
      this.fontScale = 1.0,
      this.colorBlindnessMode = ColorBlindnessMode.none,
      this.visualFlashEnabled = true,
      this.medicationRemindersEnabled = true,
      this.magnifyScreenEnabled = false,
      this.savedFontScale = 1.3,
      this.isLoading = false,
      this.error})
      : super._();

  @override
  @JsonKey()
  final bool screenReaderEnabled;
  @override
  @JsonKey()
  final bool vibrationEnabled;
  @override
  @JsonKey()
  final double fontScale;
  @override
  @JsonKey()
  final ColorBlindnessMode colorBlindnessMode;
  @override
  @JsonKey()
  final bool visualFlashEnabled;
  @override
  @JsonKey()
  final bool medicationRemindersEnabled;
  @override
  @JsonKey()
  final bool magnifyScreenEnabled;
  @override
  @JsonKey()
  final double savedFontScale;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of AccessibilityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccessibilityStateCopyWith<_AccessibilityState> get copyWith =>
      __$AccessibilityStateCopyWithImpl<_AccessibilityState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccessibilityState &&
            (identical(other.screenReaderEnabled, screenReaderEnabled) ||
                other.screenReaderEnabled == screenReaderEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.fontScale, fontScale) ||
                other.fontScale == fontScale) &&
            (identical(other.colorBlindnessMode, colorBlindnessMode) ||
                other.colorBlindnessMode == colorBlindnessMode) &&
            (identical(other.visualFlashEnabled, visualFlashEnabled) ||
                other.visualFlashEnabled == visualFlashEnabled) &&
            (identical(other.medicationRemindersEnabled,
                    medicationRemindersEnabled) ||
                other.medicationRemindersEnabled ==
                    medicationRemindersEnabled) &&
            (identical(other.magnifyScreenEnabled, magnifyScreenEnabled) ||
                other.magnifyScreenEnabled == magnifyScreenEnabled) &&
            (identical(other.savedFontScale, savedFontScale) ||
                other.savedFontScale == savedFontScale) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      screenReaderEnabled,
      vibrationEnabled,
      fontScale,
      colorBlindnessMode,
      visualFlashEnabled,
      medicationRemindersEnabled,
      magnifyScreenEnabled,
      savedFontScale,
      isLoading,
      error);

  @override
  String toString() {
    return 'AccessibilityState(screenReaderEnabled: $screenReaderEnabled, vibrationEnabled: $vibrationEnabled, fontScale: $fontScale, colorBlindnessMode: $colorBlindnessMode, visualFlashEnabled: $visualFlashEnabled, medicationRemindersEnabled: $medicationRemindersEnabled, magnifyScreenEnabled: $magnifyScreenEnabled, savedFontScale: $savedFontScale, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$AccessibilityStateCopyWith<$Res>
    implements $AccessibilityStateCopyWith<$Res> {
  factory _$AccessibilityStateCopyWith(
          _AccessibilityState value, $Res Function(_AccessibilityState) _then) =
      __$AccessibilityStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool screenReaderEnabled,
      bool vibrationEnabled,
      double fontScale,
      ColorBlindnessMode colorBlindnessMode,
      bool visualFlashEnabled,
      bool medicationRemindersEnabled,
      bool magnifyScreenEnabled,
      double savedFontScale,
      bool isLoading,
      String? error});
}

/// @nodoc
class __$AccessibilityStateCopyWithImpl<$Res>
    implements _$AccessibilityStateCopyWith<$Res> {
  __$AccessibilityStateCopyWithImpl(this._self, this._then);

  final _AccessibilityState _self;
  final $Res Function(_AccessibilityState) _then;

  /// Create a copy of AccessibilityState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? screenReaderEnabled = null,
    Object? vibrationEnabled = null,
    Object? fontScale = null,
    Object? colorBlindnessMode = null,
    Object? visualFlashEnabled = null,
    Object? medicationRemindersEnabled = null,
    Object? magnifyScreenEnabled = null,
    Object? savedFontScale = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_AccessibilityState(
      screenReaderEnabled: null == screenReaderEnabled
          ? _self.screenReaderEnabled
          : screenReaderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _self.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fontScale: null == fontScale
          ? _self.fontScale
          : fontScale // ignore: cast_nullable_to_non_nullable
              as double,
      colorBlindnessMode: null == colorBlindnessMode
          ? _self.colorBlindnessMode
          : colorBlindnessMode // ignore: cast_nullable_to_non_nullable
              as ColorBlindnessMode,
      visualFlashEnabled: null == visualFlashEnabled
          ? _self.visualFlashEnabled
          : visualFlashEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      medicationRemindersEnabled: null == medicationRemindersEnabled
          ? _self.medicationRemindersEnabled
          : medicationRemindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      magnifyScreenEnabled: null == magnifyScreenEnabled
          ? _self.magnifyScreenEnabled
          : magnifyScreenEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      savedFontScale: null == savedFontScale
          ? _self.savedFontScale
          : savedFontScale // ignore: cast_nullable_to_non_nullable
              as double,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
