import 'dart:async';
import 'dart:js_interop';

@JS()
external JSPromise<JSString> nomoGetEvmAddress();

@JS()
external JSPromise<JSString> nomoSignEvmTransaction(SignEvmArgs args);

extension type SignEvmArgs._(JSObject o) implements JSObject {
  external SignEvmArgs({String messageHex});
  external String messageHex;
}

class WalletBridge {
  static Future<String> getEvmAddress() async {
    final jsAddressPromise = nomoGetEvmAddress();
    final result = jsAddressPromise.toDart;
    final jsStringJS = await result;
    return jsStringJS.toDart;
  }

  static Future<String> signTransaction(String unsignedTxRaw) async {
    final args = SignEvmArgs(messageHex: unsignedTxRaw);
    final promise = nomoSignEvmTransaction(args);
    final result = await promise.toDart;
    return result.toDart;
  }
}
