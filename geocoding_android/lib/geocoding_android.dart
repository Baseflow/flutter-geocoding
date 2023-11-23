import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

const MethodChannel _channel = MethodChannel('flutter.baseflow.com/geocoding');

/// An implementation of [GeocodingPlatform] for Android.
class GeocodingAndroid extends GeocodingPlatform {
  /// Registers this class as the default instance of [GeocodingPlatform].
  static void registerWith() {
    GeocodingPlatform.instance = GeocodingAndroid();
  }

  @override
  Future<void> setLocaleIdentifier(
    String localeIdentifier,
  ) {
    final parameters = <String, String>{
      'localeIdentifier': localeIdentifier,
    };

    return _channel.invokeMethod('setLocaleIdentifier', parameters);
  }

  @override
  Future<List<Location>> locationFromAddress(
    String address,
  ) async {
    final parameters = <String, String>{
      'address': address,
    };

    try {
      final placemarks = await _channel.invokeMethod(
        'locationFromAddress',
        parameters,
      );

      return Location.fromMaps(placemarks);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
      rethrow;
    }
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final parameters = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };

    final placemarks =
        await _channel.invokeMethod('placemarkFromCoordinates', parameters);
    return Placemark.fromMaps(placemarks);
  }

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address,
  ) async {
    final parameters = <String, String>{
      'address': address,
    };

    try {
      final placemarks = await _channel.invokeMethod(
        'placemarkFromAddress',
        parameters,
      );

      return Placemark.fromMaps(placemarks);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
      rethrow;
    }
  }

  void _handlePlatformException(PlatformException platformException) {
    switch (platformException.code) {
      case 'NOT_FOUND':
        throw const NoResultFoundException();
    }
  }
}
