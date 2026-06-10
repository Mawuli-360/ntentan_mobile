// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedicationState {
  List<Medication> get medications;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationStateCopyWith<MedicationState> get copyWith =>
      _$MedicationStateCopyWithImpl<MedicationState>(
          this as MedicationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationState &&
            const DeepCollectionEquality()
                .equals(other.medications, medications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(medications));

  @override
  String toString() {
    return 'MedicationState(medications: $medications)';
  }
}

/// @nodoc
abstract mixin class $MedicationStateCopyWith<$Res> {
  factory $MedicationStateCopyWith(
          MedicationState value, $Res Function(MedicationState) _then) =
      _$MedicationStateCopyWithImpl;
  @useResult
  $Res call({List<Medication> medications});
}

/// @nodoc
class _$MedicationStateCopyWithImpl<$Res>
    implements $MedicationStateCopyWith<$Res> {
  _$MedicationStateCopyWithImpl(this._self, this._then);

  final MedicationState _self;
  final $Res Function(MedicationState) _then;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medications = null,
  }) {
    return _then(_self.copyWith(
      medications: null == medications
          ? _self.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
    ));
  }
}

/// @nodoc

class MedicationInitial extends MedicationState {
  const MedicationInitial({final List<Medication> medications = const []})
      : _medications = medications,
        super._();

  final List<Medication> _medications;
  @override
  @JsonKey()
  List<Medication> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationInitialCopyWith<MedicationInitial> get copyWith =>
      _$MedicationInitialCopyWithImpl<MedicationInitial>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationInitial &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_medications));

  @override
  String toString() {
    return 'MedicationState.initial(medications: $medications)';
  }
}

/// @nodoc
abstract mixin class $MedicationInitialCopyWith<$Res>
    implements $MedicationStateCopyWith<$Res> {
  factory $MedicationInitialCopyWith(
          MedicationInitial value, $Res Function(MedicationInitial) _then) =
      _$MedicationInitialCopyWithImpl;
  @override
  @useResult
  $Res call({List<Medication> medications});
}

/// @nodoc
class _$MedicationInitialCopyWithImpl<$Res>
    implements $MedicationInitialCopyWith<$Res> {
  _$MedicationInitialCopyWithImpl(this._self, this._then);

  final MedicationInitial _self;
  final $Res Function(MedicationInitial) _then;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medications = null,
  }) {
    return _then(MedicationInitial(
      medications: null == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
    ));
  }
}

/// @nodoc

class MedicationLoading extends MedicationState {
  const MedicationLoading({required final List<Medication> medications})
      : _medications = medications,
        super._();

  final List<Medication> _medications;
  @override
  List<Medication> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationLoadingCopyWith<MedicationLoading> get copyWith =>
      _$MedicationLoadingCopyWithImpl<MedicationLoading>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationLoading &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_medications));

  @override
  String toString() {
    return 'MedicationState.loading(medications: $medications)';
  }
}

/// @nodoc
abstract mixin class $MedicationLoadingCopyWith<$Res>
    implements $MedicationStateCopyWith<$Res> {
  factory $MedicationLoadingCopyWith(
          MedicationLoading value, $Res Function(MedicationLoading) _then) =
      _$MedicationLoadingCopyWithImpl;
  @override
  @useResult
  $Res call({List<Medication> medications});
}

/// @nodoc
class _$MedicationLoadingCopyWithImpl<$Res>
    implements $MedicationLoadingCopyWith<$Res> {
  _$MedicationLoadingCopyWithImpl(this._self, this._then);

  final MedicationLoading _self;
  final $Res Function(MedicationLoading) _then;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medications = null,
  }) {
    return _then(MedicationLoading(
      medications: null == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
    ));
  }
}

/// @nodoc

class MedicationLoaded extends MedicationState {
  const MedicationLoaded({required final List<Medication> medications})
      : _medications = medications,
        super._();

  final List<Medication> _medications;
  @override
  List<Medication> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationLoadedCopyWith<MedicationLoaded> get copyWith =>
      _$MedicationLoadedCopyWithImpl<MedicationLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationLoaded &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_medications));

  @override
  String toString() {
    return 'MedicationState.loaded(medications: $medications)';
  }
}

/// @nodoc
abstract mixin class $MedicationLoadedCopyWith<$Res>
    implements $MedicationStateCopyWith<$Res> {
  factory $MedicationLoadedCopyWith(
          MedicationLoaded value, $Res Function(MedicationLoaded) _then) =
      _$MedicationLoadedCopyWithImpl;
  @override
  @useResult
  $Res call({List<Medication> medications});
}

/// @nodoc
class _$MedicationLoadedCopyWithImpl<$Res>
    implements $MedicationLoadedCopyWith<$Res> {
  _$MedicationLoadedCopyWithImpl(this._self, this._then);

  final MedicationLoaded _self;
  final $Res Function(MedicationLoaded) _then;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medications = null,
  }) {
    return _then(MedicationLoaded(
      medications: null == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
    ));
  }
}

/// @nodoc

class MedicationError extends MedicationState {
  const MedicationError(
      {required final List<Medication> medications, required this.message})
      : _medications = medications,
        super._();

  final List<Medication> _medications;
  @override
  List<Medication> get medications {
    if (_medications is EqualUnmodifiableListView) return _medications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medications);
  }

  final String message;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationErrorCopyWith<MedicationError> get copyWith =>
      _$MedicationErrorCopyWithImpl<MedicationError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicationError &&
            const DeepCollectionEquality()
                .equals(other._medications, _medications) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_medications), message);

  @override
  String toString() {
    return 'MedicationState.error(medications: $medications, message: $message)';
  }
}

/// @nodoc
abstract mixin class $MedicationErrorCopyWith<$Res>
    implements $MedicationStateCopyWith<$Res> {
  factory $MedicationErrorCopyWith(
          MedicationError value, $Res Function(MedicationError) _then) =
      _$MedicationErrorCopyWithImpl;
  @override
  @useResult
  $Res call({List<Medication> medications, String message});
}

/// @nodoc
class _$MedicationErrorCopyWithImpl<$Res>
    implements $MedicationErrorCopyWith<$Res> {
  _$MedicationErrorCopyWithImpl(this._self, this._then);

  final MedicationError _self;
  final $Res Function(MedicationError) _then;

  /// Create a copy of MedicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? medications = null,
    Object? message = null,
  }) {
    return _then(MedicationError(
      medications: null == medications
          ? _self._medications
          : medications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
