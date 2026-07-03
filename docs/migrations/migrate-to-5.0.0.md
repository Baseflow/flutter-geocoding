# Migrate to version 5.0.0

This guide outlines the migration steps when upgrading to version 5.0.0 of the [Geocoding](https://pub.dev/packages/geocoding) package.

## The `Geocoding` class

Starting from version 5.0.0 all methods are now grouped in the `Geocoding` class. This means that to use the functionality you'll now have to create an instance of the `Geocoding` class first before it is possible to call any on the methods.

It is not necessary to create a new instance for each method call, also the `Geocoding` instance doesn't keep any state so it is perfectly save to keep an instance in a class variable or singleton. However since the `Geocoding` class doesn't keep any state and the constructor doesn't perform any operations, creating an instance each time you'll need to call one of its functions should also not make a heavy impact.

**Before:**
```dart
final List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
final List<Location> locations = await locationFromAddress('Gronausestraat 710, Enschede');
```

**After:**
```dart
// Create an instance of the `Geocoding` class.
final Geocoding geocoding = Geocoding();

// Use the conversion methods on the `Geocoding` class to apply geocoding functionality.
final List<Placemark> placemarks = await geocoding.placemarkFromLocation(52.2165157, 6.9437819);
final List<Location> locations = await geocoding.locationFromAddress('Gronausestraat 710, Enschede');
```

## Deprecation of the `setLocaleIdentifier` method

The `setLocaleIdentifier` method has been deprecated in favor of specifying the `locale` via the `Geocoding()`constructor parameter. Alternatively it is possible to override the set locale using the `locale` parameter of the `locationFromAddress`, `placemarkFromCoordinates` or `placemarkFromAddress` methods.

**Before:**
```dart
setLocaleIdentifier('nl_NL');

final List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
```

**After:**
```dart
final Geocoding geocoding = Geocoding(locale: Locale('nl_NL'));

final List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(52.2165157, 6.9437819);

// Override the locale only for this method call.
final List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
    52.2165157, 6.9437819,
    locale: Locale('de_DE'),
);
```


