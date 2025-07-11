# geocoding\_darwin

The Apple Geocoding implementation of [`geocoding`][1].

## Usage

This package is [endorsed][2], which means you can simply use `geocoding`
normally. This package will be automatically included in your app when you do,
so you do not need to add it to your `pubspec.yaml`.

However, if you `import` this package to use any of its APIs directly, you
should add it to your `pubspec.yaml` as usual.

### External Native API

The plugin also provides a native API accessible by the native code of iOS applications or packages.
This API follows the convention of breaking changes of the Dart API, which means that any changes to
the class that are not backwards compatible will only be made with a major version change of the
plugin. Native code other than this external API does not follow breaking change conventions, so
app or plugin clients should not use any other native APIs.

The API can be accessed by importing the native plugin `geocoding_darwin`:

Dart:

```dart
import 'package:geocoding_darwin/geocoding_darwin.dart';
```

Then you will have access to the native classes `CLGeocoder` and `MapKit`.

## Contributing

For information on contributing to this plugin, see [`CONTRIBUTING.md`](CONTRIBUTING.md).

[1]: https://pub.dev/packages/geocoding
[2]: https://flutter.dev/to/endorsed-federated-plugin