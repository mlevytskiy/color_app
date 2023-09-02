import 'package:color_app/strings.dart';
import 'package:color_app/util/color_check_brightness_extension.dart';
import 'package:color_app/util/random_color_generator.dart';
import 'package:flutter/material.dart';

class _Style {
  static const double _homeTextFontSize = 30;
  _Style._();

  static TextStyle _homeText({required Color backgroundColor}) {
    return TextStyle(
      fontSize: _homeTextFontSize,
      color: _textColor(backgroundColor: backgroundColor),
    );
  }

  static Color _textColor({required Color backgroundColor}) {
    return backgroundColor.isDark() ? Colors.white : Colors.black;
  }
}

///Color app. Entry point
class ColorApp extends StatelessWidget {
  ///public constructor
  const ColorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

///home screen
class HomePage extends StatefulWidget {
  ///public constructor
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = RandomColorGenerator().generateColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(
          () => _backgroundColor = RandomColorGenerator().generateColor(),
        ),
        child: ColoredBox(
          color: _backgroundColor,
          child: Center(
            child: Text(
              Strings.helloThere,
              style: _Style._homeText(backgroundColor: _backgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
