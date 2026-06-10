// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Medication {
  String get id;
  String get name;
  String get dosage;
  String get strength;
  int get unitsPerDose;
  int get frequency;
  List<MedTimeSlot> get timeSlots;
  Map<String, DateTime> get completedSlots;
  String get instruction;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicationCopyWith<Medication> get copyWith =>
      _$MedicationCopyWithImpl<Medication>(this as Medication, _$identity);

  /// Serializes this Medication to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Medication &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.strength, strength) ||
                other.strength == strength) &&
            (identical(other.unitsPerDose, unitsPerDose) ||
                other.unitsPerDose == unitsPerDose) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(other.timeSlots, timeSlots) &&
            const DeepCollectionEquality()
                .equals(other.completedSlots, completedSlots) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dosage,
      strength,
      unitsPerDose,
      frequency,
      const DeepCollectionEquality().hash(timeSlots),
      const DeepCollectionEquality().hash(completedSlots),
      instruction,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Medication(id: $id, name: $name, dosage: $dosage, strength: $strength, unitsPerDose: $unitsPerDose, frequency: $frequency, timeSlots: $timeSlots, completedSlots: $completedSlots, instruction: $instruction, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $MedicationCopyWith<$Res> {
  factory $MedicationCopyWith(
          Medication value, $Res Function(Medication) _then) =
      _$MedicationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String dosage,
      String strength,
      int unitsPerDose,
      int frequency,
      List<MedTimeSlot> timeSlots,
      Map<String, DateTime> completedSlots,
      String instruction,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$MedicationCopyWithImpl<$Res> implements $MedicationCopyWith<$Res> {
  _$MedicationCopyWithImpl(this._self, this._then);

  final Medication _self;
  final $Res Function(Medication) _then;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dosage = null,
    Object? strength = null,
    Object? unitsPerDose = null,
    Object? frequency = null,
    Object? timeSlots = null,
    Object? completedSlots = null,
    Object? instruction = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _self.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      strength: null == strength
          ? _self.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as String,
      unitsPerDose: null == unitsPerDose
          ? _self.unitsPerDose
          : unitsPerDose // ignore: cast_nullable_to_non_nullable
              as int,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      timeSlots: null == timeSlots
          ? _self.timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<MedTimeSlot>,
      completedSlots: null == completedSlots
          ? _self.completedSlots
          : completedSlots // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Medication implements Medication {
  const _Medication(
      {required this.id,
      required this.name,
      required this.dosage,
      this.strength = '',
      this.unitsPerDose = 1,
      this.frequency = 1,
      required final List<MedTimeSlot> timeSlots,
      final Map<String, DateTime> completedSlots = const {},
      required this.instruction,
      this.createdAt,
      this.updatedAt})
      : _timeSlots = timeSlots,
        _completedSlots = completedSlots;
  factory _Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String dosage;
  @override
  @JsonKey()
  final String strength;
  @override
  @JsonKey()
  final int unitsPerDose;
  @override
  @JsonKey()
  final int frequency;
  final List<MedTimeSlot> _timeSlots;
  @override
  List<MedTimeSlot> get timeSlots {
    if (_timeSlots is EqualUnmodifiableListView) return _timeSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeSlots);
  }

  final Map<String, DateTime> _completedSlots;
  @override
  @JsonKey()
  Map<String, DateTime> get completedSlots {
    if (_completedSlots is EqualUnmodifiableMapView) return _completedSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_completedSlots);
  }

  @override
  final String instruction;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicationCopyWith<_Medication> get copyWith =>
      __$MedicationCopyWithImpl<_Medication>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Medication &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.strength, strength) ||
                other.strength == strength) &&
            (identical(other.unitsPerDose, unitsPerDose) ||
                other.unitsPerDose == unitsPerDose) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality()
                .equals(other._timeSlots, _timeSlots) &&
            const DeepCollectionEquality()
                .equals(other._completedSlots, _completedSlots) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dosage,
      strength,
      unitsPerDose,
      frequency,
      const DeepCollectionEquality().hash(_timeSlots),
      const DeepCollectionEquality().hash(_completedSlots),
      instruction,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Medication(id: $id, name: $name, dosage: $dosage, strength: $strength, unitsPerDose: $unitsPerDose, frequency: $frequency, timeSlots: $timeSlots, completedSlots: $completedSlots, instruction: $instruction, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$MedicationCopyWith<$Res>
    implements $MedicationCopyWith<$Res> {
  factory _$MedicationCopyWith(
          _Medication value, $Res Function(_Medication) _then) =
      __$MedicationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String dosage,
      String strength,
      int unitsPerDose,
      int frequency,
      List<MedTimeSlot> timeSlots,
      Map<String, DateTime> completedSlots,
      String instruction,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$MedicationCopyWithImpl<$Res> implements _$MedicationCopyWith<$Res> {
  __$MedicationCopyWithImpl(this._self, this._then);

  final _Medication _self;
  final $Res Function(_Medication) _then;

  /// Create a copy of Medication
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dosage = null,
    Object? strength = null,
    Object? unitsPerDose = null,
    Object? frequency = null,
    Object? timeSlots = null,
    Object? completedSlots = null,
    Object? instruction = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Medication(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: null == dosage
          ? _self.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      strength: null == strength
          ? _self.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as String,
      unitsPerDose: null == unitsPerDose
          ? _self.unitsPerDose
          : unitsPerDose // ignore: cast_nullable_to_non_nullable
              as int,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
      timeSlots: null == timeSlots
          ? _self._timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<MedTimeSlot>,
      completedSlots: null == completedSlots
          ? _self._completedSlots
          : completedSlots // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
