## 1.0.3

- Moves `pigeon` to `dev_dependencies`, matching `geocoding_android`.
  It is only used to generate `lib/src/geocoding/geocoding.g.dart` at
  build time and is not imported at runtime, so declaring it as a
  regular dependency propagated its version constraints to every
  consuming application.

## 1.0.2

- Registers the `GeocodingDarwinFactory` class as `dartPluginClass` factory to
  ensure the plugin automatically registers it self correctly.

## 1.0.1

- Updates the example app to demonstrate Darwin-specific native CLGeocoder
  methods via `clgeocoder.dart`.

## 1.0.0

- Initial release of the geocoding_darwin package containing easy geocoding and
  reverse-geocoding features for iOS and macOS.
