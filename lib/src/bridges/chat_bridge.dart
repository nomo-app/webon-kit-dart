// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:js_interop';
import 'package:webon_kit_dart/src/models/user_matrix.dart';
import 'package:webon_kit_dart/src/utils/js_utils.dart';

@JS()
external dynamic nomoLogIntoChat();

@JS()
external dynamic nomoGetMessengerAddress();

class ChatBridge {
  static Future<UserMatrix> getNomoLogin() async {
    final jsEvmPromise = nomoLogIntoChat();

    final futureEvmAddress = promiseToFuture(jsEvmPromise);
    try {
      final result = await futureEvmAddress;
      final signString = getProperty(result, 'response');
      final map = jsonDecode(signString);
      final userMatrix = UserMatrix.fromJson(map);

      return userMatrix;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getMessengerAddress() async {
    final jsEvmPromise = nomoGetMessengerAddress();

    final futureMessengerAddress = promiseToFuture(jsEvmPromise);
    try {
      final result = await futureMessengerAddress;
      final signString = getProperty(result, 'messengerAddress');

      return signString;
    } catch (e) {
      return 'Messenger address not found: $e';
    }
  }
}
