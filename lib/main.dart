import 'package:cosmos_gov_web/f_home/widgets/transition_builder_widget.dart';
import 'package:cosmos_gov_web/routes.dart';
import 'package:cosmos_gov_web/style.dart';
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
    theme: Styles.themeData(false),
    darkTheme: Styles.themeData(true),
    themeMode: ThemeMode.system,
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
      background: Container(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black : Colors.white),
    ),
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
  )));
}
