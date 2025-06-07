import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'models/models.dart';

/// The interface that implementations of Geocoding  must implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `Geocoding` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [GeocodingPlatform] methods.
abstract class GeocodingPlatform extends PlatformInterface {
  /// Constructs a [GeocodingPlatform].
  GeocodingPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeocodingPlatform? _instance;

  /// The default instance of [GeocodingPlatform] to use.
  static GeocodingPlatform? get instance => _instance;

  /// Platform-specific plugins should set this with their own
  /// platform-specific class that extends [GeocodingPlatform] when they
  /// register themselves.
  static set instance(GeocodingPlatform? instance) {
    if (instance == null) {
      throw AssertionError(
        'Instance of geocoding platform has to be non-null.',
      );
    }
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Sets the locale identifier used for the geocoding.
  ///
  /// The `localeIdentifier` should be formatted using the syntax:
  /// [languageCode]_[countryCode] (eg. en_US or nl_NL).
  Future<void> setLocaleIdentifier(
    String localeIdentifier,
  ) {
    throw UnimplementedError(
        'setLocaleIdentifier() has not been implementated.');
  }

  /// Returns a list of [Location] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Location], multiple [Location] instances may be
  /// returned.
  Future<List<Location>> locationFromAddress(
    String address, {
    Region? targetRegion,
  }) {
    throw UnimplementedError(
        'locationFromAddress() has not been implementated.');
  }

  /// Returns true if there is a geocoder implementation present that may return results.
  /// If true, there is still no guarantee that any individual geocoding attempt will succeed.
  ///
  ///
  /// This method is only implemented on Android, calling this on iOS always
  /// returns [true].
  Future<bool> isPresent() {
    throw UnimplementedError('isPresent() has not been implementated.');
  }

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
  ) {
    throw UnimplementedError(
        'placemarkFromCoordinates() has not been implementated.');
  }

  /// Returns a list of [Placemark] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be
  /// returned.
  Future<List<Placemark>> placemarkFromAddress(
    String address,
  ) {
    throw UnimplementedError(
        'placemarkFromAddress() has not been implementated.');
  }
}
