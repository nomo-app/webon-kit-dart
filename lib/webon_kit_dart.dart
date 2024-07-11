library webon_kit_dart;

// import 'package:nomo_ui_kit/theme/sub/nomo_color_theme.dart';
import 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';

typedef AssetPrice = Map<String, dynamic>;

class WebonKitDart {
  /// Returns the public EVM Address of the Nomo App
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<String> getEvmAddress() async {
    return await WalletBridge.getEvmAddress();
  }
}
