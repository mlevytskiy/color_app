import 'dart:math';
import 'dart:ui';

/// utility class for generation random color
class RandomColorGenerator {
  static const int _biggestColorIntValue = 0xFFFFFF;

  /// generate random color
  Color generateColor() {
    return Color(Random().nextInt(_biggestColorIntValue)).withOpacity(1.0);
  }
}
