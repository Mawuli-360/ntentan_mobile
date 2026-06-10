import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s32 = 32;

  // Shortcuts used in user's modal code
  static const EdgeInsets a4 = EdgeInsets.all(s4);
  static const EdgeInsets a12 = EdgeInsets.all(s12);
  static const EdgeInsets a24 = EdgeInsets.all(s24);

  static const SizedBox gapW12 = SizedBox(width: s12);
  static const SizedBox gapH24 = SizedBox(height: s24);
}
