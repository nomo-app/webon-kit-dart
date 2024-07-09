import 'package:flutter/foundation.dart';
import 'dart:js_interop';

import 'package:webon_kit_dart/src/utils/js_utils.dart';

@JS()
external dynamic nomoQrScan();

class MediaBridge {
  static Future<String?> scanQR() async {
    try {
      final jsScanQRPromise = nomoQrScan();

      final futureScanQR = promiseToFuture(jsScanQRPromise);
      final result = await futureScanQR;

      final resultString = getProperty(result, "qrCode");

      return resultString;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
