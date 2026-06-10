import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/constants/app_images.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/app_route/route_paths.dart';

enum DashboardActionType { route, modal, meds }

class DashboardActionItem {
  final Object icon; // IconData or AssetImage
  final String title;
  final String description;
  final Color color;
  final DashboardActionType type;
  final String? routePath;

  const DashboardActionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.type,
    this.routePath,
  });

  static List<DashboardActionItem> getActions({required int remainingCount}) {
    return [
      const DashboardActionItem(
        icon: Iconsax.scan_barcode,
        title: 'Scan Medicine',
        description: 'Identify a pill',
        color: AppColors.vi,
        type: DashboardActionType.route,
        routePath: RoutePaths.cameraReader,
      ),
      DashboardActionItem(
        icon: AppImages.pill,
        title: "Today's Meds",
        description:
            remainingCount == 0 ? 'All done!' : '$remainingCount remaining',
        color: Colors.blueAccent,
        type: DashboardActionType.meds,
        routePath: RoutePaths.medicationManager,
      ),
      const DashboardActionItem(
        icon: Iconsax.messages_2,
        title: 'Ntentan AI',
        description: 'Chat or speak',
        color: Colors.green,
        type: DashboardActionType.modal,
      ),
      const DashboardActionItem(
        icon: Iconsax.profile_2user,
        title: 'Caregiver',
        description: 'Helpers & alerts',
        color: Colors.orangeAccent,
        type: DashboardActionType.route,
        routePath: RoutePaths.caregiverMode,
      ),
    ];
  }
}
