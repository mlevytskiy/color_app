import 'dart:ui';

import 'package:color_app/util/random_color_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      "We try to be sure that our RandomColorGenerator generate true random "
      "colors and we want to check that amount of red, blue and green "
      "components. They should be quite similar in the sum of all colors if "
      "we generate colors a large number of times", () {
    //Arrange
    final RandomColorGenerator randomColorGenerator = RandomColorGenerator();
    const maxAmountOfIteration = 10000;
    const maxExpectedDiffInPercent = 1;
    int redColorSum = 0;
    int blueColorSum = 0;
    int greenColorSum = 0;

    //Act
    for (var i = 0; i < maxAmountOfIteration; i++) {
      final Color color = randomColorGenerator.generateColor();
      redColorSum += color.red;
      blueColorSum += color.blue;
      greenColorSum += color.green;
    }

    final int redBlueDiff = (redColorSum - blueColorSum).abs();
    final int blueGreenDiff = (blueColorSum - greenColorSum).abs();
    final int greenRedDiff = (greenColorSum - redColorSum).abs();

    final int middleSum = (redColorSum + blueColorSum + greenColorSum) ~/ 3;

    final int maxExpectedDiff =
        (middleSum / 100 * maxExpectedDiffInPercent).toInt();

    //Assert
    expect(
      redBlueDiff <= maxExpectedDiff,
      true,
      reason: "red and blue colors have more difference than "
          "$maxExpectedDiffInPercent percent. redColorSum=$redColorSum, "
          "blueColorSum=$blueColorSum, greenColorSum=$greenColorSum, "
          "diff=$redBlueDiff, maxExpectedDiff=$maxExpectedDiff",
    );
    expect(
      blueGreenDiff <= maxExpectedDiff,
      true,
      reason: "blue and green colors have more difference than "
          "$maxExpectedDiffInPercent percent. "
          "blueColorSum=$blueColorSum, greenColorSum=$greenColorSum"
          ", diff=$blueGreenDiff, maxExpectedDiff=$maxExpectedDiff",
    );
    expect(
      greenRedDiff <= maxExpectedDiff,
      true,
      reason: "red and green colors have more difference than "
          "$maxExpectedDiffInPercent percent. "
          "greenColorSum=$greenColorSum, greenColorSum=$greenColorSum"
          ", diff=$greenRedDiff, maxExpectedDiff=$maxExpectedDiff",
    );
  });
}
