import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class ProfileNameInput extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const ProfileNameInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Name',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: AppSizes.space8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            hintText: 'Enter your name',
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}
