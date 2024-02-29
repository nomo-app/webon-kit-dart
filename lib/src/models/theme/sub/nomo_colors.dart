import 'package:flutter/material.dart';
import 'package:webon_kit_dart/src/utils/extensions.dart';

class NomoColors {
  final Color primary;
  final Brightness brightness;
  final Color onPrimary;
  final Color primaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color background1;
  final Color background2;
  final Color background3;
  final Color surface;
  final Color error;
  final Color disabled;
  final Color onDisabled;
  final Color foreground1;
  final Color foreground2;
  final Color foreground3;

  const NomoColors({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.background1,
    required this.background2,
    required this.background3,
    required this.surface,
    required this.error,
    required this.disabled,
    required this.foreground1,
    required this.foreground2,
    required this.foreground3,
    required this.onDisabled,
  });

  factory NomoColors.fromJson(Map<String, dynamic> json) {
    return NomoColors(
      primary: Color(_parseColor(json['primary'])),
      brightness: Brightness.values[json['brightness']],
      onDisabled: Color(_parseColor(json['onDisabled'])),
      onPrimary: Color(_parseColor(json['onPrimary'])),
      primaryContainer: Color(_parseColor(json['primaryContainer'])),
      secondary: Color(_parseColor(json['secondary'])),
      onSecondary: Color(_parseColor(json['onSecondary'])),
      secondaryContainer: Color(_parseColor(json['secondaryContainer'])),
      background1: Color(_parseColor(json['background1'])),
      background2: Color(_parseColor(json['background2'])),
      background3: Color(_parseColor(json['background3'])),
      surface: Color(_parseColor(json['surface'])),
      error: Color(_parseColor(json['error'])),
      disabled: Color(_parseColor(json['disabledColor'])),
      foreground1: Color(_parseColor(json['foreground1'])),
      foreground2: Color(_parseColor(json['foreground2'])),
      foreground3: Color(_parseColor(json['foreground3'])),
    );
  }

  static int _parseColor(dynamic hexColor) {
    if (hexColor is! String || hexColor.isEmpty) {
      return 0xFFFFFFFF; // Default color in case hexColor is not a string
    }
    final String color;
    if (hexColor.startsWith('#')) {
      final temp = hexColor.replaceFirst('#', '0xff');
      color = temp.substring(0, temp.length - 2);
    } else {
      color = hexColor;
    }
    return int.parse(color);
  }

  Map<String, dynamic> toJson() {
    return {
      'primary': primary.toHexColor(),
      'brightness': brightness,
      'onDisabled': onDisabled.toHexColor(),
      'onPrimary': onPrimary.toHexColor(),
      'primaryContainer': primaryContainer.toHexColor(),
      'secondary': secondary.toHexColor(),
      'onSecondary': onSecondary.toHexColor(),
      'secondaryContainer': secondaryContainer.toHexColor(),
      'background1': background1.toHexColor(),
      'background2': background2.toHexColor(),
      'background3': background3.toHexColor(),
      'surface': surface.toHexColor(),
      'error': error.toHexColor(),
      'disabledColor': disabled.toHexColor(),
      'foreground1': foreground1.toHexColor(),
      'foreground2': foreground2.toHexColor(),
      'foreground3': foreground3.toHexColor(),
    };
  }

  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: primary,
      colorScheme: ColorScheme(
        primary: primary,
        secondary: secondary,
        background: background1,
        surface: surface,
        onBackground: foreground1,
        onSurface: foreground1,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        brightness: Brightness.light,
        error: error,
        onError: foreground1,
      ),
    );
  }
}
