import 'dart:js_util';

import 'package:js/js.dart';

@JS()
external dynamic getCurrentNomoTheme();

class ThemeBridge {
  //TODO implement NomoThemeData
  static Future<Map<String, dynamic>> getAppTheme() async {
    try {
      final jsGetThemePromise = getCurrentNomoTheme();

      final futureGetTheme = promiseToFuture(jsGetThemePromise);
      final result = await futureGetTheme;
      if (result is! Map<String, dynamic>) {
        throw Exception("Theme is not a Map<String, dynamic>");
      }
      return result;
    } catch (e) {
      return {};
    }
  }
}
