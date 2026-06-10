// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProfileState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProfileState()';
  }
}

/// @nodoc
class $ProfileStateCopyWith<$Res> {
  $ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}

/// @nodoc

class ProfileStateInitial extends ProfileState {
  const ProfileStateInitial() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProfileStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProfileState.initial()';
  }
}

/// @nodoc

class ProfileStateLoading extends ProfileState {
  const ProfileStateLoading() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProfileStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProfileState.loading()';
  }
}

/// @nodoc

class ProfileStateLoaded extends ProfileState {
  const ProfileStateLoaded(this.profile, {this.currentStep = 0}) : super._();

  final UserEntity profile;
  @JsonKey()
  final int currentStep;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileStateLoadedCopyWith<ProfileStateLoaded> get copyWith =>
      _$ProfileStateLoadedCopyWithImpl<ProfileStateLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileStateLoaded &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, currentStep);

  @override
  String toString() {
    return 'ProfileState.loaded(profile: $profile, currentStep: $currentStep)';
  }
}

/// @nodoc
abstract mixin class $ProfileStateLoadedCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory $ProfileStateLoadedCopyWith(
          ProfileStateLoaded value, $Res Function(ProfileStateLoaded) _then) =
      _$ProfileStateLoadedCopyWithImpl;
  @useResult
  $Res call({UserEntity profile, int currentStep});

  $UserEntityCopyWith<$Res> get profile;
}

/// @nodoc
class _$ProfileStateLoadedCopyWithImpl<$Res>
    implements $ProfileStateLoadedCopyWith<$Res> {
  _$ProfileStateLoadedCopyWithImpl(this._self, this._then);

  final ProfileStateLoaded _self;
  final $Res Function(ProfileStateLoaded) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? profile = null,
    Object? currentStep = null,
  }) {
    return _then(ProfileStateLoaded(
      null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get profile {
    return $UserEntityCopyWith<$Res>(_self.profile, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

/// @nodoc

class ProfileStateSaving extends ProfileState {
  const ProfileStateSaving(this.profile, {this.currentStep = 0}) : super._();

  final UserEntity profile;
  @JsonKey()
  final int currentStep;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileStateSavingCopyWith<ProfileStateSaving> get copyWith =>
      _$ProfileStateSavingCopyWithImpl<ProfileStateSaving>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileStateSaving &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, currentStep);

  @override
  String toString() {
    return 'ProfileState.saving(profile: $profile, currentStep: $currentStep)';
  }
}

/// @nodoc
abstract mixin class $ProfileStateSavingCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory $ProfileStateSavingCopyWith(
          ProfileStateSaving value, $Res Function(ProfileStateSaving) _then) =
      _$ProfileStateSavingCopyWithImpl;
  @useResult
  $Res call({UserEntity profile, int currentStep});

  $UserEntityCopyWith<$Res> get profile;
}

/// @nodoc
class _$ProfileStateSavingCopyWithImpl<$Res>
    implements $ProfileStateSavingCopyWith<$Res> {
  _$ProfileStateSavingCopyWithImpl(this._self, this._then);

  final ProfileStateSaving _self;
  final $Res Function(ProfileStateSaving) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? profile = null,
    Object? currentStep = null,
  }) {
    return _then(ProfileStateSaving(
      null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get profile {
    return $UserEntityCopyWith<$Res>(_self.profile, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

/// @nodoc

class ProfileStateError extends ProfileState {
  const ProfileStateError(this.message, this.profile, {this.currentStep = 0})
      : super._();

  final String message;
  final UserEntity profile;
  @JsonKey()
  final int currentStep;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileStateErrorCopyWith<ProfileStateError> get copyWith =>
      _$ProfileStateErrorCopyWithImpl<ProfileStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileStateError &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, profile, currentStep);

  @override
  String toString() {
    return 'ProfileState.error(message: $message, profile: $profile, currentStep: $currentStep)';
  }
}

/// @nodoc
abstract mixin class $ProfileStateErrorCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory $ProfileStateErrorCopyWith(
          ProfileStateError value, $Res Function(ProfileStateError) _then) =
      _$ProfileStateErrorCopyWithImpl;
  @useResult
  $Res call({String message, UserEntity profile, int currentStep});

  $UserEntityCopyWith<$Res> get profile;
}

/// @nodoc
class _$ProfileStateErrorCopyWithImpl<$Res>
    implements $ProfileStateErrorCopyWith<$Res> {
  _$ProfileStateErrorCopyWithImpl(this._self, this._then);

  final ProfileStateError _self;
  final $Res Function(ProfileStateError) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? profile = null,
    Object? currentStep = null,
  }) {
    return _then(ProfileStateError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserEntity,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get profile {
    return $UserEntityCopyWith<$Res>(_self.profile, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

// dart format on
