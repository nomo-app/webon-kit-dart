import 'package:webon_kit_dart/src/models/theme/sub/nomo_colors.dart';

class NomoTheme {
  final String name;
  final String displayName;
  final NomoColors nomoColors;

  const NomoTheme(
      {required this.name,
      required this.displayName,
      required this.nomoColors});

  factory NomoTheme.fromJson(Map<String, dynamic> json) {
    final colors = json['colors'];
    return NomoTheme(
        name: json['name'],
        displayName: json['displayName'],
        nomoColors: NomoColors.fromJson(colors));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'colors': nomoColors.toJson()
    };
  }
}
