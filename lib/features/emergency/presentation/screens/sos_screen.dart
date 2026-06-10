import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';

import 'package:ntentan/features/emergency/presentation/widgets/sos_status_row.dart';
import 'package:ntentan/features/emergency/presentation/widgets/sos_header.dart';
import 'package:ntentan/features/emergency/presentation/widgets/sos_action_buttons.dart';

/// SOS Screen — Phase 5
/// Cancel button is LARGEST element, positioned at BOTTOM.
/// Countdown with vibration. Auto-sends after 5 seconds.
class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});
  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    final controller = context.read<EmergencyController>();
    AppHaptics.sosActivated();
    _startCountdown(controller);
  }

  void _startCountdown(EmergencyController controller) {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final newVal = controller.state.countdown - 1;
      controller.updateCountdown(newVal);

      if (newVal <= 0) {
        timer.cancel();
        AppHaptics.sosActivated();
      } else {
        AppHaptics.warning();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EmergencyController>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            children: [
              // Status header (countdown or confirmation)
              SOSHeader(
                sent: controller.state.sent,
                sending: controller.state.sending,
                countdown: controller.state.countdown,
              ),

              const SizedBox(height: AppSizes.space32),

              // Communication steps
              if (controller.state.sending || controller.state.sent) ...[
                SOSStatusRow(
                  label: 'GPS location shared',
                  isDone: controller.state.gpsShared,
                ),
                const SizedBox(height: 8),
                SOSStatusRow(
                  label: 'Emergency contacts notified',
                  isDone: controller.state.contactsNotified,
                ),
              ],

              const Spacer(),

              // Action buttons (silent mode, status, cancel)
              SOSActionButtons(
                sent: controller.state.sent,
                onCancel: () {
                  _countdownTimer?.cancel();
                  controller.cancelSOS();
                  context.pop();
                },
                onSilentMode: () {
                  controller.activateSilentMode();
                  context.push(RoutePaths.silentDistress);
                },
                onViewStatus: () => context.push(RoutePaths.emergencyComm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
