import 'package:flutter/material.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/core/theme/app_theme.dart';
import 'package:ntentan/core/app_route/app_router.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';

import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';

class NtentanApp extends StatelessWidget {
  const NtentanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
            create: (_) => sl<AuthController>()),
        ChangeNotifierProvider<MedicationController>(
            create: (_) => sl<MedicationController>()),
        ChangeNotifierProvider<ProfileController>.value(
            value: sl<ProfileController>()),
        ChangeNotifierProvider<DashboardController>.value(
            value: sl<DashboardController>()),
        ChangeNotifierProvider<EmergencyController>.value(
            value: sl<EmergencyController>()),
        ChangeNotifierProvider<AccessibilityController>.value(
            value: sl<AccessibilityController>()),
      ],
      child: Consumer<AccessibilityController>(
        builder: (context, accessibility, _) => MaterialApp.router(
          title: 'Ntentan',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            final state = accessibility.state;
            Widget app = MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(state.fontScale),
              ),
              child: child!,
            );

            // Apply Color Blindness Filter if active
            if (state.colorBlindnessMode != ColorBlindnessMode.none) {
              app = ColorFiltered(
                colorFilter: _getColorFilter(state.colorBlindnessMode),
                child: app,
              );
            }

            return app;
          },
        ),
      ),
    );
  }

  ColorFilter _getColorFilter(ColorBlindnessMode mode) {
    switch (mode) {
      case ColorBlindnessMode.protanopia:
        return const ColorFilter.matrix([
          0.567, 0.433, 0.0, 0.0, 0.0,
          0.558, 0.442, 0.0, 0.0, 0.0,
          0.0, 0.242, 0.758, 0.0, 0.0,
          0.0, 0.0, 0.0, 1.0, 0.0,
        ]);
      case ColorBlindnessMode.deuteranopia:
        return const ColorFilter.matrix([
          0.625, 0.375, 0.0, 0.0, 0.0,
          0.7, 0.3, 0.0, 0.0, 0.0,
          0.0, 0.3, 0.7, 0.0, 0.0,
          0.0, 0.0, 0.0, 1.0, 0.0,
        ]);
      case ColorBlindnessMode.tritanopia:
        return const ColorFilter.matrix([
          0.95, 0.05, 0.0, 0.0, 0.0,
          0.0, 0.433, 0.567, 0.0, 0.0,
          0.0, 0.475, 0.525, 0.0, 0.0,
          0.0, 0.0, 0.0, 1.0, 0.0,
        ]);
      case ColorBlindnessMode.none:
        return const ColorFilter.mode(Colors.transparent, BlendMode.dst);
    }
  }
}
