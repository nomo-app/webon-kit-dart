import 'package:flutter/material.dart';

class NomoTheme {
  final String name;
  final String displayName;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color background;
  final Color settingsColumnColor;
  final Color surface;
  final Color error;
  final Color disabledColor;
  final Color snackBarColor;
  final Color foreground1;
  final Color foreground2;
  final Color foreground3;

  const NomoTheme({
    required this.name,
    required this.displayName,
    required this.disabledColor,
    required this.snackBarColor,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.background,
    required this.settingsColumnColor,
    required this.surface,
    required this.error,
    required this.foreground1,
    required this.foreground2,
    required this.foreground3,
  });

  factory NomoTheme.fromJson(Map<String, dynamic> json) {
    final colors = json['colors'];
    return NomoTheme(
      name: json['name'],
      displayName: json['displayName'],
      primary: Color(_parseColor(colors['primary'])),
      onPrimary: Color(_parseColor(colors['onPrimary'])),
      primaryContainer: Color(_parseColor(colors['primaryContainer'])),
      secondary: Color(_parseColor(colors['secondary'])),
      onSecondary: Color(_parseColor(colors['onSecondary'])),
      secondaryContainer: Color(_parseColor(colors['secondaryContainer'])),
      background: Color(_parseColor(colors['background'])),
      settingsColumnColor: Color(_parseColor(colors['settingsColumnColor'])),
      surface: Color(_parseColor(colors['surface'])),
      error: Color(_parseColor(colors['error'])),
      disabledColor: Color(_parseColor(colors['disabledColor'])),
      snackBarColor: Color(_parseColor(colors['snackBarColor'])),
      foreground1: Color(_parseColor(colors['foreground1'])),
      foreground2: Color(_parseColor(colors['foreground2'])),
      foreground3: Color(_parseColor(colors['foreground3'])),
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
      'name': name,
      'displayName': displayName,
      'colors': {
        'primary': primary.toHexColor(),
        'onPrimary': onPrimary.toHexColor(),
        'primaryContainer': primaryContainer.toHexColor(),
        'secondary': secondary.toHexColor(),
        'onSecondary': onSecondary.toHexColor(),
        'secondaryContainer': secondaryContainer.toHexColor(),
        'background': background.toHexColor(),
        'settingsColumnColor': settingsColumnColor.toHexColor(),
        'surface': surface.toHexColor(),
        'error': error.toHexColor(),
        'disabledColor': disabledColor.toHexColor(),
        'snackBarColor': snackBarColor.toHexColor(),
        'foreground1': foreground1.toHexColor(),
        'foreground2': foreground2.toHexColor(),
        'foreground3': foreground3.toHexColor(),
      }
    };
  }

  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: primary,
      colorScheme: ColorScheme(
        primary: primary,
        secondary: secondary,
        background: background,
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

extension ColorExtension on Color {
  String toHexColor() {
    return '0x${value.toRadixString(16).padLeft(8, '0')}';
  }
}
