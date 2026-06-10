import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  /// Prevent instantiation
  AppImages._();

  /* -------------------------------------------------------------------- */
  /*                             BACKGROUND IMAGES                        */
  /* -------------------------------------------------------------------- */

  static final AssetImage authBg = AssetImage("assets/images/auth_bg.png");

  /* -------------------------------------------------------------------- */
  /*                              ICON IMAGES                             */
  /* -------------------------------------------------------------------- */

  static final AssetImage blind = AssetImage("assets/icons/blind.png");
  static final AssetImage ntentan = AssetImage("assets/icons/ntentan.png");
  static final AssetImage pill = AssetImage("assets/icons/pill.png");
  static final AssetImage drug = AssetImage("assets/icons/drugs.png");

  /* -------------------------------------------------------------------- */
  /*                             SVG PICTURES                             */
  /* -------------------------------------------------------------------- */

  static const String google = "assets/icons/google.svg";

  static SvgPicture getSvg(
    String assetPath, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit,
    );
  }
}
