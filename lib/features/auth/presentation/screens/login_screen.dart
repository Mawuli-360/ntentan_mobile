import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/core/utils/validators.dart';

import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/auth/presentation/mixins/auth_navigation_mixin.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_layout.dart';
import 'package:ntentan/features/auth/presentation/widgets/login_footer.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_password_field.dart';

/// Email Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AuthNavigationMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _processLoginRequest(
      BuildContext context, AuthController authController) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.showLoadingModal('Signing in...');

    final success = await authController.signInWithEmail(
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
      title: 'Welcome Back',
      subtitle: 'Please sign in to your Ntentan account.',
      buttonLabel: 'Sign In',
      buttonIcon: Iconsax.login,
      onButtonPressed: () => _processLoginRequest(context, authController),
      footerWidget: LoginFooter(
        onSignUpTap: () => context.push(RoutePaths.signUp),
      ),
      formChildren: [
        AuthFormField(
          label: 'Email Address',
          hintText: 'Enter your email',
          controller: _emailController,
          prefixIcon: Iconsax.sms,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email,
        ),
        const SizedBox(height: AppSizes.space24),
        AuthPasswordField(
          label: 'Password',
          hintText: 'Enter your password',
          controller: _passwordController,
          validator: (value) =>
              Validators.requiredField(value, 'Please enter your password'),
        ),
        const SizedBox(height: AppSizes.space16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style:
                  TextStyle(color: AppColors.vi, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
