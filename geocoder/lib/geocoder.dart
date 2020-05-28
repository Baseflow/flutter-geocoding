import 'dart:async';

import 'package:flutter/services.dart';

class Geocoder {
  static const MethodChannel _channel =
      const MethodChannel('geocoder');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
