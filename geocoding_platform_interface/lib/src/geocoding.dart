import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geocoding_platform_factory.dart';
import 'types/types.dart';

/// Interface for a platform implementation of a [Geocoding] instance.
///
/// Platform implementations should extend this class rather than implement it
/// as `geocoding` package does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [Geocoding] methods.
abstract class Geocoding extends PlatformInterface {
  /// Creates a new [PlatformWebViewController]
  factory Geocoding(GeocodingCreationParams params) {
    assert(
      GeocodingPlatformFactory.instance != null,
      'A platform implementation for `geocoding` has not been set. Please '
      'ensure that an implementation of `GeocodingPlatformFactory` has been '
      'set te `GeocodingPlatformFactory.instance` before use. For unit '
      'testing, `GeocodingPlatformFactory.instance` can be set with your own '
      'test implementation.',
    );
    final Geocoding geocoding = GeocodingPlatformFactory.instance!
        .createGeocoding(params);
    PlatformInterface.verify(geocoding, _token);
    return geocoding;
  }

  /// Used by the platform implementation to create a new [Geocoding].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  Geocoding.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [Geocoding] instance.
  final GeocodingCreationParams params;

  /// Returns a list of [Location] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Location], multiple [Location] instances may be
  /// returned.
  Future<List<Location>> locationFromAddress(String address, {Locale? locale}) {
    throw UnimplementedError(
      'locationFromAddress() has not been implementated.',
    );
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
    double longitude, {
    Locale? locale,
  }) {
    throw UnimplementedError(
      'placemarkFromCoordinates() has not been implementated.',
    );
  }

  /// Returns a list of [Placemark] instances found for the supplied address.
  ///
  /// In most situations the returned list should only contain one entry.
  /// However in some situations where the supplied address could not be
  /// resolved into a single [Placemark], multiple [Placemark] instances may be
  /// returned.
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    Locale? locale,
  }) {
    throw UnimplementedError(
      'placemarkFromAddress() has not been implementated.',
    );
  }
}
