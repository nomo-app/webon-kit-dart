library webon_kit_dart;

import 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';

export 'src/bridges/metamask_bridge.dart';

class WebonKitDart {
  /// Returns the public EVM Address of the Nomo App
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<String> getEvmAddress() async {
    return await WalletBridge.getEvmAddress();
  }

  /// Signs an EVM transaction with the Nomo App
  /// [unsignedTxRaw] is the raw hex of the unsigned transaction
  /// Returns the signed transaction in raw hex format
  static Future<String> signTransaction(String unsignedTxRaw) async {
    return await WalletBridge.signTransaction(unsignedTxRaw);
  }

  /// Returns all assets available in the Nomo App
  /// Returns a list of [JSAsset] objects
  static Future<List<Asset>> getAllAssets() async {
    return await WalletBridge.getAllAssets();
  }

  static bool isFallBackMode() {
    return WalletBridge.fallbackModeActive();
  }
}
