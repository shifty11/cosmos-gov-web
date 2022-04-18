import 'package:cosmos_gov_web/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

const defaultTextStyle = TextStyle(color: Colors.black);

void main() {
  final container = ProviderContainer();
  final router = container.read(routerProvider).router;

  runApp(ProviderScope(
      child: MaterialApp.router(
    title: 'Cosmos Governance',
    theme: ThemeData(
        fontFamily: "Montserrat",
        primaryTextTheme: TextTheme(
          headline1: defaultTextStyle.copyWith(fontSize: 64),
          headline2: defaultTextStyle.copyWith(fontSize: 40),
          headline3: defaultTextStyle.copyWith(fontSize: 24),
        )),
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
