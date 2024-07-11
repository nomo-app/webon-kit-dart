import 'dart:async';
import 'dart:js_interop';

@JS()
@staticInterop
external JSPromise<JSString> nomoGetEvmAddress();

class WalletBridge {
  static Future<String> getEvmAddress() async {
    try {
      final jsAddressPromise = nomoGetEvmAddress();
      final result = jsAddressPromise.toDart;
      final jsStringJS = await result;
      return jsStringJS.toDart;
    } catch (e) {
      return 'no address found: $e';
    }
  }
}
