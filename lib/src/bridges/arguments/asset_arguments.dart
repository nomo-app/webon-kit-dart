import 'package:js/js.dart';

@JS()
@anonymous
class AssetArguments {
  external String get symbol;
  external factory AssetArguments({String symbol});
}