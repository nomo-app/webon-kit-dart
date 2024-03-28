# WebOn-Kit-Dart

This package is a Dart-implementation of the nomo-webon-kit.
It is intended for WebOns that are implemented via Flutter-Web.
See [nomo-webon-kit](https://github.com/nomo-app/nomo-webon-kit?tab=readme-ov-file#readme) for documentation.

## How to integrate

First, add this package as a Git-submodule by using Git-commands:

```
git submodule add https://github.com/nomo-app/webon-kit-dart.git packages/webon-kit-dart
```

Next, expand your pubspec.yaml accordingly:

```
dependencies:
    webon_kit_dart:
        path: packages/webon-kit-dart
```

Afterwards, clone submodules with:

```
git submodule update --init --recursive
```

## Launch dev server

When running a Flutter web application, the default behavior is to bind to localhost, making the application accessible only from the same machine.
To make it accessible from other devices on your local network, you need to specify something like "--web-hostname 0.0.0.0":

flutter run -d web-server --web-port 3000 --web-hostname 0.0.0.0
