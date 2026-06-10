import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/auth/presentation/widgets/login_field_label.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_text_field.dart';

class AuthPasswordField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AuthPasswordField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginFieldLabel(label: widget.label),
        const SizedBox(height: AppSizes.space8),
        AuthTextField(
          controller: widget.controller,
          hintText: widget.hintText,
          prefixIcon: const Icon(Iconsax.lock, size: 20),
          obscureText: _obscureText,
          validator: widget.validator,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Iconsax.eye : Iconsax.eye_slash,
              size: 20,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
      ],
    );
  }
}
