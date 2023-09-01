import 'package:color_app/strings.dart';
import 'package:color_app/util/color_brightness_detector_extension.dart';
import 'package:color_app/util/random_color_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ColorApp());
}

class _Style {
  static const double _homeTextFontSize = 30;
  _Style._();

  ///This method needs at least to make text visible over our background color.
  static TextStyle homeText({required Color backgroundColor}) {
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
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
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
  Color backgroundColor = RandomColorGenerator().generateColor();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            backgroundColor = RandomColorGenerator().generateColor();
          });
        },
        child: ColoredBox(
          color: backgroundColor,
          child: Center(
            child: Text(
              Strings.helloThere,
              style: _Style.homeText(backgroundColor: backgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}