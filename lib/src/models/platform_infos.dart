class NomoPlatformInfos {
  final String version;
  final String buildNumber;
  final String appName;
  final String clientName;
  final String operatingSystem;

  NomoPlatformInfos(
      {required this.version,
      required this.buildNumber,
      required this.appName,
      required this.clientName,
      required this.operatingSystem});

  factory NomoPlatformInfos.fromJson(Map<String, dynamic> json) {
    return NomoPlatformInfos(
      version: json['version'],
      buildNumber: json['buildNumber'],
      appName: json['appName'],
      clientName: json['clientName'],
      operatingSystem: json['operatingSystem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'buildNumber': buildNumber,
      'appName': appName,
      'clientName': clientName,
      'operatingSystem': operatingSystem,
    };
  }
}
