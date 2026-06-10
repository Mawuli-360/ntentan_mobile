import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_modern_button.dart';

class AuthLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final String subtitle;
  final List<Widget> formChildren;
  final String buttonLabel;
  final IconData buttonIcon;
  final VoidCallback onButtonPressed;
  final Widget footerWidget;

  const AuthLayout({
    super.key,
    required this.formKey,
    required this.title,
    required this.subtitle,
    required this.formChildren,
    required this.buttonLabel,
    required this.buttonIcon,
    required this.onButtonPressed,
    required this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.space24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: AppSizes.space32),
                  ...formChildren,
                  const SizedBox(height: AppSizes.space40),
                  AuthModernButton(
                    icon: buttonIcon,
                    label: buttonLabel,
                    backgroundColor: AppColors.vi,
                    textColor: Colors.white,
                    onPressed: onButtonPressed,
                  ),
                  const SizedBox(height: AppSizes.space24),
                  footerWidget,
                  const SizedBox(height: AppSizes.space16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppSizes.space8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
