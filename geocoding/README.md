# Flutter Geocoding Plugin  

[![pub package](https://img.shields.io/pub/v/geocoding.svg)](https://pub.dartlang.org/packages/geocoding)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![Buid status](https://github.com/Baseflow/flutter-geocoding/workflows/Geocoding/badge.svg)](https://github.com/Baseflow/flutter-geocoding/actions?query=workflow%3AGeocoding)
[![codecov](https://codecov.io/gh/Baseflow/flutter-geocoding/branch/master/graph/badge.svg)](https://codecov.io/gh/Baseflow/flutter-geocoding)

A Flutter Geocoding plugin which provides easy geocoding and reverse-geocoding features.

**Important**: 

1. This plugin uses the free Geocoding services provided by the iOS and Android platforms. This means that there are restrictions to their use. More information can be found in the [Apple documentation for iOS](https://developer.apple.com/documentation/corelocation/clgeocoder) and the [Google documentation for Android](https://developer.android.com/reference/android/location/Geocoder).
   When a `PlatformException(IO_ERROR, ...)` gets thrown, most of the times it means that the rate limit has been reached.
2. The availability of the Google Play Services depends on your country. If your country doesn't support a connection with the Google Play Services, you'll need to try a VPN to establish a connection. For more information about how to work with Google Play Services visit the following link: https://developers.google.com/android/guides/overview 

## Usage

To use this plugin, please follow the installation guide on the [official geocoding plugin page](https://pub.dev/packages/geocoding/install).

> **NOTE:** This plugin relies on the AndroidX version of the Android Support Libraries. This means you need to make sure your Android project is also upgraded to support AndroidX. Detailed instructions can be found [here](https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility). 
>
>The TL;DR version is:
>
>1. Add the following to your "gradle.properties" file:
>
>```
>android.useAndroidX=true
>android.enableJetifier=true
>```
>2. Make sure you set the `compileSdkVersion` in your "android/app/build.gradle" file to 30:
>
>```
>android {
>  compileSdkVersion 30
>
>  ...
>}
>```
>3. Make sure you replace all the `android.` dependencies to their AndroidX counterparts (a full list can be found here: https://developer.android.com/jetpack/androidx/migrate).

## API

To translate an address into latitude and longitude coordinates you can use the `placemarkFromAddress` method:

``` dart
import 'package:geocoding/geocoding.dart';

List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
```

If you want to translate latitude and longitude coordinates into an address you can use the `placemarkFromCoordinates` method:

``` dart
import 'package:geocoding/geocoding.dart';

List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
```

Both the `locationFromAddress` and `placemarkFromCoordinates` accept an optional `localeIdentifier` parameter. This parameter can be used to enforce the results to be formatted (and translated) according to the specified locale. The `localeIdentifier` should be formatted using the syntax: [languageCode]_[countryCode]. Use the [ISO 639-1 or ISO 639-2](http://www.loc.gov/standards/iso639-2/php/English_list.php) standard for the language code and the 2 letter [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1) standard for the country code. Some examples are:

Locale identifier | Description
----------------- | -----------
en | All English speakers (will translate all attributes to English)
en_US | English speakers in the United States of America
en_UK | English speakers in the United Kingdom
nl_NL | Dutch speakers in The Netherlands
nl_BE | Dutch speakers in Belgium

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/Baseflow/flutter-geocoding/issues) page. Commercial support is available, you can contact us at <hello@baseflow.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/Baseflow/flutter-geocoding/pulls).

## Author

This geocoding plugin for Flutter is developed by [Baseflow](https://baseflow.com).
