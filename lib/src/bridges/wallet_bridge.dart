import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

@JS()
external JSPromise<JSString> nomoGetEvmAddress();

@JS()
external JSPromise<SignEvmResult> nomoSignEvmTransaction(JSAny args);

@JS()
external JSPromise<GetAllAssetsResult> nomoGetAllAssets();

extension type GetAllAssetsResult._(JSObject o) implements JSObject {
  external JSArray<JSObject> assets;
}

extension type SignEvmArgs._(JSObject o) implements JSObject {
  external SignEvmArgs({String messageHex});
  external String messageHex;
}

extension type SignEvmResult._(JSObject o) implements JSObject {
  external String sigHex;
  external String txHex;
}

class WalletBridge {
  static Future<String> getEvmAddress() async {
    final jsAddressPromise = nomoGetEvmAddress();
    final result = jsAddressPromise.toDart;
    final jsStringJS = await result;
    return jsStringJS.toDart;
  }

  static Future<String> signTransaction(String unsignedTxRaw) async {
    try {
      final args = SignEvmArgs(messageHex: unsignedTxRaw);
      final promise = nomoSignEvmTransaction(args);
      final result = await promise.toDart;

      return result.txHex;
    } catch (e, s) {
      print('Error signing transaction: $e');
      print('Stacktrace: $s');
      rethrow;
    }
  }

  static Future<List<Asset>> getAllAssets() async {
    final jsAssetsPromise = nomoGetAllAssets().toDart;

    final result = await jsAssetsPromise;
    final jsArray = result.assets;
    return jsArray.toDart.map(
      (e) {
        final name = e['name'] as JSString;
        final symbol = e['symbol'] as JSString;
        final decimals = e['decimals'] as JSNumber;

        final chainId = e['chainId'] as JSNumber?;
        final contractAddress = e['contractAddress'] as JSString?;

        return (
          name: name.toDart,
          symbol: symbol.toDart,
          decimals: decimals.toDartInt,
          chainId: chainId?.toDartInt,
          contractAddress: contractAddress?.toDart,
        );
      },
    ).toList();
  }
}

typedef Asset = ({
  String name,
  String symbol,
  int decimals,
  int? chainId,
  String? contractAddress,
});
