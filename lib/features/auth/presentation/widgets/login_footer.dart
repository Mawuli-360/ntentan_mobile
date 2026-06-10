import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback? onSignUpTap;

  const LoginFooter({
    super.key,
    this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: onSignUpTap ?? () {},
          child: Text(
            'Sign Up',
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
