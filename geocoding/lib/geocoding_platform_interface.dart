import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geocoding_method_channel.dart';

abstract class GeocodingPlatform extends PlatformInterface {
  /// Constructs a GeocodingPlatform.
  GeocodingPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeocodingPlatform _instance = MethodChannelGeocoding();

  /// The default instance of [GeocodingPlatform] to use.
  ///
  /// Defaults to [MethodChannelGeocoding].
  static GeocodingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GeocodingPlatform] when
  /// they register themselves.
  static set instance(GeocodingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
