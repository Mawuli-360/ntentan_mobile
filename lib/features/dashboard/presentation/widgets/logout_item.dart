import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/shared/modal/app_modal.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/shared/widgets/settings_item.dart';

class LogoutItem extends StatelessWidget {
  const LogoutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      icon: Iconsax.logout,
      iconColor: Colors.orangeAccent,
      label: 'Log Out',
      onTap: () {
        context.showModalSheet(
          centerDialog: true,
          content: AppConfirmModal(
            title: 'Logout',
            description: 'Are you sure you want to log out?',
            onCancelText: 'Stay',
            onProceedText: 'Logout',
            onCancel: () => Navigator.pop(context),
            onProceed: () async {
              Navigator.pop(context);
              context.showLoadingModal('Logging out...');
              final authController = context.read<AuthController>();
              await authController.signOut();
              if (context.mounted) {
                context.hideLoadingModal();
                context.go(RoutePaths.authMethod);
              }
            },
          ),
        );
      },
    );
  }
}
