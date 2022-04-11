import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_subscription/widgets/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


const defaultTextStyle = TextStyle(color: Colors.black);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(800, 1000),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () {
          return MaterialApp(
            title: 'Cosmos Governance',
            theme: ThemeData(
                fontFamily: "Montserrat",
                primaryTextTheme: TextTheme(
                  headline1: defaultTextStyle.copyWith(fontSize: 48.sp),
                  headline2: defaultTextStyle.copyWith(fontSize: 32.sp),
                  headline3: defaultTextStyle.copyWith(fontSize: 24.sp),
                )),
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: Scaffold(
              body: Column(
                children: [
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final state = ref.watch(authStatusProvider);
                      return state.when(
                        loading: () => const CircularProgressIndicator(),
                        error: (err) => Text("error: " + err.toString()),
                        unauthorized: () => Text("unauthorized"),
                        authorized: () => SubscriptionPage(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
