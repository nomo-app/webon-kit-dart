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

  NomoColors copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? background1,
    Color? background2,
    Color? background3,
    Color? surface,
    Color? error,
    Color? disabled,
    Color? onDisabled,
    Color? foreground1,
    Color? foreground2,
    Color? foreground3,
  }) {
    return NomoColors(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      background1: background1 ?? this.background1,
      background2: background2 ?? this.background2,
      background3: background3 ?? this.background3,
      surface: surface ?? this.surface,
      error: error ?? this.error,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      foreground1: foreground1 ?? this.foreground1,
      foreground2: foreground2 ?? this.foreground2,
      foreground3: foreground3 ?? this.foreground3,
    );
  }

  factory NomoColors.lerp(NomoColors a, NomoColors b, double t) {
    return NomoColors(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      primary: Color.lerp(a.primary, b.primary, t)!,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(a.secondaryContainer, b.secondaryContainer, t)!,
      background1: Color.lerp(a.background1, b.background1, t)!,
      background2: Color.lerp(a.background2, b.background2, t)!,
      background3: Color.lerp(a.background3, b.background3, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      foreground1: Color.lerp(a.foreground1, b.foreground1, t)!,
      foreground2: Color.lerp(a.foreground2, b.foreground2, t)!,
      foreground3: Color.lerp(a.foreground3, b.foreground3, t)!,
      onDisabled: Color.lerp(a.onDisabled, b.onDisabled, t)!,
    );
  }

  factory NomoColors.fromJson(Map<String, dynamic> json) {
    return NomoColors(
      primary: Color(_parseColor(json['primary'])),
      brightness: Brightness.values[json['brightness'] as int],
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
      disabled: Color(_parseColor(json['disabled'])),
      onDisabled: Color(_parseColor(json['onDisabled'])),
      foreground1: Color(_parseColor(json['foreground1'])),
      foreground2: Color(_parseColor(json['foreground2'])),
      foreground3: Color(_parseColor(json['foreground3'])),
    );
  }
  static int _parseColor(dynamic hexColor) {
    if (hexColor is! String || hexColor.isEmpty) {
      return 0xFFFFFFFF; // Default color in case of hexColor is no string
    }
    final String color;
    if (hexColor.startsWith('#')) {
      color = hexColor.replaceFirst('#', '0xff');
    } else {
      color = hexColor;
    }
    final a = int.parse(color);
    return a;
  }

  Map<String, dynamic> toJson() {
    return {
      'primary': primary.toHexColor(),
      'brightness': brightness.index,
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
      'disabled': disabled.toHexColor(),
      'onDisabled': onDisabled.toHexColor(),
      'foreground1': foreground1.toHexColor(),
      'foreground2': foreground2.toHexColor(),
      'foreground3': foreground3.toHexColor(),
    };
  }

  @override
  int get hashCode => Object.hashAll([
        primary,
        brightness,
        onPrimary,
        primaryContainer,
        secondary,
        onSecondary,
        secondaryContainer,
        background1,
        background2,
        background3,
        surface,
        error,
        disabled,
        onDisabled,
        foreground1,
        foreground2,
        foreground3,
      ]);
  @override
  bool operator ==(Object other) {
    return other is NomoColors &&
        other.primary == primary &&
        other.brightness == brightness &&
        other.onPrimary == onPrimary &&
        other.primaryContainer == primaryContainer &&
        other.secondary == secondary &&
        other.onSecondary == onSecondary &&
        other.secondaryContainer == secondaryContainer &&
        other.background1 == background1 &&
        other.background2 == background2 &&
        other.background3 == background3 &&
        other.surface == surface &&
        other.error == error &&
        other.disabled == disabled &&
        other.onDisabled == onDisabled &&
        other.foreground1 == foreground1 &&
        other.foreground2 == foreground2 &&
        other.foreground3 == foreground3;
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
