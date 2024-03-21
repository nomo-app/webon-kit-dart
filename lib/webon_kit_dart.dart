library webon_kit_dart;

export 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
export 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
export 'package:webon_kit_dart/src/models/token.dart';
export 'package:webon_kit_dart/src/models/user_matrix.dart';
export 'package:webon_kit_dart/src/models/url_launch_mode.dart';
export 'package:webon_kit_dart/src/models/theme/nomo_theme.dart';
export 'package:webon_kit_dart/src/models/wallet_info.dart';
export 'package:webon_kit_dart/src/models/nomo_manifest.dart';

// import 'package:nomo_ui_kit/theme/sub/nomo_color_theme.dart';
import 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/auth_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/evm_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/install_webon_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
import 'package:webon_kit_dart/src/bridges/auth_bridge.dart';
import 'package:webon_kit_dart/src/bridges/chat_bridge.dart';
import 'package:webon_kit_dart/src/bridges/media_bridge.dart';
import 'package:webon_kit_dart/src/bridges/platform_bridge.dart';
import 'package:webon_kit_dart/src/bridges/theme_bridge.dart';
import 'package:webon_kit_dart/src/bridges/wallet_bridge.dart';
import 'package:webon_kit_dart/src/models/nomo_manifest.dart';
import 'package:webon_kit_dart/src/models/notification_model.dart';
import 'package:webon_kit_dart/src/models/theme/nomo_theme.dart';
import 'package:webon_kit_dart/src/models/platform_infos.dart';
import 'package:webon_kit_dart/src/models/theme/sub/nomo_colors.dart';
import 'package:webon_kit_dart/src/models/token.dart';
import 'package:webon_kit_dart/src/models/url_launch_mode.dart';
import 'package:webon_kit_dart/src/models/user_matrix.dart';
import 'package:webon_kit_dart/src/bridges/arguments/callback_arguments.dart';
import 'package:webon_kit_dart/src/models/wallet_info.dart';

typedef AssetPrice = Map<String, dynamic>;

class WebonKitDart {
  /// Scans a QR-Code and returns the content
  static Future<String> scanQR() async {
    return await MediaBridge.scanQR();
  }

  /// Logs into the Chat Server by calling the Nomo App function.
  static Future<UserMatrix> nomoChatLogin() async {
    return await ChatBridge.getNomoLogin();
  }

  /// Returns the public EVM Address of the Nomo App
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<String> getEvmAddress() async {
    return await WalletBridge.getEvmAddress();
  }

  /// Returns all public wallet addresses of the user
  /// If Webon is not launched within the Nomo App, returns a fallback-mode address.
  static Future<WalletInfo?> getWalletAddresses() async {
    return await WalletBridge.getWalletAddresses();
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
  static Future<Token?> selectAssetFromDialog() async {
    return await WalletBridge.selectAssetFromDialog();
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
  /// You need to add this function to the nomo_multi_webons.js file
  static Future<void> setLocalStorage(
      {required String key, required String value}) async {
    await WalletBridge.setLocalStorage(key: key, value: value);
  }

  /// Returns the value of [key] from the local storage
  /// You need to add this function to the nomo_multi_webons.js file
  static Future<dynamic> getLocalStorage({required String key}) async {
    return await WalletBridge.getLocalStorage(key: key);
  }

  /// Returns the value of [key] from the local storage
  /// You need to add this function to the nomo_multi_webons.js file
  static Future<void> removeLocalStorage({required String key}) async {
    return await WalletBridge.removeLocalStorage(key: key);
  }

  /// returns a map of the current app theme
  static Future<NomoTheme> getCurrentAppTheme() async {
    return await ThemeBridge.getAppTheme();
  }

  /// Registers a callback to be called when the Nomo App is visible
  static Future<void> registerOnWebOnVisible(
      {required CardModeCallback callBack}) async {
    await WalletBridge.registerOnWebOnVisible(callback: callBack);
  }

  /// returns a List of Device-Hashes
  static Future<List<String>> getDeviceHashes() async {
    final String hashes = await PlatformBridge.getDeviceHashes();
    return hashes.split(',');
  }

  /// returns the Name of the Device
  static Future<String> getDeviceName() async {
    return await PlatformBridge.getDeviceName();
  }

  /// returns Platform Infos of the Nomo App
  static Future<NomoPlatformInfos> getPlatformInfos() async {
    return await PlatformBridge.getPlatformInfo();
  }

  /// returns the Language-Code of the Nomo App (e.g. en)
  static Future<String> getLanguage() async {
    return await PlatformBridge.getLanguage();
  }

  static Future<NomoManifest> getManifest() async {
    return await PlatformBridge.getManifest();
  }

  static bool isFallbackMode() {
    return isFallbackModeActive();
  }

  static String? getAddressForSymbol(
      {required WalletInfo addresses, required String symbol}) {
    switch (symbol) {
      case 'BTC':
        return addresses.btcAddress;
      case 'BCH':
        return addresses.bitcoinCashAddress;
      case 'LTC':
        return addresses.litecoinAddress;
      case 'ZENIQ Coin':
        return addresses.zeniqAddress;
      case 'EURO':
        return addresses.btcAddress;
      default:
        return addresses.evmAddress;
    }
  }

  static Future<List<NomoManifest>> getInstalledWebOns() {
    return PlatformBridge.getInstalledWebOns();
  }

  static Future<void> installWebon(
      {required String link,
      bool skipPermissionDialog = false,
      bool navigateBack = false}) {
    final args = InstallWebonArguments(
        deeplink: link,
        skipPermissionDialog: skipPermissionDialog,
        navigateBack: navigateBack);
    return PlatformBridge.installWebOn(args);
  }

  // set the colors of the Nomo App Theme
  static Future<dynamic> setColors(NomoColors colors) async {
    return await ThemeBridge.setColors(colors);
  }

  /// navigates to the local wallet information page of [symbol]
  static Future<void> navigateToWallet(String symbol) async {
    final minVersionCheck = await checkMinAppVersion(minVersion: '0.4.0');
    if (!minVersionCheck) return;
    final args = AssetArguments(symbol: symbol);
    await PlatformBridge.navigateToWallet(args);
  }

  /// shows a notification in the nomo app
  static Future<void> showNotification(
      {required String title,
      required String body,
      required String channelName,
      String? payload}) async {
    final minVersionCheck = await checkMinAppVersion(minVersion: '0.4.0');
    if (!minVersionCheck) return;
    final args = NotificationModel(
        title: title,
        body: body,
        payload: payload ?? '',
        channelName: channelName);
    await PlatformBridge.showNotification(args);
  }

  /// returns [true] if the App Version is higher than your [minVersion]
  /// Format for [minVersion] is: '0.1.0'
  static Future<bool> checkMinAppVersion({required String minVersion}) async {
    final appInfos = await getPlatformInfos();
    final appVersion = appInfos.version;
    final result = _compareVersion(versionA: appVersion, versionB: minVersion);
    return result != -1;
  }
}

/// returns 1 if versionA is newer than versionB
/// returns -1 if versionA is older than versionB
/// returns 0 if versionA and versionB are the same
int _compareVersion({required String versionA, required String versionB}) {
  List<String> splitA = versionA.split('.');
  List<String> splitB = versionB.split('.');
  int length = (splitA.length > splitB.length) ? splitA.length : splitB.length;

  for (int i = 0; i < length; i++) {
    int partA = (i < splitA.length) ? int.parse(splitA[i]) : 0;
    int partB = (i < splitB.length) ? int.parse(splitB[i]) : 0;

    if (partA > partB) {
      return 1;
    } else if (partA < partB) {
      return -1;
    }
  }

  return 0; // Versions are the same
}
