import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'package:webon_kit_dart/src/bridges/arguments/evm_message_arguments.dart';
import 'package:webon_kit_dart/src/models/wallet_info.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';
import 'package:webon_kit_dart/src/bridges/arguments/callback_arguments.dart';

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
external dynamic nomoGetWalletAddresses();

@JS()
external dynamic nomoSignEvmMessage(EvmMessageArguments args);

@JS()
external dynamic nomoGetMultiChainReceiveAddress(AssetArguments args);

@JS()
external dynamic nomoSetLocalStorageItem(String key, dynamic value);

@JS()
external dynamic nomoGetLocalStorageItem(String key, String? options);

@JS()
external dynamic nomoRemoveLocalStorageItem(String key);

@JS()
external dynamic nomoRegisterOnWebOnVisible(CardModeCallback callback);

@JS()
external dynamic nomoLaunchUrl(UrlArguments args);

@JS()
external dynamic nomoSelectAssetFromDialog();

class WalletBridge {
  static Future<void> registerOnWebOnVisible(
      {required CardModeCallback callback}) async {
    final jsRegisterOnWebOnVisible =
        nomoRegisterOnWebOnVisible(allowInterop(callback));
    final futureRegisterOnWebOnVisible =
        promiseToFuture(jsRegisterOnWebOnVisible);
    try {
      await futureRegisterOnWebOnVisible;
    } catch (e) {
      throw Exception('not able to register on webon visible: $e');
    }
  }

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

  static Future<String?> getMultiChainReceiveAddress(
      {required AssetArguments assetArguments}) async {
    final jsAddressPromise = nomoGetMultiChainReceiveAddress(assetArguments);

    final futureAddress = promiseToFuture(jsAddressPromise);

    try {
      final result = await futureAddress;
      final receiveAddress = getProperty(result, 'receiveAddress');
      return receiveAddress;
    } catch (e) {
      return null;
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

  static Future<void> removeLocalStorage({required String key}) async {
    final jsGetLocalStorage = nomoRemoveLocalStorageItem(key);

    final futureGetLocalStorage = promiseToFuture(jsGetLocalStorage);

    await futureGetLocalStorage;
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
      print("Failed to load tokens $e");

      return [];
    }
  }

  static Future<String> sendAssets(
      {required NomoSendAssetsArguments sendAssetsArguments}) async {
    final jsSendAssetsPromise = nomoSendAssets(sendAssetsArguments);

    final futureSendAssets = promiseToFuture(jsSendAssetsPromise);

    try {
      final result = await futureSendAssets;
      final hash = getProperty(result, 'hash');
      return hash;
    } catch (e) {
      if (e.toString() ==
          "the function nomoSendAssets does not work outside of the NOMO-app.") {
        return "fallback";
      }
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
    try {
      final jsPricePromise = nomoGetAssetPrice(assetArguments);
      final futurePrice = promiseToFuture(jsPricePromise);
      final result = await futurePrice;
      final priceString = getProperty(result, 'price');
      final currencyDisplayName = getProperty(result, 'currencyDisplayName');
      final currencySymbol = getProperty(result, 'currencySymbol');

      final a = {
        'price': priceString,
        'currencyDisplayName': currencyDisplayName,
        'currencySymbol': currencySymbol,
      };
      print(a);
      return a;
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

  static Future<WalletInfo?> getWalletAddresses() async {
    final jsAddressPromise = nomoGetWalletAddresses();
    final futureAddress = promiseToFuture(jsAddressPromise);

    try {
      final result = await futureAddress;
      final address = getProperty(result, 'walletAddresses');
      final eth = getProperty(address, 'ETH');
      final zeniq = getProperty(address, 'ZENIQ');
      final btc = getProperty(address, 'BTC');
      final ltc = getProperty(address, 'LTC');
      final bch = getProperty(address, 'BCH');
      final euro = getProperty(address, 'EURO');
      final walletInfo = WalletInfo(
        evmAddress: eth,
        zeniqAddress: zeniq,
        btcAddress: btc,
        litecoinAddress: ltc,
        bitcoinCashAddress: bch,
        eurocoinAddress: euro,
      );
      return walletInfo;
    } catch (e) {
      return null;
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

  static Future<Token?> selectAssetFromDialog() async {
    try {
      final jsSignEvmPromise = nomoSelectAssetFromDialog();

      final futureSignMessage = promiseToFuture(jsSignEvmPromise);
      final result = await futureSignMessage;
      final selectedAsset = getProperty(result, 'selectedAsset');

      final name = getProperty(selectedAsset, 'name');
      final symbol = getProperty(selectedAsset, 'symbol');
      final decimals = getProperty(selectedAsset, 'decimals');
      final balance = getProperty(selectedAsset, 'balance');
      final contractAddress = getProperty(selectedAsset, 'contractAddress');
      final receiveAddress = getProperty(selectedAsset, 'receiveAddress');
      final network = getProperty(selectedAsset, 'network');
      final token = Token(
          name: name,
          symbol: symbol,
          decimals: decimals,
          contractAddress: contractAddress,
          balance: balance,
          network: network,
          receiveAddress: receiveAddress);
      return token;
    } catch (e) {
      return null;
    }
  }
}
