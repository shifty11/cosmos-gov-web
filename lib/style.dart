import 'package:cosmos_gov_web/f_home/widgets/transition_builder_widget.dart';
import 'package:flutter/material.dart';


class Styles {
  static const enabledColor = Colors.green;

  static const selectCardBorderWith = 1.5;

  static ThemeData themeData(bool isDarkTheme) {
    final bg = isDarkTheme ? const Color(0xFF322F37) : Colors.white;
    final bgLight = isDarkTheme ? const Color(0xFF4B4555) : Colors.white;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final textColorLight = isDarkTheme ? Colors.grey : Colors.black;
    final borderColor = Colors.grey;
    return ThemeData(
      fontFamily: "Montserrat",
      primarySwatch: Colors.purple,
      // primaryColor: isDarkTheme ? Colors.purple : Colors.purple,
      // backgroundColor: isDarkTheme ? Colors.yellow : Colors.yellow,
      scaffoldBackgroundColor: isDarkTheme ? bg : Colors.white,
      canvasColor: isDarkTheme ? bg : Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: bgLight, unselectedItemColor: borderColor),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textColor),
        hintStyle: TextStyle(color: textColorLight),
        iconColor: borderColor,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor))
      ),
      dialogBackgroundColor: bg,
      textTheme: TextTheme(
        headline1: const TextStyle().copyWith(fontSize: 64),
        headline2: const TextStyle().copyWith(fontSize: 40),
        headline3: const TextStyle().copyWith(fontSize: 24),
        headline4: const TextStyle().copyWith(fontSize: 22),
        headline5: const TextStyle().copyWith(fontSize: 20),
        headline6: const TextStyle().copyWith(fontSize: 18),
        bodyText1: const TextStyle(),
        bodyText2: const TextStyle(),
        subtitle1: const TextStyle(),
        subtitle2: const TextStyle(),
        caption: const TextStyle(),
        overline: const TextStyle(),
        button: const TextStyle(),
      ).apply(
        bodyColor: textColor,
        displayColor: textColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: borderColor, // Button color
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.linux: NoAnimationTransitionsBuilder(),
          TargetPlatform.android: NoAnimationTransitionsBuilder(),
          TargetPlatform.fuchsia: NoAnimationTransitionsBuilder(),
          TargetPlatform.iOS: NoAnimationTransitionsBuilder(),
          TargetPlatform.macOS: NoAnimationTransitionsBuilder(),
          TargetPlatform.windows: NoAnimationTransitionsBuilder(),
        },
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
