## 1.0.3

- Moves `pigeon` from `dependencies` to `dev_dependencies`. Pigeon is a
  build-time code generator; the generated `geocoding.g.dart` does not import it
  at runtime. Declaring it as a runtime dependency leaked pigeon's `analyzer`
  version constraint into consuming apps. This matches `geocoding_android`,
  which already declares pigeon under `dev_dependencies`. Fixes #304.

## 1.0.2

- Registers the `GeocodingDarwinFactory` class as `dartPluginClass` factory to
  ensure the plugin automatically registers it self correctly.

## 1.0.1

- Updates the example app to demonstrate Darwin-specific native CLGeocoder
  methods via `clgeocoder.dart`.

## 1.0.0

- Initial release of the geocoding_darwin package containing easy geocoding and
  reverse-geocoding features for iOS and macOS.
