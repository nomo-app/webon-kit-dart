import 'package:js/js.dart';

@JS()
@anonymous
class EvmMessageArguments {
  external String get message;
  external factory EvmMessageArguments({String message});
}
