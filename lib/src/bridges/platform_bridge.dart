import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'dart:js_interop';
import 'package:webon_kit_dart/src/bridges/arguments/install_webon_arguments.dart';
import 'package:webon_kit_dart/src/models/nomo_manifest.dart';
import 'package:webon_kit_dart/src/models/notification_model.dart';
import 'package:webon_kit_dart/src/models/platform_infos.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';

@JS()
external dynamic nomoGetPlatformInfo();

@JS()
external dynamic nomoGetLanguage();

@JS()
external dynamic nomoGetManifest();

@JS()
external dynamic nomoGetDeviceHashes();

@JS()
external dynamic nomoGetDeviceName();

@JS()
external dynamic nomoInstallWebOn(InstallWebonArguments args);

@JS()
external dynamic nomoUninstallWebOn(RemoveWebonArguments args);

@JS()
external dynamic isFallbackModeActive();

@JS()
external dynamic nomoGetInstalledWebOns();

@JS()
external dynamic nomoNavigateToWallet(AssetArguments args);

@JS()
external dynamic nomoShowNotification(NotificationModel args);

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

  static Future<NomoManifest> getManifest() async {
    final jsPromise = nomoGetManifest();

    final future = promiseToFuture(jsPromise);
    final result = await future;

    return NomoManifest(
      min_nomo_version: getProperty(result, 'min_nomo_version'),
      nomo_manifest_version: getProperty(result, 'nomo_manifest_version'),
      webon_id: getProperty(result, 'webon_id'),
      webon_name: getProperty(result, 'webon_name'),
      webon_url: getProperty(result, 'webon_url'),
      webon_version: getProperty(result, 'webon_version'),
    );
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

  static Future<List<NomoManifest>> getInstalledWebOns() async {
    final jsInstalledWebOns = nomoGetInstalledWebOns();
    final futureInstalledWebOns = promiseToFuture(jsInstalledWebOns);

    try {
      final result = await futureInstalledWebOns;
      final resultAsMap = getProperty(result, 'manifests');
      List<NomoManifest> nomoManifests = [];

      resultAsMap.forEach((element) {
        final minNomoVersion = getProperty(element, 'min_nomo_version');
        final nomoManifestVersion =
            getProperty(element, 'nomo_manifest_version');
        final webonId = getProperty(element, 'webon_id');
        final webonName = getProperty(element, 'webon_name');
        final webonUrl = getProperty(element, 'webon_url');
        final webonVersion = getProperty(element, 'webon_version');

        final nomoManifest = NomoManifest(
          min_nomo_version: minNomoVersion,
          nomo_manifest_version: nomoManifestVersion,
          webon_id: webonId,
          webon_name: webonName,
          webon_url: webonUrl,
          webon_version: webonVersion,
        );
        nomoManifests.add(nomoManifest);
      });

      return nomoManifests;
    } catch (e) {
      print("Failed to load WebOns $e");
      return [];
    }
  }

  static Future<void> installWebOn(InstallWebonArguments arguments) async {
    try {
      final jsinstallWebonPromise = nomoInstallWebOn(arguments);

      final futureGetDeviceNames = promiseToFuture(jsinstallWebonPromise);
      await futureGetDeviceNames;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> uninstallWebOn(RemoveWebonArguments arguments) async {
    try {
      final jsinstallWebonPromise = nomoUninstallWebOn(arguments);

      final futureGetDeviceNames = promiseToFuture(jsinstallWebonPromise);
      await futureGetDeviceNames;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> navigateToWallet(AssetArguments args) async {
    try {
      final jsinstallWebonPromise = nomoNavigateToWallet(args);

      final futureGetDeviceNames = promiseToFuture(jsinstallWebonPromise);
      await futureGetDeviceNames;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> showNotification(NotificationModel args) async {
    try {
      final jsinstallWebonPromise = nomoShowNotification(args);

      final futureGetDeviceNames = promiseToFuture(jsinstallWebonPromise);
      await futureGetDeviceNames;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
