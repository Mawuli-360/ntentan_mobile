import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/core/utils/validators.dart';

import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/auth/presentation/mixins/auth_navigation_mixin.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_layout.dart';
import 'package:ntentan/features/auth/presentation/widgets/sign_up_footer.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_password_field.dart';

/// Email Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with AuthNavigationMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _processSignUpRequest(
      BuildContext context, AuthController authController) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.showLoadingModal('Creating account...');

    final success = await authController.registerWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!context.mounted) return;

    if (success) {
      await fetchUserDataAndNavigate(context, authController);
    } else {
      context.hideLoadingModal();
      if (authController.state.errorMessage != null) {
        context.showErrorSnackBar(authController.state.errorMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return AuthLayout(
      formKey: _formKey,
      title: 'Join Ntentan',
      subtitle: 'Create your account to get started.',
      buttonLabel: 'Sign Up',
      buttonIcon: Iconsax.user_add,
      onButtonPressed: () => _processSignUpRequest(context, authController),
      footerWidget: const SignUpFooter(),
      formChildren: [
        AuthFormField(
          label: 'Full Name',
          hintText: 'Enter your full name',
          controller: _nameController,
          prefixIcon: Iconsax.user,
          keyboardType: TextInputType.name,
          validator: (value) =>
              Validators.requiredField(value, 'Please enter your full name'),
        ),
        const SizedBox(height: AppSizes.space20),
        AuthFormField(
          label: 'Email Address',
          hintText: 'Enter your email',
          controller: _emailController,
          prefixIcon: Iconsax.sms,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email,
        ),
        const SizedBox(height: AppSizes.space20),
        AuthPasswordField(
          label: 'Password',
          hintText: 'Create a password',
          controller: _passwordController,
          validator: (value) =>
              Validators.requiredField(value, 'Please create a password'),
        ),
        const SizedBox(height: AppSizes.space20),
        AuthPasswordField(
          label: 'Confirm Password',
          hintText: 'Confirm your password',
          controller: _confirmPasswordController,
          validator: (value) =>
              Validators.confirmPassword(value, _passwordController.text),
        ),
      ],
    );
  }
}
