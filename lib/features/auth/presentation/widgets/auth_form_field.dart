import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/auth/presentation/widgets/login_field_label.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_text_field.dart';

class AuthFormField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuthFormField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          LoginFieldLabel(label: label!),
          const SizedBox(height: AppSizes.space8),
        ],
        AuthTextField(
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }
}
