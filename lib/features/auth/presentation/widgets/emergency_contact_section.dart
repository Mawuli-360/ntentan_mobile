import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class EmergencyContactSection extends StatelessWidget {
  final String? initialName;
  final String? initialPhone;
  final String? initialRelationship;
  final Function(String name, String phone, String relationship) onChanged;

  const EmergencyContactSection({
    super.key,
    this.initialName,
    this.initialPhone,
    this.initialRelationship,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space20),
      decoration: BoxDecoration(
        color: AppColors.emergencyBg,
        border: Border.all(color: AppColors.emergencyBorder),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emergency_outlined,
                  color: AppColors.emergency, size: 22),
              const SizedBox(width: AppSizes.space8),
              Text(
                'Emergency Contact',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.emergency,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.space4),
          Text(
            'This person will be contacted in emergencies.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSizes.space16),
          TextFormField(
            initialValue: initialName,
            onChanged: (v) => onChanged(v, initialPhone ?? '', initialRelationship ?? ''),
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'Contact name',
              prefixIcon: Icon(Icons.person_outline_rounded,
                  color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: AppSizes.space12),
          TextFormField(
            initialValue: initialRelationship,
            onChanged: (v) => onChanged(initialName ?? '', initialPhone ?? '', v),
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'Relationship (e.g. Spouse)',
              prefixIcon: Icon(Icons.family_restroom_rounded,
                  color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: AppSizes.space12),
          TextFormField(
            initialValue: initialPhone,
            onChanged: (v) => onChanged(initialName ?? '', v, initialRelationship ?? ''),
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'Phone number',
              prefixIcon: Icon(Icons.phone_outlined,
                  color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
