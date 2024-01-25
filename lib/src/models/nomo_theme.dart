import 'package:nomo_ui_kit/theme/sub/nomo_color_theme.dart';

class NomoCurrentTheme {
  final String name;
  final String displayname;
  final NomoColors colors;

  NomoCurrentTheme({
    required this.name,
    required this.displayname,
    required this.colors,
  });

  factory NomoCurrentTheme.fromJson(Map<String, dynamic> map) {
    return NomoCurrentTheme(
      name: map['name'],
      displayname: map['displayname'],
      colors: NomoColors.fromJson(map['colors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayname': displayname,
      'colors': colors.toJson(),
    };
  }
}
