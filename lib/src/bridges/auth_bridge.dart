import 'dart:js_util';

import 'package:js/js.dart';
import 'package:webon_kit_dart/src/bridges/arguments/auth_message_arguments.dart';

@JS()
external dynamic nomoSignAuthMessage(AuthMessageArguments args);

class AuthBridge {
  static Future<String> signAuthMessage(
      {required AuthMessageArguments message}) async {
    try {
      final jsSignAuthPromise = nomoSignAuthMessage(message);

      final futureSignMessage = promiseToFuture(jsSignAuthPromise);
      final result = await futureSignMessage;
      final signString = getProperty(result, 'ethSig');

      return signString;
    } catch (e) {
      return 'Auth message signing failed: $e';
    }
  }
}
