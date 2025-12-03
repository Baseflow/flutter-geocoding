import 'geocoding_darwin.dart';

/// Implementation of [GeocodingPlatformFactory] for the Darwin (Apple)
/// platform.
class GeocodingDarwinFactory extends GeocodingPlatformFactory {
  /// Registers this class as the default instance of the
  /// [GeocodingPlatformFactory].
  static void registerWith() {
    GeocodingPlatformFactory.instance = GeocodingDarwinFactory();
  }

  @override
  Geocoding createGeocoding(GeocodingCreationParams params) {
    return GeocodingDarwin(params);
  }
}
