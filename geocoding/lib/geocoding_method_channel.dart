import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'geocoding_platform_interface.dart';

/// An implementation of [GeocodingPlatform] that uses method channels.
class MethodChannelGeocoding extends GeocodingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('geocoding');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
