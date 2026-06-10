import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/app_spacing.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/utils/app_loader_anim.dart';
import 'package:ntentan/shared/widgets/app_button.dart';
import 'package:ntentan/shared/widgets/app_text.dart';

/* -------------------------------------------------------------------- */
/*                         MODAL ALIGNMENT ENUM                         */
/* -------------------------------------------------------------------- */

enum ModalAlignment {
  center,
  bottomCenter,
}

/* -------------------------------------------------------------------- */
/*                         CUSTOM OVERLAY MODAL                         */
/* -------------------------------------------------------------------- */

class OverlayModal extends StatefulWidget {
  final Widget child;
  final bool isDismissible;
  final Duration animationDuration;
  final VoidCallback onDismiss;
  final ModalAlignment alignment;

  const OverlayModal({
    super.key,
    required this.child,
    required this.isDismissible,
    required this.animationDuration,
    required this.onDismiss,
    this.alignment = ModalAlignment.center, 
  });

  @override
  State<OverlayModal> createState() => _OverlayModalState();
}

class _OverlayModalState extends State<OverlayModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.alignment == ModalAlignment.bottomCenter
          ? const Offset(0, 1)
          : Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _animationController.reverse();
    widget.onDismiss();
  }

  Widget _buildModalContent() {
    if (widget.alignment == ModalAlignment.bottomCenter) {
      return SlideTransition(
        position: _slideAnimation,
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: widget.child,
        ),
      );
    } else {
      return Transform.scale(
        scale: _scaleAnimation.value,
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: widget.child,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Blurred background overlay
            Positioned.fill(
              child: GestureDetector(
                onTap: widget.isDismissible ? _dismiss : null,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: AppColors.surface
                        .withValues(alpha: 0.8 * _fadeAnimation.value),
                  ),
                ),
              ),
            ),

            // Modal content with alignment
            Align(
              alignment: widget.alignment == ModalAlignment.bottomCenter
                  ? Alignment.bottomCenter
                  : Alignment.center,
              child: _buildModalContent(),
            ),
          ],
        );
      },
    );
  }
}

// Reusable modal container with consistent styling
class ModalContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showCloseButton;
  final VoidCallback? onClose;
  final ModalAlignment alignment;

  const ModalContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.showCloseButton = true,
    this.onClose,
    this.alignment = ModalAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final isBottomAligned = alignment == ModalAlignment.bottomCenter;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.85,
        height: height,
        margin: isBottomAligned ? EdgeInsets.zero : const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: padding ?? const EdgeInsets.all(24),
              child: child,
            ),

            // Close button
            if (showCloseButton)
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: onClose ?? () => context.removeModal(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------- */
/*                           App Confirm Modal                          */
/* -------------------------------------------------------------------- */

class AppConfirmModal extends StatelessWidget {
  const AppConfirmModal({
    super.key,
    this.onCancel,
    this.onProceed,
    required this.title,
    required this.description,
    this.onCancelText = 'Cancel',
    this.onProceedText = 'Proceed',
  });

  final String title;
  final String description;
  final String onCancelText;
  final String onProceedText;
  final VoidCallback? onCancel;
  final VoidCallback? onProceed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: AppText(
                      title,
                      fontWeight: FontWeight.w600,
                    ))),
            GestureDetector(
              onTap: onCancel,
              child: CircleAvatar(
                backgroundColor: AppColors.surfaceLight,
                radius: 13,
                child: const Icon(
                  Icons.close,
                  color: AppColors.textPrimary,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.gapH24,
        AppText(
          description,
          textAlign: TextAlign.center,
        ),
        AppSpacing.gapH24,
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: onCancel,
                child: AppText(onCancelText),
              ),
            ),
            AppSpacing.gapW12,
            Expanded(
              child: AppButton(
                text: onProceedText,
                width: double.infinity,
                backgroundColor: AppColors.error,
                onPressed: onProceed,
              ),
            ),
          ],
        )
      ],
    );
  }
}

/* -------------------------------------------------------------------- */
/*                            LOADING MODAL                             */
/* -------------------------------------------------------------------- */

class AppLoadingModal extends StatelessWidget {
  const AppLoadingModal({super.key, this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLoaderAnim.spinkitFadingCircle(50, color: AppColors.vi),
        SizedBox(height: AppSizes.space16),
        Text(description ?? 'Loading, please wait...'),
      ],
    );
  }
}
