import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: () => context.pushReplacement(RoutePaths.login),
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: AppColors.vi,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
