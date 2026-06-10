import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_decorations.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/shared/modal/app_modal.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

/// Global variable to track current overlay for general modals
OverlayEntry? _currentModalOverlay;

extension ContextExtensions on BuildContext {
  /// Shows a standard snackbar
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Shows an error snackbar with a red background
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.redAccent,
    );
  }

  /// Shows a success snackbar with a green background
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
    );
  }

  /// Shows an info snackbar with the primary accent color
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: AppColors.vi,
    );
  }

  /* -------------------------------------------------------------------- */
  /*                             LOADING MODAL                            */
  /* -------------------------------------------------------------------- */

  void showLoadingModal([String? message]) {
    showModalSheet(
      barrierDismissible: false,
      centerDialog: true,
      content: AppLoadingModal(
        description: message,
      ),
    );
  }

  void hideLoadingModal() {
    Navigator.of(this, rootNavigator: true).pop();
  }

  /* -------------------------------------------------------------------- */
  /*                             OVERLAY MODAL                            */
  /* -------------------------------------------------------------------- */
  void showModal({
    required Widget child,
    bool isDismissible = true,
    Duration? animationDuration,
    ModalAlignment? alignment,
  }) {
    // Remove existing overlay if present
    removeModal();

    _currentModalOverlay = OverlayEntry(
      builder: (context) => OverlayModal(
        isDismissible: isDismissible,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 300),
        onDismiss: removeModal,
        alignment: alignment ?? ModalAlignment.center,
        child: child,
      ),
    );

    Overlay.of(this).insert(_currentModalOverlay!);
  }

  void removeModal() {
    if (_currentModalOverlay != null) {
      _currentModalOverlay!.remove();
      _currentModalOverlay = null;
    }
  }

  bool get hasActiveModal => _currentModalOverlay != null;

/* -------------------------------------------------------------------- */
/*                          BOTTOM SHEET MODAL                          */
/* -------------------------------------------------------------------- */

  Future<T?> showModalSheet<T>({
    WoltModalSheetPageListBuilder? pageListBuilder,
    Widget Function(BuildContext modalContext)? contentBuilder,
    bool showDragHandle = false,
    Color? modalBarrierColor,
    Color? backdropColor,
    double? backdropBlurSigma,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    WoltModalSheetAnimationStyle? animationStyle,
    bool barrierDismissible = true,
    bool useSafeArea = true,
    bool centerDialog = false,
    Widget? content,
  }) {
    return WoltModalSheet.show<T>(
      showDragHandle: showDragHandle,
      context: this,
      modalBarrierColor: modalBarrierColor ?? Colors.transparent,
      barrierDismissible: barrierDismissible,
      useRootNavigator: true,
      modalTypeBuilder: centerDialog
          ? (context) => WoltModalType.dialog()
          : (context) => WoltModalType.bottomSheet(),
      modalDecorator: (child) {
        return ColoredBox(
          color: (backdropColor ?? AppColors.bg).withValues(alpha: 0.4),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: backdropBlurSigma ?? 2,
              sigmaY: backdropBlurSigma ?? 2,
            ),
            child: child,
          ),
        );
      },
      pageContentDecorator: (widget) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            boxShadow: boxShadow ?? AppDecorations.modalOverlayShadow,
          ),
          child: widget,
        );
      },
      pageListBuilder: pageListBuilder ??
          (modalSheetContext) {
            final Widget? modalContent = contentBuilder != null
                ? contentBuilder(modalSheetContext)
                : content;
            if (centerDialog && modalContent != null) {
              return [
                SliverWoltModalSheetPage(
                  navBarHeight: 1,
                  mainContentSliversBuilder: (context) => [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: modalContent,
                      ),
                    ),
                  ],
                ),
              ];
            }
            return [];
          },
    );
  }
}
