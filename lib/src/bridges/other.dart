import 'dart:js_interop';

@JS('localStorage')
external LocalStorage get localStorage;

extension type LocalStorage._(JSObject _) implements JSObject {
  external String? getItem(String key);
  external void setItem(String key, String value);
  external void removeItem(String key);
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
