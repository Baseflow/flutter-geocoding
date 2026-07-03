# Flutter Geocoding Plugin

[![pub package](https://img.shields.io/pub/v/geocoding.svg)](https://pub.dartlang.org/packages/geocoding)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![Buid status](https://github.com/Baseflow/flutter-geocoding/actions/workflows/geocoding.yaml/badge.svg)](https://github.com/Baseflow/flutter-geocoding/actions/workflows/geocoding.yaml)
[![codecov](https://codecov.io/gh/Baseflow/flutter-geocoding/branch/main/graph/badge.svg)](https://codecov.io/gh/Baseflow/flutter-geocoding)

A Flutter Geocoding plugin which provides easy geocoding and reverse-geocoding features.

**Important**:

1. This plugin uses the free Geocoding services provided by the iOS, macOS and Android platforms. This means that there are restrictions to their use. More information can be found in the [Apple documentation for iOS and macOS](https://developer.apple.com/documentation/corelocation/clgeocoder) and the [Google documentation for Android](https://developer.android.com/reference/android/location/Geocoder).
   When a `PlatformException(IO_ERROR, ...)` gets thrown, most of the times it means that the rate limit has been reached.
2. The availability of the Google Play Services depends on your country. If your country doesn't support a connection with the Google Play Services, you'll need to try a VPN to establish a connection. For more information about how to work with Google Play Services visit the following link: https://developers.google.com/android/guides/overview

## Installing

To use this plugin, please follow the installation guide on the [official geocoding plugin page](https://pub.dev/packages/geocoding/install).

> **Migrating to version 5.0.0**
>
> Check out our [migration guide](../docs/migrations/migrate-to-5.0.0.md) when upgrading to version 5.0.0.

## Usage

To start using the `Geocoding` plugin import the `geocoding/geocoding.dart` package and create an instance of the `Geocoding` class:

```dart
import 'package:geocoding/geocoding.dart';

final Geocoding geocoding = Geocoding();
```

Use the newly created instance to perform geocoding translations. For example use the `Geocoding.placemarkFromCoordinates` method to convert latitude and longitude coordinates into a list of addresses (the addressed are sorted on relevance, the first entry in the list is nearest to the coordinates):

```dart
// Returns a list of addresses matching the supplied coordinates. The first 
// entry in the list is generally the address closest to the supplied 
// coordinates.
List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(52.2165157, 6.9437819);
```

To convert an address into coordinates use the `Geocoding.locationFromAddress` method:

```dart
// Returns a list of latitude / longitude coordinates matching the supplied
// address. The first entry in the list is the coordinate nearest to the
// address.
List<Location> locations = await geocoding.locationFromAddress('Gronausestraat 710, Enschede');
```

It is also possible to try convert a partial address into a more detailed address using the `Geocoding.placemarkFromAddress` method:

```dart
// Returns a list of placemarks containing addresses matching the 
// string "Gronausestraat 710".
List<Placemark> placemarks = await placemarkFromAddress('Gronausestraat 710');
```

All these methods take an instance of the `Locale` class, which is used to return the address in the desired locale / language.

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/Baseflow/flutter-geocoding/issues) page. Commercial support is available, you can contact us at <hello@baseflow.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/Baseflow/flutter-geocoding/pulls).

## Author

This geocoding plugin for Flutter is developed by [Baseflow](https://baseflow.com).
