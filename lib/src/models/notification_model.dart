import 'package:js/js.dart';

@JS()
@anonymous
class NotificationModel {
  external String get title;
  external String get body;
  external String get payload;
  external String get channelName;

  external factory NotificationModel(
      {String title, String body, String payload, String channelName});
}
