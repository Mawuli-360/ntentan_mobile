import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/features/dashboard/presentation/controllers/dashboard_controller.dart';

import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';
import 'package:ntentan/shared/widgets/sos_button.dart';
import 'package:ntentan/core/constants/enums.dart';

import 'package:ntentan/features/dashboard/presentation/widgets/dashboard_home_tab.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/screens/camera_reader_screen.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/dashboard_profile_tab.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/voice_assistant_modal.dart';
import 'package:ntentan/core/services/hold_gesture_service.dart';

/// Main Dashboard — Phase 1
/// Adaptive UI that switches between VI and DM dashboards.
/// Bottom nav with ALWAYS-visible text labels. Persistent SOS button.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final HoldGestureService _holdGestureService;

  @override
  void initState() {
    super.initState();
    _holdGestureService = HoldGestureService()
      ..initialize()
      ..onHoldDetected = _showAIConversationalModal;

  }

  @override
  void dispose() {
    _holdGestureService.dispose();
    super.dispose();
  }

  void _showAIConversationalModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const VoiceAssistantModal(),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, DashboardController dashboard) {
    final isSelected = dashboard.state.selectedNavIndex == index;
    return GestureDetector(
      onTap: () => dashboard.setNavIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.vi.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  )
                : const BoxDecoration(),
            child: Icon(
              icon,
              color: isSelected ? AppColors.vi : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.vi : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardController>();

    return Listener(
        onPointerDown: _holdGestureService.handlePointerDown,
        onPointerMove: _holdGestureService.handlePointerMove,
        onPointerUp: _holdGestureService.handlePointerUp,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Scaffold(
            backgroundColor: AppColors.bg,
            body: IndexedStack(
              index: dashboard.state.selectedNavIndex,
              children: [
                // Home (Features)
                const DashboardHomeTab(),
                // Camera
                dashboard.state.selectedNavIndex == 1
                    ? const CameraReaderScreen()
                    : const SizedBox.shrink(),
                // Profile
                const DashboardProfileTab(),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.bg,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Iconsax.home_2, 'Home', 0, dashboard),
                        const SizedBox(width: 80), // Space for central button
                        _buildNavItem(Iconsax.user, 'Profile', 2, dashboard),
                      ],
                    ),
                    // Central Prominent Floating Button & Label
                    Positioned(
                      top: -20,
                      bottom: 8,
                      child: GestureDetector(
                        onTap: () => dashboard.setNavIndex(1),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.vi,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.vi.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: const Icon(Iconsax.scan_barcode,
                                  color: Colors.white, size: 32),
                            ),
                            Text(
                              'Camera Reader',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    dashboard.state.selectedNavIndex == 1
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                color: dashboard.state.selectedNavIndex == 1
                                    ? AppColors.vi
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: dashboard.state.selectedNavIndex == 1
                ? null
                : SosButton(
                    onPressed: () {
                      context
                          .read<EmergencyController>()
                          .activateSOS(SosTrigger.button);
                      context.push(RoutePaths.sos);
                    },
                  ),
          ),
        ));
  }
}
