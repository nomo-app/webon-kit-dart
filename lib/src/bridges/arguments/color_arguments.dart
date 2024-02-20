import 'package:js/js.dart';

@JS()
@anonymous
class ColorArguments {
  external String get colors;
  external factory ColorArguments({required String colors});
}
