import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../errors/errors.dart';
import '../geocoding_platform_interface.dart';
import '../models/models.dart';

/// An implementation of [GeocodingPlatform] that uses method channels.
class MethodChannelGeocoding extends GeocodingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  MethodChannel methodChannel = MethodChannel('flutter.baseflow.com/geocoding');

  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    Region? targetRegion,
    String? localeIdentifier,
  }) async {
    final parameters = <String, String>{
      'address': address,
    };

    if (targetRegion != null) {
      parameters['targetRegionSLat'] = '${targetRegion.southLatitude}';
      parameters['targetRegionNLat'] = '${targetRegion.northLatitude}';
      parameters['targetRegionWLng'] = '${targetRegion.westLongitude}';
      parameters['targetRegionELng'] = '${targetRegion.eastLongitude}';
    }
    if (localeIdentifier != null) {
      parameters['localeIdentifier'] = localeIdentifier;
    }
    try {
      final placemarks = await methodChannel.invokeMethod(
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

    final placemarks = await methodChannel.invokeMethod(
        'placemarkFromCoordinates', parameters);
    return Placemark.fromMaps(placemarks);
  }

  void _handlePlatformException(PlatformException platformException) {
    switch (platformException.code) {
      case 'NOT_FOUND':
        throw NoResultFoundException();
    }
  }
}
