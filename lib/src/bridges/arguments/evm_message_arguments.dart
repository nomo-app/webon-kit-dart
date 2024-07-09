import 'dart:js_interop';

@JS()
@anonymous
class EvmMessageArguments {
  external String get message;
  external factory EvmMessageArguments({String message});
}
