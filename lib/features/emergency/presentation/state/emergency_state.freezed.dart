// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emergency_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmergencyState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmergencyState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EmergencyState()';
  }
}

/// @nodoc
class $EmergencyStateCopyWith<$Res> {
  $EmergencyStateCopyWith(EmergencyState _, $Res Function(EmergencyState) __);
}

/// @nodoc

class EmergencyIdle extends EmergencyState {
  const EmergencyIdle() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmergencyIdle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EmergencyState.idle()';
  }
}

/// @nodoc

class EmergencyCountingDown extends EmergencyState {
  const EmergencyCountingDown(
      {this.countdown = 5, required this.lastTrigger, this.silentMode = false})
      : super._();

  @JsonKey()
  final int countdown;
  final SosTrigger lastTrigger;
  @JsonKey()
  final bool silentMode;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencyCountingDownCopyWith<EmergencyCountingDown> get copyWith =>
      _$EmergencyCountingDownCopyWithImpl<EmergencyCountingDown>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencyCountingDown &&
            (identical(other.countdown, countdown) ||
                other.countdown == countdown) &&
            (identical(other.lastTrigger, lastTrigger) ||
                other.lastTrigger == lastTrigger) &&
            (identical(other.silentMode, silentMode) ||
                other.silentMode == silentMode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, countdown, lastTrigger, silentMode);

  @override
  String toString() {
    return 'EmergencyState.countingDown(countdown: $countdown, lastTrigger: $lastTrigger, silentMode: $silentMode)';
  }
}

/// @nodoc
abstract mixin class $EmergencyCountingDownCopyWith<$Res>
    implements $EmergencyStateCopyWith<$Res> {
  factory $EmergencyCountingDownCopyWith(EmergencyCountingDown value,
          $Res Function(EmergencyCountingDown) _then) =
      _$EmergencyCountingDownCopyWithImpl;
  @useResult
  $Res call({int countdown, SosTrigger lastTrigger, bool silentMode});
}

/// @nodoc
class _$EmergencyCountingDownCopyWithImpl<$Res>
    implements $EmergencyCountingDownCopyWith<$Res> {
  _$EmergencyCountingDownCopyWithImpl(this._self, this._then);

  final EmergencyCountingDown _self;
  final $Res Function(EmergencyCountingDown) _then;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? countdown = null,
    Object? lastTrigger = null,
    Object? silentMode = null,
  }) {
    return _then(EmergencyCountingDown(
      countdown: null == countdown
          ? _self.countdown
          : countdown // ignore: cast_nullable_to_non_nullable
              as int,
      lastTrigger: null == lastTrigger
          ? _self.lastTrigger
          : lastTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      silentMode: null == silentMode
          ? _self.silentMode
          : silentMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class EmergencySending extends EmergencyState {
  const EmergencySending(
      {required this.lastTrigger,
      this.silentMode = false,
      this.gpsShared = false,
      this.medicalInfoShared = false})
      : super._();

  final SosTrigger lastTrigger;
  @JsonKey()
  final bool silentMode;
  @JsonKey()
  final bool gpsShared;
  @JsonKey()
  final bool medicalInfoShared;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencySendingCopyWith<EmergencySending> get copyWith =>
      _$EmergencySendingCopyWithImpl<EmergencySending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencySending &&
            (identical(other.lastTrigger, lastTrigger) ||
                other.lastTrigger == lastTrigger) &&
            (identical(other.silentMode, silentMode) ||
                other.silentMode == silentMode) &&
            (identical(other.gpsShared, gpsShared) ||
                other.gpsShared == gpsShared) &&
            (identical(other.medicalInfoShared, medicalInfoShared) ||
                other.medicalInfoShared == medicalInfoShared));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, lastTrigger, silentMode, gpsShared, medicalInfoShared);

  @override
  String toString() {
    return 'EmergencyState.sending(lastTrigger: $lastTrigger, silentMode: $silentMode, gpsShared: $gpsShared, medicalInfoShared: $medicalInfoShared)';
  }
}

/// @nodoc
abstract mixin class $EmergencySendingCopyWith<$Res>
    implements $EmergencyStateCopyWith<$Res> {
  factory $EmergencySendingCopyWith(
          EmergencySending value, $Res Function(EmergencySending) _then) =
      _$EmergencySendingCopyWithImpl;
  @useResult
  $Res call(
      {SosTrigger lastTrigger,
      bool silentMode,
      bool gpsShared,
      bool medicalInfoShared});
}

/// @nodoc
class _$EmergencySendingCopyWithImpl<$Res>
    implements $EmergencySendingCopyWith<$Res> {
  _$EmergencySendingCopyWithImpl(this._self, this._then);

  final EmergencySending _self;
  final $Res Function(EmergencySending) _then;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastTrigger = null,
    Object? silentMode = null,
    Object? gpsShared = null,
    Object? medicalInfoShared = null,
  }) {
    return _then(EmergencySending(
      lastTrigger: null == lastTrigger
          ? _self.lastTrigger
          : lastTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      silentMode: null == silentMode
          ? _self.silentMode
          : silentMode // ignore: cast_nullable_to_non_nullable
              as bool,
      gpsShared: null == gpsShared
          ? _self.gpsShared
          : gpsShared // ignore: cast_nullable_to_non_nullable
              as bool,
      medicalInfoShared: null == medicalInfoShared
          ? _self.medicalInfoShared
          : medicalInfoShared // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class EmergencySent extends EmergencyState {
  const EmergencySent(
      {required this.lastTrigger,
      this.silentMode = false,
      this.gpsShared = false,
      this.medicalInfoShared = false,
      this.contactsNotified = false,
      final List<NotifiedContact> notifiedContacts = const [],
      this.showHelperCard = false})
      : _notifiedContacts = notifiedContacts,
        super._();

  final SosTrigger lastTrigger;
  @JsonKey()
  final bool silentMode;
  @JsonKey()
  final bool gpsShared;
  @JsonKey()
  final bool medicalInfoShared;
  @JsonKey()
  final bool contactsNotified;
  final List<NotifiedContact> _notifiedContacts;
  @JsonKey()
  List<NotifiedContact> get notifiedContacts {
    if (_notifiedContacts is EqualUnmodifiableListView)
      return _notifiedContacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifiedContacts);
  }

  @JsonKey()
  final bool showHelperCard;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencySentCopyWith<EmergencySent> get copyWith =>
      _$EmergencySentCopyWithImpl<EmergencySent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencySent &&
            (identical(other.lastTrigger, lastTrigger) ||
                other.lastTrigger == lastTrigger) &&
            (identical(other.silentMode, silentMode) ||
                other.silentMode == silentMode) &&
            (identical(other.gpsShared, gpsShared) ||
                other.gpsShared == gpsShared) &&
            (identical(other.medicalInfoShared, medicalInfoShared) ||
                other.medicalInfoShared == medicalInfoShared) &&
            (identical(other.contactsNotified, contactsNotified) ||
                other.contactsNotified == contactsNotified) &&
            const DeepCollectionEquality()
                .equals(other._notifiedContacts, _notifiedContacts) &&
            (identical(other.showHelperCard, showHelperCard) ||
                other.showHelperCard == showHelperCard));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastTrigger,
      silentMode,
      gpsShared,
      medicalInfoShared,
      contactsNotified,
      const DeepCollectionEquality().hash(_notifiedContacts),
      showHelperCard);

  @override
  String toString() {
    return 'EmergencyState.sent(lastTrigger: $lastTrigger, silentMode: $silentMode, gpsShared: $gpsShared, medicalInfoShared: $medicalInfoShared, contactsNotified: $contactsNotified, notifiedContacts: $notifiedContacts, showHelperCard: $showHelperCard)';
  }
}

/// @nodoc
abstract mixin class $EmergencySentCopyWith<$Res>
    implements $EmergencyStateCopyWith<$Res> {
  factory $EmergencySentCopyWith(
          EmergencySent value, $Res Function(EmergencySent) _then) =
      _$EmergencySentCopyWithImpl;
  @useResult
  $Res call(
      {SosTrigger lastTrigger,
      bool silentMode,
      bool gpsShared,
      bool medicalInfoShared,
      bool contactsNotified,
      List<NotifiedContact> notifiedContacts,
      bool showHelperCard});
}

/// @nodoc
class _$EmergencySentCopyWithImpl<$Res>
    implements $EmergencySentCopyWith<$Res> {
  _$EmergencySentCopyWithImpl(this._self, this._then);

  final EmergencySent _self;
  final $Res Function(EmergencySent) _then;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastTrigger = null,
    Object? silentMode = null,
    Object? gpsShared = null,
    Object? medicalInfoShared = null,
    Object? contactsNotified = null,
    Object? notifiedContacts = null,
    Object? showHelperCard = null,
  }) {
    return _then(EmergencySent(
      lastTrigger: null == lastTrigger
          ? _self.lastTrigger
          : lastTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      silentMode: null == silentMode
          ? _self.silentMode
          : silentMode // ignore: cast_nullable_to_non_nullable
              as bool,
      gpsShared: null == gpsShared
          ? _self.gpsShared
          : gpsShared // ignore: cast_nullable_to_non_nullable
              as bool,
      medicalInfoShared: null == medicalInfoShared
          ? _self.medicalInfoShared
          : medicalInfoShared // ignore: cast_nullable_to_non_nullable
              as bool,
      contactsNotified: null == contactsNotified
          ? _self.contactsNotified
          : contactsNotified // ignore: cast_nullable_to_non_nullable
              as bool,
      notifiedContacts: null == notifiedContacts
          ? _self._notifiedContacts
          : notifiedContacts // ignore: cast_nullable_to_non_nullable
              as List<NotifiedContact>,
      showHelperCard: null == showHelperCard
          ? _self.showHelperCard
          : showHelperCard // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class EmergencyError extends EmergencyState {
  const EmergencyError(
      {required this.lastTrigger,
      this.silentMode = false,
      required this.message})
      : super._();

  final SosTrigger lastTrigger;
  @JsonKey()
  final bool silentMode;
  final String message;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencyErrorCopyWith<EmergencyError> get copyWith =>
      _$EmergencyErrorCopyWithImpl<EmergencyError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencyError &&
            (identical(other.lastTrigger, lastTrigger) ||
                other.lastTrigger == lastTrigger) &&
            (identical(other.silentMode, silentMode) ||
                other.silentMode == silentMode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lastTrigger, silentMode, message);

  @override
  String toString() {
    return 'EmergencyState.error(lastTrigger: $lastTrigger, silentMode: $silentMode, message: $message)';
  }
}

/// @nodoc
abstract mixin class $EmergencyErrorCopyWith<$Res>
    implements $EmergencyStateCopyWith<$Res> {
  factory $EmergencyErrorCopyWith(
          EmergencyError value, $Res Function(EmergencyError) _then) =
      _$EmergencyErrorCopyWithImpl;
  @useResult
  $Res call({SosTrigger lastTrigger, bool silentMode, String message});
}

/// @nodoc
class _$EmergencyErrorCopyWithImpl<$Res>
    implements $EmergencyErrorCopyWith<$Res> {
  _$EmergencyErrorCopyWithImpl(this._self, this._then);

  final EmergencyError _self;
  final $Res Function(EmergencyError) _then;

  /// Create a copy of EmergencyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lastTrigger = null,
    Object? silentMode = null,
    Object? message = null,
  }) {
    return _then(EmergencyError(
      lastTrigger: null == lastTrigger
          ? _self.lastTrigger
          : lastTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      silentMode: null == silentMode
          ? _self.silentMode
          : silentMode // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class EmergencyPostActive extends EmergencyState {
  const EmergencyPostActive() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmergencyPostActive);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EmergencyState.postEmergency()';
  }
}

// dart format on
