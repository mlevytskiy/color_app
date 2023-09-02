import 'dart:ui';

///extension helps to detect if current color bright or not
extension ColorCheckBrightnessExtension on Color {
  ///just for determinate if it is color closer for dark color or for light.
  ///If it is exactly 0.5 - it is mean that color brightness is in the middle.
  static const double _middleBrightness = 0.5;

  ///detect how bright current color and if it is dark return true.
  bool isDark() => computeLuminance() < _middleBrightness;
}
