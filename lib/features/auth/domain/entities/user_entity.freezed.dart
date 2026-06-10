// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccessibilitySettings {
  /// Turn on high contrast mode to help users with low vision see things more clearly.
  bool get highContrastEnabled;

  /// Does the user rely on a screen reader like TalkBack?
  bool get screenReaderEnabled;

  /// Let the phone buzz when we need their attention or when they successfully tap something.
  bool get vibrationEnabled;

  /// How big do they want the text? 1.0 is the default, but we can crank it up if they need it.
  double get fontScale;

  /// Turn off bouncy or flashy animations if they get motion sickness easily.
  bool get reduceMotionEnabled;

  /// Adjust colors for specific types of color blindness.
  ColorBlindnessMode get colorBlindnessMode;

  /// Flash the screen for important alerts (super helpful if they can't hear notifications).
  bool get visualFlashEnabled;

  /// Should we remind them to take their meds?
  bool get medicationRemindersEnabled;

  /// A special toggle to magnify the entire screen, not just the text.
  bool get magnifyScreenEnabled;

  /// We save their old font scale here so we can restore it if they turn the magnifier off.
  double get savedFontScale;

  /// Create a copy of AccessibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccessibilitySettingsCopyWith<AccessibilitySettings> get copyWith =>
      _$AccessibilitySettingsCopyWithImpl<AccessibilitySettings>(
          this as AccessibilitySettings, _$identity);

  /// Serializes this AccessibilitySettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccessibilitySettings &&
            (identical(other.highContrastEnabled, highContrastEnabled) ||
                other.highContrastEnabled == highContrastEnabled) &&
            (identical(other.screenReaderEnabled, screenReaderEnabled) ||
                other.screenReaderEnabled == screenReaderEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.fontScale, fontScale) ||
                other.fontScale == fontScale) &&
            (identical(other.reduceMotionEnabled, reduceMotionEnabled) ||
                other.reduceMotionEnabled == reduceMotionEnabled) &&
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
                other.savedFontScale == savedFontScale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      highContrastEnabled,
      screenReaderEnabled,
      vibrationEnabled,
      fontScale,
      reduceMotionEnabled,
      colorBlindnessMode,
      visualFlashEnabled,
      medicationRemindersEnabled,
      magnifyScreenEnabled,
      savedFontScale);

  @override
  String toString() {
    return 'AccessibilitySettings(highContrastEnabled: $highContrastEnabled, screenReaderEnabled: $screenReaderEnabled, vibrationEnabled: $vibrationEnabled, fontScale: $fontScale, reduceMotionEnabled: $reduceMotionEnabled, colorBlindnessMode: $colorBlindnessMode, visualFlashEnabled: $visualFlashEnabled, medicationRemindersEnabled: $medicationRemindersEnabled, magnifyScreenEnabled: $magnifyScreenEnabled, savedFontScale: $savedFontScale)';
  }
}

/// @nodoc
abstract mixin class $AccessibilitySettingsCopyWith<$Res> {
  factory $AccessibilitySettingsCopyWith(AccessibilitySettings value,
          $Res Function(AccessibilitySettings) _then) =
      _$AccessibilitySettingsCopyWithImpl;
  @useResult
  $Res call(
      {bool highContrastEnabled,
      bool screenReaderEnabled,
      bool vibrationEnabled,
      double fontScale,
      bool reduceMotionEnabled,
      ColorBlindnessMode colorBlindnessMode,
      bool visualFlashEnabled,
      bool medicationRemindersEnabled,
      bool magnifyScreenEnabled,
      double savedFontScale});
}

/// @nodoc
class _$AccessibilitySettingsCopyWithImpl<$Res>
    implements $AccessibilitySettingsCopyWith<$Res> {
  _$AccessibilitySettingsCopyWithImpl(this._self, this._then);

  final AccessibilitySettings _self;
  final $Res Function(AccessibilitySettings) _then;

  /// Create a copy of AccessibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highContrastEnabled = null,
    Object? screenReaderEnabled = null,
    Object? vibrationEnabled = null,
    Object? fontScale = null,
    Object? reduceMotionEnabled = null,
    Object? colorBlindnessMode = null,
    Object? visualFlashEnabled = null,
    Object? medicationRemindersEnabled = null,
    Object? magnifyScreenEnabled = null,
    Object? savedFontScale = null,
  }) {
    return _then(_self.copyWith(
      highContrastEnabled: null == highContrastEnabled
          ? _self.highContrastEnabled
          : highContrastEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
      reduceMotionEnabled: null == reduceMotionEnabled
          ? _self.reduceMotionEnabled
          : reduceMotionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AccessibilitySettings implements AccessibilitySettings {
  const _AccessibilitySettings(
      {this.highContrastEnabled = false,
      this.screenReaderEnabled = false,
      this.vibrationEnabled = true,
      this.fontScale = 1.0,
      this.reduceMotionEnabled = false,
      this.colorBlindnessMode = ColorBlindnessMode.none,
      this.visualFlashEnabled = true,
      this.medicationRemindersEnabled = true,
      this.magnifyScreenEnabled = false,
      this.savedFontScale = 1.3});
  factory _AccessibilitySettings.fromJson(Map<String, dynamic> json) =>
      _$AccessibilitySettingsFromJson(json);

  /// Turn on high contrast mode to help users with low vision see things more clearly.
  @override
  @JsonKey()
  final bool highContrastEnabled;

  /// Does the user rely on a screen reader like TalkBack?
  @override
  @JsonKey()
  final bool screenReaderEnabled;

  /// Let the phone buzz when we need their attention or when they successfully tap something.
  @override
  @JsonKey()
  final bool vibrationEnabled;

  /// How big do they want the text? 1.0 is the default, but we can crank it up if they need it.
  @override
  @JsonKey()
  final double fontScale;

  /// Turn off bouncy or flashy animations if they get motion sickness easily.
  @override
  @JsonKey()
  final bool reduceMotionEnabled;

  /// Adjust colors for specific types of color blindness.
  @override
  @JsonKey()
  final ColorBlindnessMode colorBlindnessMode;

  /// Flash the screen for important alerts (super helpful if they can't hear notifications).
  @override
  @JsonKey()
  final bool visualFlashEnabled;

  /// Should we remind them to take their meds?
  @override
  @JsonKey()
  final bool medicationRemindersEnabled;

  /// A special toggle to magnify the entire screen, not just the text.
  @override
  @JsonKey()
  final bool magnifyScreenEnabled;

  /// We save their old font scale here so we can restore it if they turn the magnifier off.
  @override
  @JsonKey()
  final double savedFontScale;

  /// Create a copy of AccessibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccessibilitySettingsCopyWith<_AccessibilitySettings> get copyWith =>
      __$AccessibilitySettingsCopyWithImpl<_AccessibilitySettings>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccessibilitySettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccessibilitySettings &&
            (identical(other.highContrastEnabled, highContrastEnabled) ||
                other.highContrastEnabled == highContrastEnabled) &&
            (identical(other.screenReaderEnabled, screenReaderEnabled) ||
                other.screenReaderEnabled == screenReaderEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.fontScale, fontScale) ||
                other.fontScale == fontScale) &&
            (identical(other.reduceMotionEnabled, reduceMotionEnabled) ||
                other.reduceMotionEnabled == reduceMotionEnabled) &&
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
                other.savedFontScale == savedFontScale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      highContrastEnabled,
      screenReaderEnabled,
      vibrationEnabled,
      fontScale,
      reduceMotionEnabled,
      colorBlindnessMode,
      visualFlashEnabled,
      medicationRemindersEnabled,
      magnifyScreenEnabled,
      savedFontScale);

  @override
  String toString() {
    return 'AccessibilitySettings(highContrastEnabled: $highContrastEnabled, screenReaderEnabled: $screenReaderEnabled, vibrationEnabled: $vibrationEnabled, fontScale: $fontScale, reduceMotionEnabled: $reduceMotionEnabled, colorBlindnessMode: $colorBlindnessMode, visualFlashEnabled: $visualFlashEnabled, medicationRemindersEnabled: $medicationRemindersEnabled, magnifyScreenEnabled: $magnifyScreenEnabled, savedFontScale: $savedFontScale)';
  }
}

/// @nodoc
abstract mixin class _$AccessibilitySettingsCopyWith<$Res>
    implements $AccessibilitySettingsCopyWith<$Res> {
  factory _$AccessibilitySettingsCopyWith(_AccessibilitySettings value,
          $Res Function(_AccessibilitySettings) _then) =
      __$AccessibilitySettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool highContrastEnabled,
      bool screenReaderEnabled,
      bool vibrationEnabled,
      double fontScale,
      bool reduceMotionEnabled,
      ColorBlindnessMode colorBlindnessMode,
      bool visualFlashEnabled,
      bool medicationRemindersEnabled,
      bool magnifyScreenEnabled,
      double savedFontScale});
}

/// @nodoc
class __$AccessibilitySettingsCopyWithImpl<$Res>
    implements _$AccessibilitySettingsCopyWith<$Res> {
  __$AccessibilitySettingsCopyWithImpl(this._self, this._then);

  final _AccessibilitySettings _self;
  final $Res Function(_AccessibilitySettings) _then;

  /// Create a copy of AccessibilitySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? highContrastEnabled = null,
    Object? screenReaderEnabled = null,
    Object? vibrationEnabled = null,
    Object? fontScale = null,
    Object? reduceMotionEnabled = null,
    Object? colorBlindnessMode = null,
    Object? visualFlashEnabled = null,
    Object? medicationRemindersEnabled = null,
    Object? magnifyScreenEnabled = null,
    Object? savedFontScale = null,
  }) {
    return _then(_AccessibilitySettings(
      highContrastEnabled: null == highContrastEnabled
          ? _self.highContrastEnabled
          : highContrastEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
      reduceMotionEnabled: null == reduceMotionEnabled
          ? _self.reduceMotionEnabled
          : reduceMotionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ));
  }
}

/// @nodoc
mixin _$EmergencyContact {
  /// The contact's full name.
  String get name;

  /// Their phone number so we can automatically text them during an SOS.
  String get phoneNumber;

  /// How do they know the user? (e.g., "Spouse", "Doctor")
  String get relationship;

  /// Create a copy of EmergencyContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencyContactCopyWith<EmergencyContact> get copyWith =>
      _$EmergencyContactCopyWithImpl<EmergencyContact>(
          this as EmergencyContact, _$identity);

  /// Serializes this EmergencyContact to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencyContact &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, phoneNumber, relationship);

  @override
  String toString() {
    return 'EmergencyContact(name: $name, phoneNumber: $phoneNumber, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class $EmergencyContactCopyWith<$Res> {
  factory $EmergencyContactCopyWith(
          EmergencyContact value, $Res Function(EmergencyContact) _then) =
      _$EmergencyContactCopyWithImpl;
  @useResult
  $Res call({String name, String phoneNumber, String relationship});
}

/// @nodoc
class _$EmergencyContactCopyWithImpl<$Res>
    implements $EmergencyContactCopyWith<$Res> {
  _$EmergencyContactCopyWithImpl(this._self, this._then);

  final EmergencyContact _self;
  final $Res Function(EmergencyContact) _then;

  /// Create a copy of EmergencyContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phoneNumber = null,
    Object? relationship = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EmergencyContact implements EmergencyContact {
  const _EmergencyContact(
      {required this.name, required this.phoneNumber, this.relationship = ''});
  factory _EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  /// The contact's full name.
  @override
  final String name;

  /// Their phone number so we can automatically text them during an SOS.
  @override
  final String phoneNumber;

  /// How do they know the user? (e.g., "Spouse", "Doctor")
  @override
  @JsonKey()
  final String relationship;

  /// Create a copy of EmergencyContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmergencyContactCopyWith<_EmergencyContact> get copyWith =>
      __$EmergencyContactCopyWithImpl<_EmergencyContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmergencyContactToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmergencyContact &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, phoneNumber, relationship);

  @override
  String toString() {
    return 'EmergencyContact(name: $name, phoneNumber: $phoneNumber, relationship: $relationship)';
  }
}

/// @nodoc
abstract mixin class _$EmergencyContactCopyWith<$Res>
    implements $EmergencyContactCopyWith<$Res> {
  factory _$EmergencyContactCopyWith(
          _EmergencyContact value, $Res Function(_EmergencyContact) _then) =
      __$EmergencyContactCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String phoneNumber, String relationship});
}

/// @nodoc
class __$EmergencyContactCopyWithImpl<$Res>
    implements _$EmergencyContactCopyWith<$Res> {
  __$EmergencyContactCopyWithImpl(this._self, this._then);

  final _EmergencyContact _self;
  final $Res Function(_EmergencyContact) _then;

  /// Create a copy of EmergencyContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? phoneNumber = null,
    Object? relationship = null,
  }) {
    return _then(_EmergencyContact(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      relationship: null == relationship
          ? _self.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$EmergencyConfig {
  /// A list of people to contact in an emergency (the first one is the main contact).
  List<EmergencyContact> get contacts;

  /// How does the user want to trigger an SOS? (Voice? Shaking the phone? A big red button?)
  SosTrigger get preferredSosTrigger;

  /// Is it okay if we share their GPS location with their contacts during an emergency?
  bool get shareGpsOnSos;

  /// Is it okay if we share their medical info (like what meds they are on) with responders?
  bool get shareMedicalInfoOnSos;

  /// Any special medical notes responders should know immediately? (e.g., "I'm allergic to Penicillin")
  String get medicalNote;

  /// Create a copy of EmergencyConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmergencyConfigCopyWith<EmergencyConfig> get copyWith =>
      _$EmergencyConfigCopyWithImpl<EmergencyConfig>(
          this as EmergencyConfig, _$identity);

  /// Serializes this EmergencyConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmergencyConfig &&
            const DeepCollectionEquality().equals(other.contacts, contacts) &&
            (identical(other.preferredSosTrigger, preferredSosTrigger) ||
                other.preferredSosTrigger == preferredSosTrigger) &&
            (identical(other.shareGpsOnSos, shareGpsOnSos) ||
                other.shareGpsOnSos == shareGpsOnSos) &&
            (identical(other.shareMedicalInfoOnSos, shareMedicalInfoOnSos) ||
                other.shareMedicalInfoOnSos == shareMedicalInfoOnSos) &&
            (identical(other.medicalNote, medicalNote) ||
                other.medicalNote == medicalNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(contacts),
      preferredSosTrigger,
      shareGpsOnSos,
      shareMedicalInfoOnSos,
      medicalNote);

  @override
  String toString() {
    return 'EmergencyConfig(contacts: $contacts, preferredSosTrigger: $preferredSosTrigger, shareGpsOnSos: $shareGpsOnSos, shareMedicalInfoOnSos: $shareMedicalInfoOnSos, medicalNote: $medicalNote)';
  }
}

/// @nodoc
abstract mixin class $EmergencyConfigCopyWith<$Res> {
  factory $EmergencyConfigCopyWith(
          EmergencyConfig value, $Res Function(EmergencyConfig) _then) =
      _$EmergencyConfigCopyWithImpl;
  @useResult
  $Res call(
      {List<EmergencyContact> contacts,
      SosTrigger preferredSosTrigger,
      bool shareGpsOnSos,
      bool shareMedicalInfoOnSos,
      String medicalNote});
}

/// @nodoc
class _$EmergencyConfigCopyWithImpl<$Res>
    implements $EmergencyConfigCopyWith<$Res> {
  _$EmergencyConfigCopyWithImpl(this._self, this._then);

  final EmergencyConfig _self;
  final $Res Function(EmergencyConfig) _then;

  /// Create a copy of EmergencyConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
    Object? preferredSosTrigger = null,
    Object? shareGpsOnSos = null,
    Object? shareMedicalInfoOnSos = null,
    Object? medicalNote = null,
  }) {
    return _then(_self.copyWith(
      contacts: null == contacts
          ? _self.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<EmergencyContact>,
      preferredSosTrigger: null == preferredSosTrigger
          ? _self.preferredSosTrigger
          : preferredSosTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      shareGpsOnSos: null == shareGpsOnSos
          ? _self.shareGpsOnSos
          : shareGpsOnSos // ignore: cast_nullable_to_non_nullable
              as bool,
      shareMedicalInfoOnSos: null == shareMedicalInfoOnSos
          ? _self.shareMedicalInfoOnSos
          : shareMedicalInfoOnSos // ignore: cast_nullable_to_non_nullable
              as bool,
      medicalNote: null == medicalNote
          ? _self.medicalNote
          : medicalNote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EmergencyConfig implements EmergencyConfig {
  const _EmergencyConfig(
      {final List<EmergencyContact> contacts = const [],
      this.preferredSosTrigger = SosTrigger.button,
      this.shareGpsOnSos = true,
      this.shareMedicalInfoOnSos = true,
      this.medicalNote = ''})
      : _contacts = contacts;
  factory _EmergencyConfig.fromJson(Map<String, dynamic> json) =>
      _$EmergencyConfigFromJson(json);

  /// A list of people to contact in an emergency (the first one is the main contact).
  final List<EmergencyContact> _contacts;

  /// A list of people to contact in an emergency (the first one is the main contact).
  @override
  @JsonKey()
  List<EmergencyContact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// How does the user want to trigger an SOS? (Voice? Shaking the phone? A big red button?)
  @override
  @JsonKey()
  final SosTrigger preferredSosTrigger;

  /// Is it okay if we share their GPS location with their contacts during an emergency?
  @override
  @JsonKey()
  final bool shareGpsOnSos;

  /// Is it okay if we share their medical info (like what meds they are on) with responders?
  @override
  @JsonKey()
  final bool shareMedicalInfoOnSos;

  /// Any special medical notes responders should know immediately? (e.g., "I'm allergic to Penicillin")
  @override
  @JsonKey()
  final String medicalNote;

  /// Create a copy of EmergencyConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmergencyConfigCopyWith<_EmergencyConfig> get copyWith =>
      __$EmergencyConfigCopyWithImpl<_EmergencyConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EmergencyConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmergencyConfig &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            (identical(other.preferredSosTrigger, preferredSosTrigger) ||
                other.preferredSosTrigger == preferredSosTrigger) &&
            (identical(other.shareGpsOnSos, shareGpsOnSos) ||
                other.shareGpsOnSos == shareGpsOnSos) &&
            (identical(other.shareMedicalInfoOnSos, shareMedicalInfoOnSos) ||
                other.shareMedicalInfoOnSos == shareMedicalInfoOnSos) &&
            (identical(other.medicalNote, medicalNote) ||
                other.medicalNote == medicalNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_contacts),
      preferredSosTrigger,
      shareGpsOnSos,
      shareMedicalInfoOnSos,
      medicalNote);

  @override
  String toString() {
    return 'EmergencyConfig(contacts: $contacts, preferredSosTrigger: $preferredSosTrigger, shareGpsOnSos: $shareGpsOnSos, shareMedicalInfoOnSos: $shareMedicalInfoOnSos, medicalNote: $medicalNote)';
  }
}

/// @nodoc
abstract mixin class _$EmergencyConfigCopyWith<$Res>
    implements $EmergencyConfigCopyWith<$Res> {
  factory _$EmergencyConfigCopyWith(
          _EmergencyConfig value, $Res Function(_EmergencyConfig) _then) =
      __$EmergencyConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<EmergencyContact> contacts,
      SosTrigger preferredSosTrigger,
      bool shareGpsOnSos,
      bool shareMedicalInfoOnSos,
      String medicalNote});
}

/// @nodoc
class __$EmergencyConfigCopyWithImpl<$Res>
    implements _$EmergencyConfigCopyWith<$Res> {
  __$EmergencyConfigCopyWithImpl(this._self, this._then);

  final _EmergencyConfig _self;
  final $Res Function(_EmergencyConfig) _then;

  /// Create a copy of EmergencyConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contacts = null,
    Object? preferredSosTrigger = null,
    Object? shareGpsOnSos = null,
    Object? shareMedicalInfoOnSos = null,
    Object? medicalNote = null,
  }) {
    return _then(_EmergencyConfig(
      contacts: null == contacts
          ? _self._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<EmergencyContact>,
      preferredSosTrigger: null == preferredSosTrigger
          ? _self.preferredSosTrigger
          : preferredSosTrigger // ignore: cast_nullable_to_non_nullable
              as SosTrigger,
      shareGpsOnSos: null == shareGpsOnSos
          ? _self.shareGpsOnSos
          : shareGpsOnSos // ignore: cast_nullable_to_non_nullable
              as bool,
      shareMedicalInfoOnSos: null == shareMedicalInfoOnSos
          ? _self.shareMedicalInfoOnSos
          : shareMedicalInfoOnSos // ignore: cast_nullable_to_non_nullable
              as bool,
      medicalNote: null == medicalNote
          ? _self.medicalNote
          : medicalNote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UserEntity {
  /// The user's unique Firebase ID.
  String? get uid;

  /// The user's full name.
  String get userName;

  /// The language they want to read and hear the app in.
  String get selectedLanguage;

  /// All their visual and audio tweaks.
  AccessibilitySettings get accessibility;

  /// Everything related to their SOS button and emergency contacts.
  EmergencyConfig get emergencyConfig;

  /// A list of meds they are currently taking. We feed this to the AI so it knows what they mean when they say "I took my pill".
  List<Medication> get activeMedications;

  /// Tracks where they left off in the sign-up process.
  int get currentStep;

  /// Did they finish setting up their account?
  bool get isOnboardingComplete;

  /// Exactly when they created this account.
  String? get createdAt;

  /// The last time they changed something in their profile.
  String? get updatedAt;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<UserEntity> get copyWith =>
      _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  /// Serializes this UserEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserEntity &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            (identical(other.accessibility, accessibility) ||
                other.accessibility == accessibility) &&
            (identical(other.emergencyConfig, emergencyConfig) ||
                other.emergencyConfig == emergencyConfig) &&
            const DeepCollectionEquality()
                .equals(other.activeMedications, activeMedications) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isOnboardingComplete, isOnboardingComplete) ||
                other.isOnboardingComplete == isOnboardingComplete) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      userName,
      selectedLanguage,
      accessibility,
      emergencyConfig,
      const DeepCollectionEquality().hash(activeMedications),
      currentStep,
      isOnboardingComplete,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'UserEntity(uid: $uid, userName: $userName, selectedLanguage: $selectedLanguage, accessibility: $accessibility, emergencyConfig: $emergencyConfig, activeMedications: $activeMedications, currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) _then) =
      _$UserEntityCopyWithImpl;
  @useResult
  $Res call(
      {String? uid,
      String userName,
      String selectedLanguage,
      AccessibilitySettings accessibility,
      EmergencyConfig emergencyConfig,
      List<Medication> activeMedications,
      int currentStep,
      bool isOnboardingComplete,
      String? createdAt,
      String? updatedAt});

  $AccessibilitySettingsCopyWith<$Res> get accessibility;
  $EmergencyConfigCopyWith<$Res> get emergencyConfig;
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res> implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? userName = null,
    Object? selectedLanguage = null,
    Object? accessibility = null,
    Object? emergencyConfig = null,
    Object? activeMedications = null,
    Object? currentStep = null,
    Object? isOnboardingComplete = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      uid: freezed == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      accessibility: null == accessibility
          ? _self.accessibility
          : accessibility // ignore: cast_nullable_to_non_nullable
              as AccessibilitySettings,
      emergencyConfig: null == emergencyConfig
          ? _self.emergencyConfig
          : emergencyConfig // ignore: cast_nullable_to_non_nullable
              as EmergencyConfig,
      activeMedications: null == activeMedications
          ? _self.activeMedications
          : activeMedications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isOnboardingComplete: null == isOnboardingComplete
          ? _self.isOnboardingComplete
          : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccessibilitySettingsCopyWith<$Res> get accessibility {
    return $AccessibilitySettingsCopyWith<$Res>(_self.accessibility, (value) {
      return _then(_self.copyWith(accessibility: value));
    });
  }

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmergencyConfigCopyWith<$Res> get emergencyConfig {
    return $EmergencyConfigCopyWith<$Res>(_self.emergencyConfig, (value) {
      return _then(_self.copyWith(emergencyConfig: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _UserEntity implements UserEntity {
  const _UserEntity(
      {this.uid,
      this.userName = '',
      this.selectedLanguage = 'English',
      this.accessibility = const AccessibilitySettings(),
      this.emergencyConfig = const EmergencyConfig(),
      final List<Medication> activeMedications = const [],
      this.currentStep = 0,
      this.isOnboardingComplete = false,
      this.createdAt,
      this.updatedAt})
      : _activeMedications = activeMedications;
  factory _UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  /// The user's unique Firebase ID.
  @override
  final String? uid;

  /// The user's full name.
  @override
  @JsonKey()
  final String userName;

  /// The language they want to read and hear the app in.
  @override
  @JsonKey()
  final String selectedLanguage;

  /// All their visual and audio tweaks.
  @override
  @JsonKey()
  final AccessibilitySettings accessibility;

  /// Everything related to their SOS button and emergency contacts.
  @override
  @JsonKey()
  final EmergencyConfig emergencyConfig;

  /// A list of meds they are currently taking. We feed this to the AI so it knows what they mean when they say "I took my pill".
  final List<Medication> _activeMedications;

  /// A list of meds they are currently taking. We feed this to the AI so it knows what they mean when they say "I took my pill".
  @override
  @JsonKey()
  List<Medication> get activeMedications {
    if (_activeMedications is EqualUnmodifiableListView)
      return _activeMedications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeMedications);
  }

  /// Tracks where they left off in the sign-up process.
  @override
  @JsonKey()
  final int currentStep;

  /// Did they finish setting up their account?
  @override
  @JsonKey()
  final bool isOnboardingComplete;

  /// Exactly when they created this account.
  @override
  final String? createdAt;

  /// The last time they changed something in their profile.
  @override
  final String? updatedAt;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserEntityCopyWith<_UserEntity> get copyWith =>
      __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserEntity &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            (identical(other.accessibility, accessibility) ||
                other.accessibility == accessibility) &&
            (identical(other.emergencyConfig, emergencyConfig) ||
                other.emergencyConfig == emergencyConfig) &&
            const DeepCollectionEquality()
                .equals(other._activeMedications, _activeMedications) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isOnboardingComplete, isOnboardingComplete) ||
                other.isOnboardingComplete == isOnboardingComplete) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      userName,
      selectedLanguage,
      accessibility,
      emergencyConfig,
      const DeepCollectionEquality().hash(_activeMedications),
      currentStep,
      isOnboardingComplete,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'UserEntity(uid: $uid, userName: $userName, selectedLanguage: $selectedLanguage, accessibility: $accessibility, emergencyConfig: $emergencyConfig, activeMedications: $activeMedications, currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(
          _UserEntity value, $Res Function(_UserEntity) _then) =
      __$UserEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? uid,
      String userName,
      String selectedLanguage,
      AccessibilitySettings accessibility,
      EmergencyConfig emergencyConfig,
      List<Medication> activeMedications,
      int currentStep,
      bool isOnboardingComplete,
      String? createdAt,
      String? updatedAt});

  @override
  $AccessibilitySettingsCopyWith<$Res> get accessibility;
  @override
  $EmergencyConfigCopyWith<$Res> get emergencyConfig;
}

/// @nodoc
class __$UserEntityCopyWithImpl<$Res> implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = freezed,
    Object? userName = null,
    Object? selectedLanguage = null,
    Object? accessibility = null,
    Object? emergencyConfig = null,
    Object? activeMedications = null,
    Object? currentStep = null,
    Object? isOnboardingComplete = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_UserEntity(
      uid: freezed == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      accessibility: null == accessibility
          ? _self.accessibility
          : accessibility // ignore: cast_nullable_to_non_nullable
              as AccessibilitySettings,
      emergencyConfig: null == emergencyConfig
          ? _self.emergencyConfig
          : emergencyConfig // ignore: cast_nullable_to_non_nullable
              as EmergencyConfig,
      activeMedications: null == activeMedications
          ? _self._activeMedications
          : activeMedications // ignore: cast_nullable_to_non_nullable
              as List<Medication>,
      currentStep: null == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isOnboardingComplete: null == isOnboardingComplete
          ? _self.isOnboardingComplete
          : isOnboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccessibilitySettingsCopyWith<$Res> get accessibility {
    return $AccessibilitySettingsCopyWith<$Res>(_self.accessibility, (value) {
      return _then(_self.copyWith(accessibility: value));
    });
  }

  /// Create a copy of UserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmergencyConfigCopyWith<$Res> get emergencyConfig {
    return $EmergencyConfigCopyWith<$Res>(_self.emergencyConfig, (value) {
      return _then(_self.copyWith(emergencyConfig: value));
    });
  }
}

// dart format on
