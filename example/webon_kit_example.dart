import 'package:webon_kit_dart/webon_kit_dart.dart';

void main(List<String> args) async {
  final theme = await WebonKitDart.getLocalStorage(key: 'test');
  print(theme);
}
