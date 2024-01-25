import 'dart:js_util';

import 'package:flutter/widgets.dart';
import 'package:js/js.dart';
import 'package:webon_kit_dart/src/models/nomo_theme.dart';

@JS()
external dynamic getCurrentNomoTheme();

class ThemeBridge {
  static Future<NomoCurrentTheme?> getAppTheme() async {
    try {
      final jsGetThemePromise = getCurrentNomoTheme();

      final futureGetTheme = promiseToFuture(jsGetThemePromise);
      final result = await futureGetTheme;
      if (result is! Map<String, dynamic>) {
        throw Exception("Theme is not a Map<String, dynamic>");
      }
      final theme = NomoCurrentTheme.fromJson(result);
      return theme;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
