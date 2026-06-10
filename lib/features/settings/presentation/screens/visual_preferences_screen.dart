import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/settings/presentation/widgets/dashboard_header.dart';
import 'package:ntentan/features/settings/presentation/widgets/preference_slider_card.dart';
import 'package:ntentan/features/settings/presentation/widgets/color_blindness_grid.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';

class VisualPreferencesScreen extends StatelessWidget {
  const VisualPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityController>();
    final state = accessibility.state;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Visual Preferences',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.space20),
        children: [
          const DashboardHeader(title: 'Text & Display'),
          const SizedBox(height: AppSizes.space16),

          // Text Scaling Slider
          PreferenceSliderCard(
            title: 'Text Scale Factor',
            subtitle: 'Adjust the global size of text in the app',
            value: state.fontScale,
            min: 1.0,
            max: 1.4,
            divisions: 4,
            label: 'Current Scale: ${state.fontScale.toStringAsFixed(1)}x',
            onChanged: (value) {
              AppHaptics.light();
              accessibility.setFontScale(value);
              accessibility.saveSettings();
            },
          ),

          const SizedBox(height: AppSizes.space24),
          const DashboardHeader(title: 'Color Blindness'),
          const SizedBox(height: AppSizes.space16),

          // Color Blindness Options
          ColorBlindnessGrid(
            modes: ColorBlindnessMode.values
                .map((v) => {'name': v.label, 'desc': v.description})
                .toList(),
            selectedIndex:
                ColorBlindnessMode.values.indexOf(state.colorBlindnessMode),
            onSelected: (index) {
              final mode = ColorBlindnessMode.values[index];
              AppHaptics.warning();
              accessibility.setColorBlindnessMode(mode);
              accessibility.saveSettings();
            },
          ),
        ],
      ),
    );
  }
}
