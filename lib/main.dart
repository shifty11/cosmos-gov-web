import 'package:cosmos_gov_web/f_home/widgets/transition_builder_widget.dart';
import 'package:cosmos_gov_web/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'config.dart';

void main() {
  final container = ProviderContainer();
  final router = container.read(routerProvider).router;

  runApp(ProviderScope(
      child: MaterialApp.router(
    title: 'Cosmos Governance',
    theme: ThemeData(
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        headline1: const TextStyle().copyWith(fontSize: 64),
        headline2: const TextStyle().copyWith(fontSize: 40),
        headline3: const TextStyle().copyWith(fontSize: 24),
        bodyText1: const TextStyle(),
        bodyText2: const TextStyle(),
        subtitle1: const TextStyle(),
        subtitle2: const TextStyle(),
        caption: const TextStyle(),
        overline: const TextStyle(),
        button: const TextStyle(),
      ).apply(
        bodyColor: textColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: textColor, // Button color
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
    ),
    builder: (context, widget) => ResponsiveWrapper.builder(
      BouncingScrollWrapper.builder(context, widget!),
      maxWidth: 1200,
      minWidth: 400,
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(400, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      ],
      background: Container(color: const Color(0xFF7E2323)),
    ),
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
  )));
}
