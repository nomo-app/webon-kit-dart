import 'package:js/js.dart';

@JS()
@anonymous
class InstallWebonArguments {
  external String get deeplink;
  external bool get skipPermissionDialog;
  external bool get navigateBack;
  external factory InstallWebonArguments(
      {String deeplink, bool skipPermissionDialog, bool navigateBack});
}
