import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:js/js.dart';
import 'package:webon_kit_dart/src/models/platform_infos.dart';

@JS()
external dynamic nomoGetPlatformInfo();

@JS()
external dynamic nomoGetLanguage();

@JS()
external dynamic nomoGetDeviceHashes();

@JS()
external dynamic nomoGetDeviceName();

class PlatformBridge {
  static Future<NomoPlatformInfos> getPlatformInfo() async {
    try {
      final jsPlatformInfoPromise = nomoGetPlatformInfo();

      final futureGetPlatformInfo = promiseToFuture(jsPlatformInfoPromise);
      final result = await futureGetPlatformInfo;

      final version = getProperty(result, 'version');
      final buildNumber = getProperty(result, 'buildNumber');
      final appName = getProperty(result, 'appName');
      final clientName = getProperty(result, 'clientName');
      final operatingSystem = getProperty(result, 'operatingSystem');

      final infos = NomoPlatformInfos(
          version: version,
          buildNumber: buildNumber,
          appName: appName,
          clientName: clientName,
          operatingSystem: operatingSystem);
      return infos;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<String> getLanguage() async {
    try {
      final jsLanguagePromise = nomoGetLanguage();

      final futureGetLanguage = promiseToFuture(jsLanguagePromise);
      final result = await futureGetLanguage;
      final language = getProperty(result, 'language');

      return language;
    } catch (e) {
      return 'getLanguage failed: $e';
    }
  }

  static Future<String> getDeviceHashes() async {
    try {
      final jsDeviceHashesPromise = nomoGetDeviceHashes();

      final futureGetDeviceHashes = promiseToFuture(jsDeviceHashesPromise);
      final result = await futureGetDeviceHashes;
      final deviceHashes = getProperty(result, 'deviceHashes');

      return deviceHashes;
    } catch (e) {
      return 'getDeviceHashes failed: $e';
    }
  }

  static Future<String> getDeviceName() async {
    try {
      final jsDeviceNamePromise = nomoGetDeviceName();

      final futureGetDeviceNames = promiseToFuture(jsDeviceNamePromise);
      final result = await futureGetDeviceNames;
      final deviceName = getProperty(result, 'deviceName');

      return deviceName;
    } catch (e) {
      return 'deviceName failed: $e';
    }
  }
}
