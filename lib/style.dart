import 'package:cosmos_gov_web/f_home/widgets/transition_builder_widget.dart';
import 'package:flutter/material.dart';


class Styles {
  static const enabledColor = Colors.green;

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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: bgLight),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textColor),
        hintStyle: TextStyle(color: textColorLight),
        iconColor: borderColor,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor))
      ),
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
    // return ThemeData(
    //   primarySwatch: Colors.red,
    //   primaryColor: isDarkTheme ? Colors.black : Colors.white,
    //
    //   backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
    //
    //   indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
    //   buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
    //
    //   hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
    //
    //   highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
    //   hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
    //
    //   focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
    //   disabledColor: Colors.grey,
    //   textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
    //   cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
    //   canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
    //   brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    //   buttonTheme: Theme.of(context).buttonTheme.copyWith(
    //       colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
    //   appBarTheme: AppBarTheme(
    //     elevation: 0.0,
    //   ),
    // );
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
