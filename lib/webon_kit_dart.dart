library webon_kit_dart;

export 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
export 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
export 'package:webon_kit_dart/src/models/token.dart';
export 'package:webon_kit_dart/src/models/user_matrix.dart';
export 'package:webon_kit_dart/src/models/url_launch_mode.dart';
export 'package:webon_kit_dart/src/models/nomo_theme.dart';

import 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/auth_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/evm_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
import 'package:webon_kit_dart/src/bridges/auth_bridge.dart';
import 'package:webon_kit_dart/src/bridges/chat_bridge.dart';
import 'package:webon_kit_dart/src/bridges/theme_bridge.dart';
import 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';
import 'package:webon_kit_dart/src/models/token.dart';
import 'package:webon_kit_dart/src/models/url_launch_mode.dart';
import 'package:webon_kit_dart/src/models/user_matrix.dart';

typedef AssetPrice = Map<String, dynamic>;

/// A Calculator.
class WebonKitDart {
  /// Logs into the Chat Server by calling the Nomo App function.
  static Future<UserMatrix> nomoChatLogin() async {
    return await ChatBridge.getNomoLogin();
  }

  /// Returns the public EVM Address of the Nomo App
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<String> getEvmAddress() async {
    return await WalletBridge.getEvmAddress();
  }

  /// Send Assets to [targetAddress] with [amount] of [symbol]
  /// Cannot be used outside the Nomo App.
  static Future<String> sendAssets(
      {required String amount,
      required String targetAddress,
      required String symbol}) async {
    final arguments = NomoSendAssetsArguments(
        asset: AssetArguments(symbol: symbol),
        amount: amount,
        targetAddress: targetAddress);
    return await WalletBridge.sendAssets(sendAssetsArguments: arguments);
  }

  /// Returns the balance of [symbol]
  /// Cannot be used outside the Nomo App.
  static Future<String> getBalance({required String symbol}) async {
    final args = AssetArguments(symbol: symbol);
    return await WalletBridge.getBalance(assetArguments: args);
  }

  /// Returns a List of Tokens that are visible in the Nomo App
  /// Cannot be used outside the Nomo App.
  static Future<List<Token>> getVisibleAssets() async {
    return await WalletBridge.getAssetsFromNomo();
  }

  /// Returns the price of [symbol]
  /// Cannot be used outside the Nomo App.
  static Future<AssetPrice> getAssetPrice({required String symbol}) async {
    final args = AssetArguments(symbol: symbol);
    return await WalletBridge.getAssetPrice(assetArguments: args);
  }

  /// Returns the signed message of [message]
  /// Cannot be used outside the Nomo App.
  static Future<String> signEvmMessage({required String message}) async {
    final args = EvmMessageArguments(message: message);
    return await WalletBridge.signEvmMessage(message: args);
  }

  /// Returns the signed message of [message]
  /// Cannot be used outside the Nomo App.
  static Future<String> signAuthMessage(
      {required String message, required String url}) async {
    final args = AuthMessageArguments(message: message, url: url);
    return await AuthBridge.signAuthMessage(message: args);
  }

  /// Returns the chat address
  /// Cannot be used outside the Nomo App.
  // static Future<String> getChatAddress() async {
  //   return await ChatBridge.getMessengerAddress();
  // }

  /// Launches a [url] with the [launchMode] provided
  static Future<void> launchUrl(
      {required String url,
      required WebonKitDartUrlLaunchMode launchMode}) async {
    final urlArguments = UrlArguments(url: url, launchMode: launchMode.name);
    await WalletBridge.launchUrl(urlArguments: urlArguments);
  }

  /// Returns the receive address of [symbol]
  static Future<String?> getMultiChainReceiveAddress(
      {required String symbol}) async {
    final args = AssetArguments(symbol: symbol);
    return await WalletBridge.getMultiChainReceiveAddress(assetArguments: args);
  }

  /// Sets a [key] and [value] in the local storage
  static Future<void> setLocalStorage(
      {required String key, required String value}) async {
    await WalletBridge.setLocalStorage(key: key, value: value);
  }

  /// Returns the value of [key] from the local storage
  static Future<dynamic> getLocalStorage({required String key}) async {
    return await WalletBridge.getLocalStorage(key: key);
  }

  /// returns a map of the current app theme
  static Future<Map<String, dynamic>> getCurrentAppTheme() async {
    return await ThemeBridge.getAppTheme();
  }
}
