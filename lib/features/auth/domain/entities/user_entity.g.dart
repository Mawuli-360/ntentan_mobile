// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccessibilitySettings _$AccessibilitySettingsFromJson(
        Map<String, dynamic> json) =>
    _AccessibilitySettings(
      highContrastEnabled: json['highContrastEnabled'] as bool? ?? false,
      screenReaderEnabled: json['screenReaderEnabled'] as bool? ?? false,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      fontScale: (json['fontScale'] as num?)?.toDouble() ?? 1.0,
      reduceMotionEnabled: json['reduceMotionEnabled'] as bool? ?? false,
      colorBlindnessMode: $enumDecodeNullable(
              _$ColorBlindnessModeEnumMap, json['colorBlindnessMode']) ??
          ColorBlindnessMode.none,
      visualFlashEnabled: json['visualFlashEnabled'] as bool? ?? true,
      medicationRemindersEnabled:
          json['medicationRemindersEnabled'] as bool? ?? true,
      magnifyScreenEnabled: json['magnifyScreenEnabled'] as bool? ?? false,
      savedFontScale: (json['savedFontScale'] as num?)?.toDouble() ?? 1.3,
    );

Map<String, dynamic> _$AccessibilitySettingsToJson(
        _AccessibilitySettings instance) =>
    <String, dynamic>{
      'highContrastEnabled': instance.highContrastEnabled,
      'screenReaderEnabled': instance.screenReaderEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'fontScale': instance.fontScale,
      'reduceMotionEnabled': instance.reduceMotionEnabled,
      'colorBlindnessMode':
          _$ColorBlindnessModeEnumMap[instance.colorBlindnessMode]!,
      'visualFlashEnabled': instance.visualFlashEnabled,
      'medicationRemindersEnabled': instance.medicationRemindersEnabled,
      'magnifyScreenEnabled': instance.magnifyScreenEnabled,
      'savedFontScale': instance.savedFontScale,
    };

const _$ColorBlindnessModeEnumMap = {
  ColorBlindnessMode.none: 'none',
  ColorBlindnessMode.protanopia: 'protanopia',
  ColorBlindnessMode.deuteranopia: 'deuteranopia',
  ColorBlindnessMode.tritanopia: 'tritanopia',
};

_EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    _EmergencyContact(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      relationship: json['relationship'] as String? ?? '',
    );

Map<String, dynamic> _$EmergencyContactToJson(_EmergencyContact instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'relationship': instance.relationship,
    };

_EmergencyConfig _$EmergencyConfigFromJson(Map<String, dynamic> json) =>
    _EmergencyConfig(
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      preferredSosTrigger: $enumDecodeNullable(
              _$SosTriggerEnumMap, json['preferredSosTrigger']) ??
          SosTrigger.button,
      shareGpsOnSos: json['shareGpsOnSos'] as bool? ?? true,
      shareMedicalInfoOnSos: json['shareMedicalInfoOnSos'] as bool? ?? true,
      medicalNote: json['medicalNote'] as String? ?? '',
    );

Map<String, dynamic> _$EmergencyConfigToJson(_EmergencyConfig instance) =>
    <String, dynamic>{
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
      'preferredSosTrigger': _$SosTriggerEnumMap[instance.preferredSosTrigger]!,
      'shareGpsOnSos': instance.shareGpsOnSos,
      'shareMedicalInfoOnSos': instance.shareMedicalInfoOnSos,
      'medicalNote': instance.medicalNote,
    };

const _$SosTriggerEnumMap = {
  SosTrigger.button: 'button',
  SosTrigger.voice: 'voice',
  SosTrigger.gesture: 'gesture',
  SosTrigger.shake: 'shake',
  SosTrigger.hardware: 'hardware',
};

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
      uid: json['uid'] as String?,
      userName: json['userName'] as String? ?? '',
      selectedLanguage: json['selectedLanguage'] as String? ?? 'English',
      accessibility: json['accessibility'] == null
          ? const AccessibilitySettings()
          : AccessibilitySettings.fromJson(
              json['accessibility'] as Map<String, dynamic>),
      emergencyConfig: json['emergencyConfig'] == null
          ? const EmergencyConfig()
          : EmergencyConfig.fromJson(
              json['emergencyConfig'] as Map<String, dynamic>),
      activeMedications: (json['activeMedications'] as List<dynamic>?)
              ?.map((e) => Medication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
      isOnboardingComplete: json['isOnboardingComplete'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'selectedLanguage': instance.selectedLanguage,
      'accessibility': instance.accessibility.toJson(),
      'emergencyConfig': instance.emergencyConfig.toJson(),
      'activeMedications':
          instance.activeMedications.map((e) => e.toJson()).toList(),
      'currentStep': instance.currentStep,
      'isOnboardingComplete': instance.isOnboardingComplete,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
