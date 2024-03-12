import 'dart:async';

import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

export 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

/// Returns a list of [Location] instances found for the supplied address.
///
/// In most situations the returned list should only contain one entry.
/// However in some situations where the supplied address could not be
/// resolved into a single [Location], multiple [Location] instances may be
/// returned.
Future<List<Location>> locationFromAddress(
  String address,
) =>
    GeocodingPlatform.instance!.locationFromAddress(
      address,
    );

/// Returns a list of [Placemark] instances found for the supplied
/// coordinates.
///
/// In most situations the returned list should only contain one entry.
/// However in some situations where the supplied coordinates could not be
/// resolved into a single [Placemark], multiple [Placemark] instances may be
/// returned.
Future<List<Placemark>> placemarkFromCoordinates(
  double latitude,
  double longitude,
) =>
    GeocodingPlatform.instance!.placemarkFromCoordinates(
      latitude,
      longitude,
    );

/// Overrides default locale
///
/// You can specify a locale in which the results are returned.
/// When not used the current active locale of the device will be used.
/// The `localeIdentifier` should be formatted using the syntax:
/// [languageCode]_[countryCode] (eg. en_US or nl_NL).
Future<void> setLocaleIdentifier(
  String localeIdentifier,
) =>
    GeocodingPlatform.instance!.setLocaleIdentifier(
      localeIdentifier,
    );

/// Returns a list of [Location] instances found for the supplied address.
///
/// In most situations the returned list should only contain one entry.
/// However in some situations where the supplied address could not be
/// resolved into a single [Location], multiple [Location] instances may be
/// returned.
Future<bool> isPresent({
  String? localeIdentifier,
}) =>
    GeocodingPlatform.instance!.isPresent();
