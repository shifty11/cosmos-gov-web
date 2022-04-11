import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_home/widgets/routes.dart';
import 'package:cosmos_gov_web/f_subscription/widgets/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

const defaultTextStyle = TextStyle(color: Colors.black);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      // initialRoute: Routes.home,
      // onGenerateRoute: (RouteSettings settings) {
      //   switch (settings.name) {
      //     case Routes.home:
      //       return const ListPage();
      //     case Routes.post:
      //       return const PostPage();
      //     case Routes.style:
      //       return const TypographyPage();
      //     default:
      //       return const SizedBox.shrink();
      //   }
      // },
      home: Scaffold(
        body: Column(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final state = ref.watch(authStatusProvider);
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (err) => Text("error: " + err.toString()),
                  unauthorized: () => const Text("unauthorized"),
                  authorized: () => const SubscriptionPage(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
