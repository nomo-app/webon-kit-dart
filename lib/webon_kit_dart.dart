library webon_kit_dart;

export 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
export 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
export 'package:webon_kit_dart/src/bridges/chat_bridge.dart';
export 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';
export 'package:webon_kit_dart/src/models/token.dart';
export 'package:webon_kit_dart/src/models/user_matrix.dart';

import 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/auth_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/evm_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
import 'package:webon_kit_dart/src/bridges/auth_bridge.dart';
import 'package:webon_kit_dart/src/bridges/chat_bridge.dart';
import 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';
import 'package:webon_kit_dart/src/models/token.dart';
import 'package:webon_kit_dart/src/models/user_matrix.dart';

/// A Calculator.
class WebonKitDart {
  /// [fallbackString] is used for account creation when Webon is not launched within the Nomo App.
  /// You can use your mnemonic phrase or any other String here.
  /// [fallbackString] should be unique
  static String? _fallbackString;

  static void initFallback({String? fallbackString}) {
    _fallbackString = fallbackString;
  }

  /// Logs into the Chat Server by calling the Nomo App function.
  /// If Webon is not launched within the Nomo App, falls in a fallback-mode and uses [fallbackString] for account creation.
  /// For fallback-mode, calling init with [fallbackString] beforehand is required.
  static Future<UserMatrix> nomoChatLogin() async {
    return await ChatBridge.getNomoLogin(fallbackString: _fallbackString);
  }

  /// Returns the public EVM Address of the Nomo App
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<String> getEvmAddress() async {
    return await WalletBridge.getEvmAddress();
  }

  /// Send Assets to [targetAddress] with [amount] of [symbol]
  /// Cannot be used outside the Nomo App.
  static Future<dynamic> sendAssets(
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
  static Future<String> getChatAddress() async {
    return await ChatBridge.getMessengerAddress();
  }
}
