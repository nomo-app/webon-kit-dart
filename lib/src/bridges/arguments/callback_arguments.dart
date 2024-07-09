import 'dart:js_interop';

@JS()
@anonymous
class CardModeArgs {
  external bool get cardMode;
  external factory CardModeArgs({bool cardMode});
}

typedef CardModeCallback = void Function(CardModeArgs args);
