import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/shared/screens/not_found_screen.dart';
import 'package:ntentan/features/onboarding/presentation/screens/splash_screen.dart';

import 'package:ntentan/features/auth/presentation/screens/profile_registration_screen.dart';
import 'package:ntentan/features/onboarding/presentation/screens/language_preference_screen.dart';
import 'package:ntentan/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/screens/voice_assistant_screen.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/screens/camera_reader_screen.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/features/settings/presentation/screens/caregiver_mode_screen.dart';
import 'package:ntentan/features/emergency/presentation/screens/sos_screen.dart';
import 'package:ntentan/features/emergency/presentation/screens/emergency_comm_screen.dart';
import 'package:ntentan/features/emergency/presentation/screens/silent_distress_screen.dart';
import 'package:ntentan/features/settings/presentation/screens/privacy_terms_screen.dart';
import 'package:ntentan/features/auth/presentation/screens/terms_acceptance_screen.dart';
import 'package:ntentan/features/auth/presentation/screens/auth_method_screen.dart';
import 'package:ntentan/features/auth/presentation/screens/login_screen.dart';
import 'package:ntentan/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ntentan/features/settings/presentation/screens/visual_preferences_screen.dart';
import 'package:ntentan/features/settings/presentation/screens/alerts_notifications_screen.dart';
import 'package:ntentan/features/settings/presentation/screens/help_center_screen.dart';
import 'package:ntentan/features/settings/presentation/screens/medication_schedule_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      // ── Phase 0: Onboarding ──
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: RoutePaths.profileRegistration,
        builder: (context, state) => const ProfileRegistrationScreen(),
      ),
      GoRoute(
        path: RoutePaths.languagePreference,
        builder: (context, state) => const LanguagePreferenceScreen(),
      ),

      // ── Phase 1: Dashboard ──
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),

      GoRoute(
        path: RoutePaths.visualPreferences,
        builder: (context, state) => const VisualPreferencesScreen(),
      ),
      GoRoute(
        path: RoutePaths.alertsNotifications,
        builder: (context, state) => const AlertsNotificationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.helpCenter,
        builder: (context, state) => const HelpCenterScreen(),
      ),

      // ── Phase 2: VI Features ──
      GoRoute(
        path: RoutePaths.voiceAssistant,
        builder: (context, state) => const VoiceAssistantScreen(),
      ),
      GoRoute(
        path: RoutePaths.cameraReader,
        builder: (context, state) => const CameraReaderScreen(showHeader: true),
      ),

      // ── Phase 4: Auxiliary ──
      GoRoute(
        path: RoutePaths.caregiverMode,
        builder: (context, state) => CaregiverModeScreen(
          initialMedication: state.extra as Medication?,
        ),
      ),
      GoRoute(
        path: RoutePaths.medicationSchedule,
        builder: (context, state) => const MedicationScheduleScreen(),
      ),

      // ── Phase 5: Emergency ──
      GoRoute(
        path: RoutePaths.sos,
        builder: (context, state) => const SOSScreen(),
      ),
      GoRoute(
        path: RoutePaths.emergencyComm,
        builder: (context, state) => const EmergencyCommScreen(),
      ),
      GoRoute(
        path: RoutePaths.silentDistress,
        builder: (context, state) => const SilentDistressScreen(),
      ),
      GoRoute(
        path: RoutePaths.privacy,
        builder: (context, state) => const PrivacyTermsScreen(),
      ),
      // ── Authentication Flow ──
      GoRoute(
        path: RoutePaths.termsAcceptance,
        builder: (context, state) => const TermsAcceptanceScreen(),
      ),
      GoRoute(
        path: RoutePaths.authMethod,
        builder: (context, state) => const AuthMethodScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
