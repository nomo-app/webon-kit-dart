// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:webon_kit_dart/src/models/http_client.dart';
import 'package:webon_kit_dart/src/models/user_matrix.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'dart:typed_data';
import 'package:convert/convert.dart' as convert;
import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart' as web3crypto;

const String chatHomeServer = "https://zeniq.chat";
const loginUrl = '$chatHomeServer/_matrix/client/v3/login';
const registerUrl = chatHomeServer + '/_matrix/client/v3/register';

@JS()
external dynamic nomoLogIntoChat();

@JS()
external dynamic nomoGetMessengerAddress();

class ChatBridge {
  static Future<UserMatrix> getNomoLogin({String? fallbackString}) async {
    final jsEvmPromise = nomoLogIntoChat();

    final futureEvmAddress = promiseToFuture(jsEvmPromise);
    try {
      final result = await futureEvmAddress;
      final signString = getProperty(result, 'response');
      final map = jsonDecode(signString);
      final userMatrix = UserMatrix.fromJson(map);

      return userMatrix;
    } catch (e) {
      if (e ==
          "the function nomoLogIntoChat does not work outside of the NOMO-app.") {
        if (fallbackString == null) {
          throw Exception(
              "When running outside of the NOMO-app, you need to provide a fallbackString in constructor");
        }
        final user = await _nomoFallbackLogin(fallbackString: fallbackString);
        if (user == null) {
          throw Exception("Fallback Login failed with user is null");
        }
        return user;
      }
      rethrow;
    }
  }

  static Future<UserMatrix?> _nomoFallbackLogin(
      {required String fallbackString}) async {
    final user = await _logIntoExistingChatAccountOrThrow(
        fallbackString: fallbackString);
    return user;
  }

  static Future<String> getMessengerAddress() async {
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

Future<Credentials> _getChatCredentials(
    {required String fallbackString}) async {
  final privateKey = _derivePrivateKeyChat(mnemonic: fallbackString);
  final String privKeyHex = convert.hex.encode(privateKey);
  return EthPrivateKey.fromHex(privKeyHex);
}

Uint8List _derivePrivateKeyChat({required String mnemonic}) {
  final seed = bip39.mnemonicToSeed(mnemonic);
  bip32.BIP32 node = bip32.BIP32.fromSeed(seed);
  // Ascii "NOMO" => 4e 4f 4d 4f => 1313819983
  const chatDerivationPath = "m/44'/1313819983'/0'/0/0";
  final bip32.BIP32 childNode = node.derivePath(chatDerivationPath);
  return childNode.privateKey!;
}

Future<UserMatrix?> _logIntoExistingChatAccountOrThrow(
    {required String fallbackString}) async {
  Credentials credentials =
      await _getChatCredentials(fallbackString: fallbackString);

  final response = await _postChatLoginRequest(credentials);
  if (response.statusCode == 200) {
    final body = response.body;
    final userMatrix = UserMatrix.fromJson(jsonDecode(body));

    return userMatrix;
  }
  return registerChatAccount(credentials);
}

Future<UserMatrix> registerChatAccount(credentials) async {
  final address = credentials.address;
  final String userName = address.toString();
  final message =
      userName + "_" + DateTime.now().millisecondsSinceEpoch.toString();
  final publickey = toChecksumAddress(address.toString());
  final String password = "0x" + _signWithEthereumAddress(credentials, message);

  Map<String, dynamic> jsonData = {
    'username': userName,
    'message': message,
    'publickey': publickey,
    'password': password,
  };

  http.Response response = await HTTPService.client.post(
    Uri.parse(registerUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(jsonData),
  );
  if (response.statusCode == 200) {
    final String body = response.body;
    final userMatrix = UserMatrix.fromJson(jsonDecode(body));
    return userMatrix;
  } else {
    final String body = response.body;
    return Future.error("register error - not 200");
  }
}

String toChecksumAddress(String address) {
  if (!address.startsWith("0x")) {
    throw ArgumentError("not an EVM address");
  }
  final stripAddress = address.replaceFirst("0x", "").toLowerCase();
  final Uint8List keccakHash = web3crypto.keccakUtf8(stripAddress);
  final String keccakHashHex = convert.hex.encode(keccakHash);

  String checksumAddress = "0x";
  for (var i = 0; i < stripAddress.length; i++) {
    final bool high = int.parse(keccakHashHex[i], radix: 16) >= 8;
    checksumAddress += (high ? stripAddress[i].toUpperCase() : stripAddress[i]);
  }
  return checksumAddress;
}

Future<http.Response> _postChatLoginRequest(Credentials credentials) async {
  final address = credentials.address;
  final String userName = address.toString();
  final message = "${userName}_${DateTime.now().millisecondsSinceEpoch}";
  final publickey = _toChecksumAddress(address.toString());
  final String password = "0x${_signWithEthereumAddress(credentials, message)}";

  Map<String, dynamic> jsonData = {
    'type': 'm.login.signature',
    'username': userName,
    'publickey': publickey,
    'message': message,
    'signature': password,
  };

  http.Response response = await HTTPService.client.post(
    Uri.parse(loginUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(jsonData),
  );
  return response;
}

String _toChecksumAddress(String address) {
  if (!address.startsWith("0x")) {
    throw ArgumentError("not an EVM address");
  }
  final stripAddress = address.replaceFirst("0x", "").toLowerCase();
  final Uint8List keccakHash = web3crypto.keccakUtf8(stripAddress);
  final String keccakHashHex = convert.hex.encode(keccakHash);

  String checksumAddress = "0x";
  for (var i = 0; i < stripAddress.length; i++) {
    final bool high = int.parse(keccakHashHex[i], radix: 16) >= 8;
    checksumAddress += (high ? stripAddress[i].toUpperCase() : stripAddress[i]);
  }
  return checksumAddress;
}

String _signWithEthereumAddress(
  Credentials credentials,
  String dataToSign,
) {
  final Uint8List signedMsg = credentials.signPersonalMessageToUint8List(
    Uint8List.fromList(utf8.encode(dataToSign)),
  );
  return convert.hex.encode(signedMsg);
}
