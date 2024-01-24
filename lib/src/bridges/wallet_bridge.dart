import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'package:webon_kit_dart/src/bridges/arguments/asset_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/evm_message_arguments.dart';
import 'package:webon_kit_dart/src/bridges/arguments/send_assets_arguments.dart';
import 'package:webon_kit_dart/src/models/token.dart';

@JS()
external dynamic nomoGetVisibleAssets();

@JS()
external dynamic nomoSendAssets(NomoSendAssetsArguments args);

@JS()
external dynamic nomoGetBalance(AssetArguments args);

@JS()
external dynamic nomoGetAssetPrice(AssetArguments args);

@JS()
external dynamic nomoGetEvmAddress();

@JS()
external dynamic nomoSignEvmMessage(EvmMessageArguments args);

typedef AssetPrice = Map<String, dynamic>;

@JS()
external dynamic nomoGetMultiChainReceiveAddress(AssetArguments args);

@JS()
external dynamic nomoSetLocalStorageItem(String key, String value);

@JS()
external dynamic nomoGetLocalStorageItem(String key, String? options);

@JS()
external dynamic nomoLaunchUrl(UrlArguments args);

class WalletBridge {
  static Future<dynamic> launchUrl({required UrlArguments urlArguments}) async {
    final jsLaunchUrlPromise = nomoLaunchUrl(urlArguments);

    final futureLaunchUrl = promiseToFuture(jsLaunchUrlPromise);

    try {
      final result = await futureLaunchUrl;
      return result;
    } catch (e) {
      return "not able to launch url: $e";
    }
  }

  static Future<dynamic> getMultiChainReceiveAddress(
      {required AssetArguments assetArguments}) async {
    final jsAddressPromise = nomoGetMultiChainReceiveAddress(assetArguments);

    final futureAddress = promiseToFuture(jsAddressPromise);

    try {
      final result = await futureAddress;
      final receiveAddress = getProperty(result, 'receiveAddress');
      return receiveAddress;
    } catch (e) {
      return 'no address found: $e';
    }
  }

  static Future<dynamic> setLocalStorage(
      {required String key, required String value}) async {
    final jsSetLocalStorage = nomoSetLocalStorageItem(key, value);

    final futureSetLocalStorage = promiseToFuture(jsSetLocalStorage);

    try {
      final result = await futureSetLocalStorage;
      return result;
    } catch (e) {
      return "not able to set item in local storage: $e";
    }
  }

  static Future<dynamic> getLocalStorage(
      {required String key, String? options}) async {
    final jsGetLocalStorage = nomoGetLocalStorageItem(key, options);

    final futureGetLocalStorage = promiseToFuture(jsGetLocalStorage);

    try {
      final result = await futureGetLocalStorage;
      return result;
    } catch (e) {
      return "not able to get item from local storage: $e";
    }
  }

  static Future<List<Token>> getAssetsFromNomo() async {
    final jsAssetsPromise = nomoGetVisibleAssets();

    final futureAssets = promiseToFuture(jsAssetsPromise);

    try {
      final result = await futureAssets;
      final resultAsMap = getProperty(result, 'visibleAssets');
      List<Token> tokens = [];
      resultAsMap.forEach((element) async {
        var balance = getProperty(element, 'balance');
        final assetArguments =
            AssetArguments(symbol: getProperty(element, 'symbol'));
        balance ??= await getBalance(assetArguments: assetArguments);
        final token = Token(
          name: getProperty(element, 'name'),
          symbol: getProperty(element, 'symbol'),
          decimals: getProperty(element, 'decimals'),
          contractAddress: getProperty(element, 'contractAddress'),
          balance: balance,
          network: getProperty(element, 'network'),
          receiveAddress: getProperty(element, 'receiveAddress'),
        );
        tokens.add(
          token,
        );
      });

      return tokens;
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> sendAssets(
      {required NomoSendAssetsArguments sendAssetsArguments}) async {
    final jsSendAssetsPromise = nomoSendAssets(sendAssetsArguments);

    final futureSendAssets = promiseToFuture(jsSendAssetsPromise);

    try {
      final result = await futureSendAssets;
      return result;
    } catch (e) {
      throw Exception('no assets found: $e');
    }
  }

  static Future<String> getBalance(
      {required AssetArguments assetArguments}) async {
    final jsBalancePromise = nomoGetBalance(assetArguments);

    final futureBalance = promiseToFuture(jsBalancePromise);
    try {
      final result = await futureBalance;
      final balanceString = getProperty(result, 'balance');

      return balanceString;
    } catch (e) {
      return 'no balance found: $e';
    }
  }

  static Future<AssetPrice> getAssetPrice(
      {required AssetArguments assetArguments}) async {
    final jsPricePromise = nomoGetAssetPrice(assetArguments);

    final futurePrice = promiseToFuture(jsPricePromise);
    try {
      final result = await futurePrice;
      final priceString = getProperty(result, 'price');
      final currencyDisplayName = getProperty(result, 'currencyDisplayName');

      return {
        'price': priceString,
        'currencyDisplayName': currencyDisplayName,
      };
    } catch (e) {
      throw Exception('no price found: $e');
    }
  }

  static Future<String> getEvmAddress() async {
    final jsAddressPromise = nomoGetEvmAddress();
    final futureAddress = promiseToFuture(jsAddressPromise);

    try {
      final result = await futureAddress;
      return result;
    } catch (e) {
      return 'no address found: $e';
    }
  }

  static Future<String> signEvmMessage(
      {required EvmMessageArguments message}) async {
    try {
      final jsSignEvmPromise = nomoSignEvmMessage(message);

      final futureSignMessage = promiseToFuture(jsSignEvmPromise);
      final result = await futureSignMessage;
      final signString = getProperty(result, 'sigHex');

      return signString;
    } catch (e) {
      return 'Evm message signing failed: $e';
    }
  }
}
