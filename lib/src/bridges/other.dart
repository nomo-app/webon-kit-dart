import 'dart:js_interop';

@JS('localStorage')
external LocalStorage get localStorage;

@JS()
external JSPromise nomoInstallWebon(JSAny args);

// window.navigator.language
@JS('navigator.language')
external String get navigatorLanguage;

@JS('setNomoColors')
external void jsSetNomoColors(JSAny args);

extension type InstallWebonArgs._(JSObject _) implements JSObject {
  external InstallWebonArgs({
    String deeplink,
    bool? navigateBack,
    bool? backgroundInstall,
    bool? skipPermissionDialog,
  });
  external String deeplink;
  external bool? navigateBack;
  external bool? backgroundInstall;
  external bool? skipPermissionDialog;
}

extension type LocalStorage._(JSObject _) implements JSObject {
  external String? getItem(String key);
  external void setItem(String key, String value);
  external void removeItem(String key);
}

class WebLocale {
  static String get language => navigatorLanguage;
}

class WebLocalStorage {
  static String? getItem(String key) {
    final item = localStorage.getItem(key);
    if (item == null || item == 'undefined' || item == '' || item == 'null') {
      return null;
    }
    return item;
  }

  static void setItem(String key, String value) {
    localStorage.setItem(key, value);
  }

  static void removeItem(String key) {
    localStorage.removeItem(key);
  }
}

class NomoColorsBrige {
  static void setNomoColors(Map<String, dynamic> args) {
    final jsArgs = args.jsify();
    if (jsArgs == null) {
      return;
    }
    jsSetNomoColors(jsArgs);

    print("Setting colors: $args");
  }
}

class NomoMultiBrige {
  static Future<void> installWebon(
      {required String deeplink,
      bool? backgroundInstall,
      bool? navigateBack,
      bool? skipPermissionDialog}) async {
    final args = InstallWebonArgs(
      deeplink: deeplink,
      backgroundInstall: backgroundInstall,
      navigateBack: navigateBack,
      skipPermissionDialog: skipPermissionDialog,
    );
    try {
      final promise = nomoInstallWebon(args);
      await promise.toDart;
    } catch (e) {
      print('Error installing or opening webon: $e');
    }
  }
}
