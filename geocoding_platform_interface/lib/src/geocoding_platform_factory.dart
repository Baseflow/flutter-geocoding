import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geocoding.dart';
import 'types/types.dart';

/// Interface for a platform specific implementation of the geocoding features.
abstract class GeocodingPlatformFactory extends PlatformInterface {
  /// Creates a new [GeocodingPlatformFactory].
  GeocodingPlatformFactory() : super(token: _token);

  static final Object _token = Object();

  static GeocodingPlatformFactory? _instance;

  /// The instance of [GeocodingPlatformFactory] to use.
  ///
  /// This should return a platform specific instance, which can be used to
  /// access geocoding features for that platform.
  static GeocodingPlatformFactory? get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [GeocodingPlatformFactory] when they register
  /// themselves.
  static set instance(GeocodingPlatformFactory? instance) {
    if (instance == null) {
      throw AssertionError(
        'Platform interface can only be set to a non-null instance',
      );
    }

    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Creates a new [Geocoding].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [Geocoding] in `geocoding` package instead.
  Geocoding createGeocoding(GeocodingCreationParams params) {
    throw UnimplementedError(
      'createGeocoding is not implemented on the current platform.',
    );
  }
}
