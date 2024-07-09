import 'dart:js_interop';

@JS()
@anonymous
class AuthMessageArguments {
  external String get message;
  external String get url;
  external factory AuthMessageArguments({String message, String url});
}
