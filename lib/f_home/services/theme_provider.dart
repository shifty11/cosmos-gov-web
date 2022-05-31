@JS()
library script.js;

import 'dart:convert';

import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/services/state/theme_state.dart';
import 'package:cosmos_gov_web/f_home/services/type/custom_theme_data.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:js/js.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(),
);

@JS()
external String getTelegramThemeParams();

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState.initial(darkStyle: Styles.defaultTheme(true), lightStyle: Styles.defaultTheme(false))) {
    final data = getTelegramThemeParams();
    if (data.isNotEmpty) {
      try {
        Map<String, dynamic> decoded = json.decode(data);
        final themeParams = CustomThemeData.fromJson(decoded);
        final style = Styles.customTheme(themeParams);
        state = ThemeState.custom(style: style);
      } catch (e) {
        if (cDebugMode) {
          print("Could not get style from Telegram -> data: $data; error: $e");
        }
      }
    }
  }
}
