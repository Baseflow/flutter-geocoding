## 2.0.5

- Fixed [#58](https://github.com/Baseflow/flutter-geocoding/issues/58) getting locationFromAddress freezes main thread.

## 2.0.4

- Fixes link to the Android migration guide in README.

## 2.0.3

- Upgrades `compileSdkVersion` to `31` on Android.
- Resolves Android embedding deprecation warning.

## 2.0.2

- Migrate maven repository from jcenter to mavenCentral.

## 2.0.1

- Update the plugin version number in the README file to the newest version;
- Update the example app to use `compileSdkversion 30` and `targetSdkversion 30` in the `build.gradle`.

## 2.0.0

- Migrate to null safety.

## 1.0.5

- Make sure the README.md specifies the correct links to Apple's CLGeocoder and Android's Geocoder APIs (see [#20](https://github.com/baseflow/flutter-geocoding/pull/20));
- Update the documentation to mention correct usage for the `locationFromAddress` feature (see [#21](https://github.com/baseflow/flutter-geocoding/pull/21))

## 1.0.4+1

- Make sure the README.md mentions the correct version number.

## 1.0.4

- Added NoResultFoundException to indicate when no results are found, instead of PlatformException

## 1.0.3+1

- Make sure the supplied locale is respected (see issue [#10](https://github.com/Baseflow/flutter-geocoding/issues/10))

## 1.0.3

- Make sure public types defined in the geocoding_platform_interface are also available from the geocoding package (see [#6](https://github.com/Baseflow/flutter-geocoding/issues/6)).

## 1.0.2

- Solve `IllegalFormatConversionException` on Android when geocoding request could not be resolved (see [#5](https://github.com/Baseflow/flutter-geocoding/issues/5)).

## 1.0.1

- Pimp the example application

## 1.0.0

- Initial open-source release
