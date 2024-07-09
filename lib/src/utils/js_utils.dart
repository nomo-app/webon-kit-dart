import 'dart:js_interop';

@JS()
external Future<T> promiseToFuture<T>(Object jsPromise);

@JS()
external T getProperty<T>(Object o, Object name);

@JS()
external F allowInterop<F extends Function>(F f);
