import 'package:color_app/color_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    "Check if text 'Hello there' exist on first screen of application",
    (WidgetTester tester) async {
      await tester.pumpWidget(const ColorApp());

      expect(find.text("Hello there"), findsOneWidget);
    },
  );
}
