import 'package:ntentan/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class PasswordConfirmModal extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(String password) onProceed;

  const PasswordConfirmModal({
    super.key,
    required this.onCancel,
    required this.onProceed,
  });

  @override
  State<PasswordConfirmModal> createState() => _PasswordConfirmModalState();
}

class _PasswordConfirmModalState extends State<PasswordConfirmModal> {
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Delete Account?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onCancel,
              child: const CircleAvatar(
                backgroundColor: AppColors.surfaceLight,
                radius: 13,
                child: Icon(
                  Icons.close,
                  color: AppColors.textPrimary,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'This action is permanent and cannot be undone. Please enter your password to confirm.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        AuthFormField(
          controller: _passwordController,
          hintText: 'Enter your password',
          obscureText: _obscureText,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textMuted,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: widget.onCancel,
                child: const Text('Keep Account',
                    style: TextStyle(color: AppColors.textPrimary)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emergency,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  final password = _passwordController.text.trim();
                  if (password.isNotEmpty) {
                    widget.onProceed(password);
                  }
                },
                child: const Text('Delete',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
