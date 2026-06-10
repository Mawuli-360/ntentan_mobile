import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SOSCountdown extends StatelessWidget {
  final int countdown;
  final bool isSending;

  const SOSCountdown({
    super.key,
    required this.countdown,
    required this.isSending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.emergencyBg,
        border: Border.all(color: AppColors.emergency, width: 4),
      ),
      child: Center(
        child: isSending
            ? Semantics(
                liveRegion: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                          color: AppColors.emergency, strokeWidth: 3),
                    ),
                    const SizedBox(height: 8),
                    const Text('Sending...',
                        style: TextStyle(
                            color: AppColors.emergency,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            : Semantics(
                liveRegion: true,
                value: '$countdown seconds left',
                child: Text(
                  '$countdown',
                  style: const TextStyle(
                    fontSize: 56,
                    color: AppColors.emergency,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.05, 1.05),
            duration: 600.ms)
        .then()
        .scale(end: const Offset(1, 1), duration: 600.ms);
  }
}
