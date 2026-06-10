import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

// ─────────────────────────────────────────────────
// Sub-entity: Accessibility Settings
// ─────────────────────────────────────────────────

/// This holds the user's specific accessibility needs so we can adapt the app's UI for them.
@freezed
abstract class AccessibilitySettings with _$AccessibilitySettings {
  const factory AccessibilitySettings({
    /// Turn on high contrast mode to help users with low vision see things more clearly.
    @Default(false) bool highContrastEnabled,

    /// Does the user rely on a screen reader like TalkBack?
    @Default(false) bool screenReaderEnabled,

    /// Let the phone buzz when we need their attention or when they successfully tap something.
    @Default(true) bool vibrationEnabled,

    /// How big do they want the text? 1.0 is the default, but we can crank it up if they need it.
    @Default(1.0) double fontScale,

    /// Turn off bouncy or flashy animations if they get motion sickness easily.
    @Default(false) bool reduceMotionEnabled,

    /// Adjust colors for specific types of color blindness.
    @Default(ColorBlindnessMode.none) ColorBlindnessMode colorBlindnessMode,

    /// Flash the screen for important alerts (super helpful if they can't hear notifications).
    @Default(true) bool visualFlashEnabled,

    /// Should we remind them to take their meds?
    @Default(true) bool medicationRemindersEnabled,

    /// A special toggle to magnify the entire screen, not just the text.
    @Default(false) bool magnifyScreenEnabled,

    /// We save their old font scale here so we can restore it if they turn the magnifier off.
    @Default(1.3) double savedFontScale,
  }) = _AccessibilitySettings;

  factory AccessibilitySettings.fromJson(Map<String, dynamic> json) =>
      _$AccessibilitySettingsFromJson(json);
}

// ─────────────────────────────────────────────────
// Sub-entity: Emergency Contact
// ─────────────────────────────────────────────────

/// The person we're calling or texting if the user triggers an SOS emergency.
@freezed
abstract class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    /// The contact's full name.
    required String name,

    /// Their phone number so we can automatically text them during an SOS.
    required String phoneNumber,

    /// How do they know the user? (e.g., "Spouse", "Doctor")
    @Default('') String relationship,
  }) = _EmergencyContact;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);
}

// ─────────────────────────────────────────────────
// Sub-entity: Emergency Configuration
// ─────────────────────────────────────────────────

/// How the user wants us to handle emergencies. Who do we call? How do they trigger it?
@freezed
abstract class EmergencyConfig with _$EmergencyConfig {
  const factory EmergencyConfig({
    /// A list of people to contact in an emergency (the first one is the main contact).
    @Default([]) List<EmergencyContact> contacts,

    /// How does the user want to trigger an SOS? (Voice? Shaking the phone? A big red button?)
    @Default(SosTrigger.button) SosTrigger preferredSosTrigger,

    /// Is it okay if we share their GPS location with their contacts during an emergency?
    @Default(true) bool shareGpsOnSos,

    /// Is it okay if we share their medical info (like what meds they are on) with responders?
    @Default(true) bool shareMedicalInfoOnSos,

    /// Any special medical notes responders should know immediately? (e.g., "I'm allergic to Penicillin")
    @Default('') String medicalNote,
  }) = _EmergencyConfig;

  factory EmergencyConfig.fromJson(Map<String, dynamic> json) =>
      _$EmergencyConfigFromJson(json);
}

// ─────────────────────────────────────────────────
// Root entity: UserEntity
// ─────────────────────────────────────────────────

/// The main user profile! This gets saved in the local database and synced up to Firestore.
///
/// Here's what we track:
/// - The basics: Who they are (name).
/// - Language: What language they speak.
/// - Accessibility: All their visual/audio tweaks to make the app usable for them.
/// - Emergency: Their SOS gameplan.
/// - AI & Meds: Their active meds so the AI can track what they took today.
@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    /// The user's unique Firebase ID.
    String? uid,

    /// The user's full name.
    @Default('') String userName,

    /// The language they want to read and hear the app in.
    @Default('English') String selectedLanguage,

    /// All their visual and audio tweaks.
    @Default(AccessibilitySettings()) AccessibilitySettings accessibility,

    /// Everything related to their SOS button and emergency contacts.
    @Default(EmergencyConfig()) EmergencyConfig emergencyConfig,

    /// A list of meds they are currently taking. We feed this to the AI so it knows what they mean when they say "I took my pill".
    @Default([]) List<Medication> activeMedications,

    /// Tracks where they left off in the sign-up process.
    @Default(0) int currentStep,

    /// Did they finish setting up their account?
    @Default(false) bool isOnboardingComplete,

    /// Exactly when they created this account.
    String? createdAt,

    /// The last time they changed something in their profile.
    String? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
