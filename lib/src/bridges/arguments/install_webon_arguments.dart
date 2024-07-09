import 'dart:js_interop';

@JS()
@anonymous
class InstallWebonArguments {
  external String get deeplink;
  external bool get skipPermissionDialog;
  external bool get navigateBack;
  external factory InstallWebonArguments(
      {String deeplink, bool skipPermissionDialog, bool navigateBack});
}

@JS()
@anonymous
class RemoveWebonArguments {
  external String get webon_url;
  external factory RemoveWebonArguments({String webon_url});
}
