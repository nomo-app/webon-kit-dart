import 'dart:js_util';
import 'package:flutter/foundation.dart';
import 'package:js/js.dart';

@JS()
external dynamic nomoQrScan();

class MediaBridge {
  static Future<String> scanQR() async {
    try {
      final jsScanQRPromise = nomoQrScan();

      final futureScanQR = promiseToFuture(jsScanQRPromise);
      final result = await futureScanQR;

      return result;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
