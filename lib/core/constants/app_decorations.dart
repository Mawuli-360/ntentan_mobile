import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._();

  static final List<BoxShadow> modalOverlayShadow = [
    BoxShadow(
        offset: Offset(0, -2.3),
        color: Colors.black.withValues(alpha: 0.035),
        spreadRadius: 0,
        blurRadius: 2),
  ];

  static final List<BoxShadow> modalSheetShadow = [
    BoxShadow(
        offset: Offset(0, -2.3),
        color: Colors.black.withValues(alpha: 0.035),
        spreadRadius: 0,
        blurRadius: 2),
  ];
}
