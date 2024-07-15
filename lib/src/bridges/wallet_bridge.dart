import 'dart:async';
import 'dart:js_interop';

@JS()
external JSPromise<JSString> nomoGetEvmAddress();

@JS()
external JSPromise<SignEvmResult> nomoSignEvmTransaction(JSAny args);

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
}
