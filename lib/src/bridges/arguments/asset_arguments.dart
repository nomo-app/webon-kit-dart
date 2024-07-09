import 'dart:js_interop';

@JS()
@anonymous
class AssetArguments {
  external String get symbol;
  external factory AssetArguments({String symbol});
}

@JS()
@anonymous
class UrlArguments {
  external String get url;
  external String get launchMode;

  external factory UrlArguments({
    required url,
    required String launchMode,
  });
}
