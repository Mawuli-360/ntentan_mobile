import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoaderAnim {
  AppLoaderAnim._();

  static spinkitFadingCircle(double size,
      {Color color = const Color(0xff4BAAA2)}) {
    return SpinKitFadingCircle(
      color: color,
      size: size,
    );
  }

  static spinKitCircle(double size, {Color color = const Color(0xff4BAAA2)}) {
    return SpinKitCircle(
      color: color,
      size: size,
    );
  }

  static spinFadingCube(double size, {Color color = const Color(0xff4BAAA2)}) {
    return SpinKitFadingCube(
      color: color,
      size: size,
    );
  }
}
