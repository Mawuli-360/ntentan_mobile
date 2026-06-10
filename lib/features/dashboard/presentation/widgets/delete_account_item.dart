import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/shared/modal/app_modal.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/auth/presentation/widgets/password_confirm_modal.dart';
import 'package:ntentan/shared/widgets/settings_item.dart';

class DeleteAccountItem extends StatelessWidget {
  const DeleteAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      icon: Iconsax.user_remove,
      label: 'Delete Account',
      iconColor: AppColors.emergency,
      onTap: () {
        final authController = context.read<AuthController>();
        _showDeleteConfirmation(context, authController);
      },
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, AuthController authController) {
    final router = GoRouter.of(context);
    final isPasswordProvider = authController.currentUser?.providerData
            .any((p) => p.providerId == 'password') ??
        false;

    if (isPasswordProvider) {
      context.showModalSheet(
        centerDialog: true,
        content: PasswordConfirmModal(
          onCancel: () => Navigator.pop(context),
          onProceed: (password) async {
            Navigator.pop(context);
            context.showLoadingModal('Deleting account...');
            final success =
                await authController.deleteAccount(password: password);
            if (context.mounted) {
              context.hideLoadingModal();
              if (success) {
                router.go(RoutePaths.authMethod);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authController.state.errorMessage ??
                        'Failed to delete account'),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            }
          },
        ),
      );
      return;
    }

    context.showModalSheet(
      centerDialog: true,
      content: AppConfirmModal(
        title: 'Delete Account?',
        description:
            'This action is permanent and cannot be undone. All your health data will be lost.',
        onCancelText: 'Keep Account',
        onProceedText: 'Delete',
        onCancel: () => Navigator.pop(context),
        onProceed: () async {
          Navigator.pop(context);
          context.showLoadingModal('Deleting account...');
          final success = await authController.deleteAccount();
          if (context.mounted) {
            context.hideLoadingModal();
            if (success) {
              router.go(RoutePaths.authMethod);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(authController.state.errorMessage ??
                      'Failed to delete account'),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
