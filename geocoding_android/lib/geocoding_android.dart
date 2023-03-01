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
  Future<List<Location>> locationFromAddress(
    String address, {
    String? localeIdentifier,
  }) async {
    final parameters = <String, String>{
      'address': address,
    };

    if (localeIdentifier != null) {
      parameters['localeIdentifier'] = localeIdentifier;
    }
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
    double longitude, {
    String? localeIdentifier,
  }) async {
    final parameters = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };

    if (localeIdentifier != null) {
      parameters['localeIdentifier'] = localeIdentifier;
    }

    final placemarks =
        await _channel.invokeMethod('placemarkFromCoordinates', parameters);
    return Placemark.fromMaps(placemarks);
  }

  void _handlePlatformException(PlatformException platformException) {
    switch (platformException.code) {
      case 'NOT_FOUND':
        throw NoResultFoundException();
    }
  }
}
