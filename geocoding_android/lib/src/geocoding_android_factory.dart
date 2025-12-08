import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

import 'geocoding_android.dart';

/// Implementation of [GeocodingPlatformFactory] for the Android platform.
class GeocodingAndroidFactory extends GeocodingPlatformFactory {
  /// Registers this class as the default instance of the
  /// [GeocodingPlatformFactory].
  static void registerWith() {
    GeocodingPlatformFactory.instance = GeocodingAndroidFactory();
  }

  @override
  Geocoding createGeocoding(GeocodingCreationParams params) {
    return GeocodingAndroid(params);
  }
}
