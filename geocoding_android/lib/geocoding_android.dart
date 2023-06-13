import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

import 'models/models.dart';

const MethodChannel _channel =
    MethodChannel('flutter.baseflow.com/geocoding_android');

/// An implementation of [GeocodingPlatform] for Android.
class GeocodingAndroid extends GeocodingPlatform {
  /// Registers this class as the default instance of [GeocodingPlatform].
  static void registerWith() {
    GeocodingPlatform.instance = GeocodingAndroid();
  }

  @override
  Future<List<Location>> locationFromAddress(String address) async {
    return (await getFromLocationName(address))
        .map((address) => address.toLocation())
        .toList();
  }

  /// Returns the result of the fromLocationName function in Android.
  Future<List<Address>> getFromLocationName(
    String address, {
    int? maxResults,
    double? lowerLeftLatitude,
    double? lowerLeftLongitude,
    double? upperRightLatitude,
    double? upperRightLongitude,
  }) async {
    final parameters = <String, dynamic>{
      'address': address,
    };

    parameters['maxResults'] = maxResults ?? 5;

    if (lowerLeftLatitude != null) {
      parameters['lowerLeftLatitude'] = lowerLeftLatitude;
    }
    if (lowerLeftLatitude != null) {
      parameters['lowerLeftLongitude'] = lowerLeftLongitude;
    }
    if (lowerLeftLatitude != null) {
      parameters['upperRightLatitude'] = upperRightLatitude;
    }
    if (lowerLeftLatitude != null) {
      parameters['upperRightLongitude'] = upperRightLongitude;
    }

    try {
      final placemarks = await _channel.invokeMethod(
        'getFromLocationName',
        parameters,
      );

      return Address.fromMaps(placemarks);
    } on PlatformException catch (e) {
      _handlePlatformException(e);
      rethrow;
    }
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
      double latitude, double longitude) async {
    return (await getFromLocation(latitude, longitude))
        .map((address) => address.toPlacemark())
        .toList();
  }

  /// Returns the result of the getFromLocation function in Android.
  Future<List<Address>> getFromLocation(
    double latitude,
    double longitude, {
    int? maxResults,
  }) async {
    final parameters = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };

    parameters['maxResults'] = maxResults ?? 5;

    final placemarks =
        await _channel.invokeMethod('getFromLocation', parameters);
    return Address.fromMaps(placemarks);
  }

  @override
  Future<void> setLocaleIdentifier(String localeIdentifier) async {
    final parameters = <String, String>{
      'languageTag': localeIdentifier,
    };

    await _channel.invokeMethod('setLocale', parameters);
    return;
  }

  void _handlePlatformException(PlatformException platformException) {
    switch (platformException.code) {
      case 'NOT_FOUND':
        throw const NoResultFoundException();
    }
  }
}
