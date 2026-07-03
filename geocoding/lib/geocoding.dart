import 'dart:async';
import 'package:flutter/widgets.dart' as flt show Locale;
import 'package:flutter/widgets.dart';

import 'package:geocoding_platform_interface/geocoding_platform_interface.dart'
    as pi;

export 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

/// Provides access to basic geocoding and reverse-geocoding that is provided
/// by the native operating system.
class Geocoding {
  /// Constructs a [Geocoding] instance.
  Geocoding({Locale? locale})
      : this._fromPlatformCreationParams(pi.GeocodingCreationParams());

  /// Constructs a [Geocoding] instance from creation params for a specific
  /// platform.
  Geocoding._fromPlatformCreationParams(pi.GeocodingCreationParams params,
      {Locale? locale})
      : _locale = locale,
        _geocoding =
            pi.GeocodingPlatformFactory.instance!.createGeocoding(params);

  final pi.Geocoding _geocoding;
  Locale? _locale;

  /// Returns a list of [Location] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Location], multiple [Location] instances may be
  /// returned.d
  Future<List<pi.Location>> locationFromAddress(
    String address, {
    flt.Locale? locale,
  }) =>
      _geocoding.locationFromAddress(
        address,
        locale: locale ?? _locale,
      );

  /// Returns a list of [Placemark] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be
  /// returned.
  Future<List<pi.Placemark>> placemarkFromAddress(
    String address, {
    flt.Locale? locale,
  }) =>
      _geocoding.placemarkFromAddress(
        address,
        locale: locale ?? _locale,
      );

  /// Returns a list of [Placemark] instances found for the supplied
  /// coordinates.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied coordinates could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be
  /// returned.
  ///
  /// The `locale` parameter can be used to override the locale
  Future<List<pi.Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    flt.Locale? locale,
  }) =>
      _geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
        locale: locale ?? _locale,
      );

  /// Returns true if there is a geocoder implementation present that may return results.
  /// If true, there is still no guarantee that any individual geocoding attempt will succeed.
  ///
  ///
  /// This method is only implemented on Android, calling this on iOS always
  /// returns [true].
  Future<bool> isPresent() => _geocoding.isPresent();

  /// Overrides the default locale.
  ///
  /// You can specify a locale in which the results are returned. When not used the
  /// current active locale of the device will be used. The localeIdentifier should
  /// be formatted using the syntax: languageCode_countryCode (eg. en_US or nl_NL).
  @Deprecated(
      'Use the optional constructor parameter instead, or pass in a locale with any of the methods.')
  void setLocaleIdentifier(String localeIdentifier) =>
      _locale = Locale(localeIdentifier);
}
