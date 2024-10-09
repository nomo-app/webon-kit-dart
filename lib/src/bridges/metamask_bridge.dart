import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JS('ethereum')
external JSObject? get ethereum;

@JS('ethereum.request')
external JSPromise<JSAny?> _ethereumRequest(EthereumRequestArgs args);

@JS('ethereum.on')
external JSObject _ethereumOn(String event, JSFunction handler);

extension type MetaMaskError._(JSObject _) implements JSObject {
  external int code;
  external String message;
  external String stack;
}

extension type EthereumRequestArgs._(JSObject _) implements JSObject {
  external factory EthereumRequestArgs({
    required String method,
    JSAny? params,
  });
}

class MetamaskConnection {
  final ValueNotifier<String?> currentAccountNotifier;
  final ValueNotifier<int> chainIdNotifier = ValueNotifier(-1);

  String? get currentAccount => currentAccountNotifier.value;

  int get chainId => chainIdNotifier.value;

  set currentAccount(String? value) {
    currentAccountNotifier.value = value;
  }

  set chainId(int value) {
    chainIdNotifier.value = value;
  }

  bool get isConnected => currentAccount != null;

  final Completer<void> initCompleter = Completer<void>();

  Future<void> get initFuture => initCompleter.future;

  final ChainInfo? defaultChain;

  MetamaskConnection({
    this.defaultChain,
    ValueNotifier<String?>? accoutNotifier,
  }) : currentAccountNotifier = accoutNotifier ?? ValueNotifier(null) {
    init();
  }

  void onAccountsChanged(List<String> accounts) {
    currentAccount = accounts.isEmpty ? null : accounts[0];
  }

  void onChainChanged(int chainId) {
    print("Chain changed to $chainId");
    this.chainId = chainId;
  }

  void switchChain(ChainInfo chainInfo) async {
    await ethereumSwitchChain(chainInfo);
  }

  /// Checks if the user is already connected to MetaMask and sets the current account.
  void init() async {
    if (ethereum == null) {
      initCompleter.complete();
      return;
    }

    final accounts = await ethAccounts();
    chainId = await eth_chainId();
    currentAccount = accounts.isEmpty ? null : accounts[0];

    if (defaultChain != null && chainId != defaultChain!.chainId) {
      switchChain(defaultChain!);
    }

    initCompleter.complete();

    ethereumOnAccountsChanged(onAccountsChanged);
    ethereumOnChainChanged(onChainChanged);
  }

  /// Prompts the user to connect their MetaMask wallet and sets the current account.
  Future<void> connect() async {
    if (ethereum == null) return;
    if (isConnected) return;
    final accounts = await requestAccounts();
    currentAccount = accounts.isEmpty ? null : accounts[0];
  }

  /// Registers an event handler for a specific event.
  static void ethereumOn(
    String event,
    void Function(JSAny data) handler,
  ) async {
    _ethereumOn(event, handler.toJS);
  }

  /// RPC Call
  static Future<JSAny?> ethereumRequest(
    String method, [
    Object? params,
  ]) async {
    final args = params == null
        ? EthereumRequestArgs(method: method)
        : EthereumRequestArgs(
            method: method,
            params: params.jsify(),
          );

    final promise = _ethereumRequest(args);

    final future = promise.toDart;

    return future;
  }

  ///
  /// Utility functions
  ///

  static Future<int> eth_chainId() async {
    final result = await ethereumRequest('eth_chainId') as JSString;
    return int.parse(result.toDart);
  }

  static void ethereumOnChainChanged(void Function(int) handler) {
    ethereumOn('chainChanged', (data) {
      final result = data as JSString;
      handler(int.parse(result.toDart));
    });
  }

  static void ethereumOnAccountsChanged(void Function(List<String>) handler) {
    ethereumOn('accountsChanged', (data) {
      final dataArray = data as JSArray<JSString>;
      final accounts = dataArray.toDart.map((e) => e.toDart).toList();
      handler(accounts);
    });
  }

  static Future<List<String>> ethAccounts() async {
    final accounts = await ethereumRequest('eth_accounts') as JSArray<JSString>;
    return accounts.toDart.map((e) => e.toString()).toList();
  }

  static Future<List<String>> requestAccounts() async {
    final result =
        await ethereumRequest('eth_requestAccounts') as JSArray<JSString>;

    return result.toDart.map((e) => e.toString()).toList();
  }

  static Future<void> ethereumSwitchChain(ChainInfo chainInfo) async {
    try {
      await ethereumRequest('wallet_switchEthereumChain', [
        {
          'chainId': chainInfo.chainId.toHex,
        },
      ]);
    } on MetaMaskError catch (e) {
      /// Chain not found
      if (e.code == 4902) {
        await ethereumAddChain(chainInfo);
      }
    }
  }

  static Future<bool> ethereumAddChain(ChainInfo chainInfo) async {
    try {
      await ethereumRequest('wallet_addEthereumChain', [
        chainInfo.asJson,
      ]);
      print("Chain added: ${chainInfo.asJson}");
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> ethereumAddToken(ERC20AssetInfo assetInfo) async {
    try {
      final result = await ethereumRequest(
        'wallet_watchAsset',
        assetInfo.asJson,
      ) as JSBoolean;
      return result.toDart;
    } catch (e) {
      return false;
    }
  }

  static Future<String> ethereumSendTransaction(Map<String, String> tx) async {
    assert(tx.containsKey('to'));
    assert(tx.containsKey('from'));
    assert(tx.containsKey('value'));
    assert(tx.containsKey('data'));
    assert(tx.containsKey('gas'));

    try {
      final result = await ethereumRequest('eth_sendTransaction', [
        tx,
      ]) as JSString;

      return result.toDart;
    } on MetaMaskError catch (e) {
      rethrow;
    }
  }
}

extension on int {
  String get toHex => '0x${toRadixString(16)}';
}

typedef ChainInfo = ({
  int chainId,
  String chainName,
  List<String> rpcUrls,
  List<String>? blockExplorerUrls,
  List<String>? iconUrls,
  NativeCurrency nativeCurrency,
});

extension on ChainInfo {
  Map<String, dynamic> get asJson => {
        'chainId': chainId.toHex,
        'chainName': chainName,
        'rpcUrls': rpcUrls,
        'nativeCurrency': nativeCurrency.asJson,
        'blockExplorerUrls': blockExplorerUrls,
        'iconUrls': iconUrls,
      };
}

typedef NativeCurrency = ({
  String name,
  String symbol,
  int decimals,
});

extension on NativeCurrency {
  Map<String, dynamic> get asJson => {
        'name': name,
        'symbol': symbol,
        'decimals': decimals,
      };
}

typedef ERC20AssetInfo = ({
  String address,
  String symbol,
  int decimals,
  String? image,
});

extension on ERC20AssetInfo {
  Map<String, dynamic> get asJson => {
        'type': 'ERC20',
        'options': {
          'address': address,
          'symbol': symbol,
          'decimals': decimals,
          'image': image,
        },
      };
}
