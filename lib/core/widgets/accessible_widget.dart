import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/services/accessibility/haptic_service.dart';

class AccessibleWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final String? hint;
  final String? value;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Map<CustomSemanticsAction, VoidCallback>? customActions;
  final bool excludeSemantics;
  final bool mergeSemantics;
  final bool triggerHapticOnTap;

  const AccessibleWidget({
    super.key,
    required this.child,
    required this.label,
    this.hint,
    this.value,
    this.onTap,
    this.onLongPress,
    this.customActions,
    this.excludeSemantics = false,
    this.mergeSemantics = false,
    this.triggerHapticOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (excludeSemantics) {
      return ExcludeSemantics(child: child);
    }

    Widget content = child;

    if (onTap != null || onLongPress != null) {
      content = GestureDetector(
        onTap: () {
          if (triggerHapticOnTap) {
            sl<HapticService>().tapFeedback();
          }
          onTap?.call();
        },
        onLongPress: () {
          if (triggerHapticOnTap) {
            sl<HapticService>().longPressFeedback();
          }
          onLongPress?.call();
        },
        child: content,
      );
    }

    final semantics = Semantics(
      container: true,
      label: label,
      hint: hint,
      value: value,
      button: onTap != null,
      onTapHint: hint,
      onLongPressHint: onLongPress != null ? "Long press for more options" : null,
      customSemanticsActions: customActions,
      child: content,
    );

    return mergeSemantics ? MergeSemantics(child: semantics) : semantics;
  }
}
