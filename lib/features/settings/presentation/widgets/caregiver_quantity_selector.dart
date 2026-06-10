import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class CaregiverQuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const CaregiverQuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              if (quantity > 1) onQuantityChanged(quantity - 1);
            },
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: () => onQuantityChanged(quantity + 1),
            icon: const Icon(Icons.add, color: AppColors.vi),
          ),
        ],
      ),
    );
  }
}
