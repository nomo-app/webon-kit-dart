class WalletInfo {
  final String evmAddress;
  final String? btcAddress;
  final String? zeniqAddress;
  final String? eurocoinAddress;
  final String? litecoinAddress;
  final String? bitcoinCashAddress;

  WalletInfo({
    required this.evmAddress,
    this.btcAddress,
    this.zeniqAddress,
    this.eurocoinAddress,
    this.litecoinAddress,
    this.bitcoinCashAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'evmAddress': evmAddress,
      'btcAddress': btcAddress,
      'zeniqAddress': zeniqAddress,
      'eurocoinAddress': eurocoinAddress,
      'litecoinAddress': litecoinAddress,
      'bitcoinCashAddress': bitcoinCashAddress,
    };
  }

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      evmAddress: json['evmAddress'],
      btcAddress: json['btcAddress'],
      zeniqAddress: json['zeniqAddress'],
      eurocoinAddress: json['eurocoinAddress'],
      litecoinAddress: json['litecoinAddress'],
      bitcoinCashAddress: json['bitcoinCashAddress'],
    );
  }
  bool compareTo(WalletInfo other) {
    return evmAddress == other.evmAddress &&
        btcAddress == other.btcAddress &&
        zeniqAddress == other.zeniqAddress &&
        eurocoinAddress == other.eurocoinAddress &&
        litecoinAddress == other.litecoinAddress &&
        bitcoinCashAddress == other.bitcoinCashAddress;
  }
}
