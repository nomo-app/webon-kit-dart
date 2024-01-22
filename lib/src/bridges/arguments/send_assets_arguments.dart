import 'package:js/js.dart';
import 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';

@JS()
@anonymous
class NomoSendAssetsArguments {
  external AssetArguments get asset;
  external String get targetAddress;
  external String get amount;
  external factory NomoSendAssetsArguments(
      {AssetArguments asset, String targetAddress, String amount});
}
