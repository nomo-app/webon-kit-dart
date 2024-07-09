import 'dart:js_interop';

@JS()
@anonymous
class ColorArguments {
  external String get colors;
  external factory ColorArguments({required String colors});
}
