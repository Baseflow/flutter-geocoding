import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

import 'geocoding_darwin.dart';

/// Implementation of [GeocodingPlatformFactory] for the Darwin (Apple)
/// platform.
class GeocodingDarwinFactory extends GeocodingPlatformFactory {
  /// Registers this class as the default instance of the
  /// [GeocodingPlatformFactory].
  static void registerWith() {}

  @override
  Geocoding createGeocoding(GeocodingCreationParams params) {
    // TODO: implement createGeocoding
    return super.createGeocoding(params);
  }
}
