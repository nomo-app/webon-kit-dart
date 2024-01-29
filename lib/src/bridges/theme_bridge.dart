import 'dart:js_util';

import 'package:flutter/widgets.dart';
import 'package:js/js.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';

@JS()
external dynamic getCurrentNomoTheme();

class ThemeBridge {
  static Future<NomoTheme> getAppTheme() async {
    try {
      final jsGetThemePromise = getCurrentNomoTheme();

      final futureGetTheme = promiseToFuture(jsGetThemePromise);
      final result = await futureGetTheme;
      final name = getProperty(result, 'name');
      final displayName = getProperty(result, 'displayName');
      final colors = getProperty(result, 'colors');

      final primary = getProperty(colors, 'primary');
      final onPrimary = getProperty(colors, 'onPrimary');
      final primaryContainer = getProperty(colors, 'primaryContainer');
      final secondary = getProperty(colors, 'secondary');
      final onSecondary = getProperty(colors, 'onSecondary');
      final secondaryContainer = getProperty(colors, 'secondaryContainer');
      final background = getProperty(colors, 'background');
      final settingsColumnColor = getProperty(colors, 'settingsColumnColor');
      final surface = getProperty(colors, 'surface');
      final error = getProperty(colors, 'error');
      final disabledColor = getProperty(colors, 'disabledColor');
      final snackBarColor = getProperty(colors, 'snackBarColor');
      final foreground1 = getProperty(colors, 'foreground1');
      final foreground2 = getProperty(colors, 'foreground2');
      final foreground3 = getProperty(colors, 'foreground3');

      Map<String, dynamic> theme = {
        'name': name,
        'displayName': displayName,
        'colors': {
          'primary': primary,
          'onPrimary': onPrimary,
          'primaryContainer': primaryContainer,
          'secondary': secondary,
          'onSecondary': onSecondary,
          'secondaryContainer': secondaryContainer,
          'background': background,
          'settingsColumnColor': settingsColumnColor,
          'surface': surface,
          'error': error,
          'disabledColor': disabledColor,
          'snackBarColor': snackBarColor,
          'foreground1': foreground1,
          'foreground2': foreground2,
          'foreground3': foreground3
        }
      };

      return NomoTheme.fromJson(theme);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
