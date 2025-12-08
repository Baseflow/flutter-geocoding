import 'dart:async';

import 'package:flutter/widgets.dart' as flt;
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:meta/meta.dart';

import 'geocoder/geocoder.g.dart';
import 'geocoder/geocoder_proxy.dart';

const int _maxAddressResults = 5;

/// Object specifying creation parameters for a [GeocodingAndroid] instance.
@immutable
class GeocodingAndroidCreationParams extends GeocodingCreationParams {
  //// Creates a [GeocodingAndroidCreationParams].
  GeocodingAndroidCreationParams({
    @visibleForTesting this.geocoderProxy = const GeocoderProxy(),
    @visibleForTesting PigeonInstanceManager? instanceManager,
  }) : instanceManager = instanceManager ?? PigeonInstanceManager.instance;

  /// Creates a [GeocodingAndroidCreationParams] using a
  /// [GeocodingCreationParams].
  GeocodingAndroidCreationParams.fromGeocodingCreationParams(
    GeocodingCreationParams params, {
    @visibleForTesting GeocoderProxy geocoderProxy = const GeocoderProxy(),
    @visibleForTesting PigeonInstanceManager? instanceManager,
  }) : this(
          geocoderProxy: geocoderProxy,
          instanceManager: instanceManager,
        );

  /// Handles constructing objects and calling static method for the Geocoder
  /// native library.
  @visibleForTesting
  final GeocoderProxy geocoderProxy;

  /// Maintains instances used to communicate with the native objects they
  /// represent.
  ///
  /// This field is exposed for testing purposes only and should not be used
  /// outside of tests.
  @visibleForTesting
  final PigeonInstanceManager instanceManager;
}

/// An implementation of the [Geocoding] interface for the Android
/// platforms.
class GeocodingAndroid extends Geocoding {
  /// Creates a [GeocodingDarwin].
  GeocodingAndroid(GeocodingCreationParams params)
      : super.implementation(
          (params is GeocodingAndroidCreationParams)
              ? params
              : GeocodingAndroidCreationParams.fromGeocodingCreationParams(
                  params),
        );

  GeocodingAndroidCreationParams get _androidParams =>
      params as GeocodingAndroidCreationParams;

  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    flt.Locale? locale,
  }) async {
    final Geocoder geocoder = _createGeocoder(locale);

    final int androidSdkVersion = await Build.getSdkVersion();
    late final List<Address?>? addresses;

    if (androidSdkVersion < 33) {
      addresses = await geocoder.getFromLocationNamePreAndroidApi33(
          address, _maxAddressResults, null);
    } else {
      final Future<List<Address?>?> future = _GeocodeListenerWrapper(
        geocoderProxy: _androidParams.geocoderProxy,
        geocoder: geocoder,
      ).locationFromAddress(address);

      addresses = await future;
    }

    if (addresses == null) {
      return <Location>[];
    }

    final Iterable<Future<Location?>> futures = addresses.map(
      (Address? address) async => await address?.toDartLocation(),
    );

    return (await Future.wait(futures)).nonNulls.toList();
  }

  @override
  Future<bool> isPresent() => _androidParams.geocoderProxy.isPresent();

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    flt.Locale? locale,
  }) async {
    final Geocoder geocoder = _createGeocoder(locale);
    final int androidSdkVersion = await Build.getSdkVersion();
    late final List<Address?>? addresses;

    if (androidSdkVersion < 33) {
      addresses = await geocoder.getFromLocationNamePreAndroidApi33(
          address, _maxAddressResults, null);
    } else {
      final Future<List<Address?>?> future = _GeocodeListenerWrapper(
        geocoderProxy: _androidParams.geocoderProxy,
        geocoder: geocoder,
      ).locationFromAddress(address);

      addresses = await future;
    }

    if (addresses == null) {
      return <Placemark>[];
    }

    final Iterable<Future<Placemark?>> futures = addresses.map(
      (Address? address) async => await address?.toDartPlacemark(),
    );

    return (await Future.wait(futures)).nonNulls.toList();
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    flt.Locale? locale,
  }) async {
    final Geocoder geocoder = _createGeocoder(locale);
    final int androidSdkVersion = await Build.getSdkVersion();
    late final List<Address?>? addresses;

    if (androidSdkVersion < 33) {
      addresses = await geocoder.getFromLocationPreAndroidApi33(
          latitude, longitude, _maxAddressResults);
    } else {
      final Future<List<Address?>?> future = _GeocodeListenerWrapper(
        geocoderProxy: _androidParams.geocoderProxy,
        geocoder: geocoder,
      ).placemarkFromCoordinates(latitude, longitude);

      addresses = await future;
    }

    if (addresses == null) {
      return <Placemark>[];
    }

    final Iterable<Future<Placemark?>> futures = addresses.map(
      (Address? address) async => await address?.toDartPlacemark(),
    );

    return (await Future.wait(futures)).nonNulls.toList();
  }

  Geocoder _createGeocoder(flt.Locale? locale) {
    final Locale? nativeLocale =
        locale != null ? Locale(identifier: locale.toString()) : null;

    return _androidParams.geocoderProxy.newGeocoder(
      locale: nativeLocale,
    );
  }
}

class _GeocodeListenerWrapper {
  _GeocodeListenerWrapper({
    required GeocoderProxy geocoderProxy,
    required Geocoder geocoder,
  }) : _geocoder = geocoder {
    _listener = geocoderProxy.newGeocodeListener(
        onError: (GeocodeListener listener, String? error) {},
        onGeocode: _onGeocode);
  }

  final Completer<List<Address?>?> _completer = Completer();
  final Geocoder _geocoder;
  late final GeocodeListener _listener;

  Future<List<Address?>?> locationFromAddress(String address) async {
    await _geocoder.getFromLocationName(
      address,
      _maxAddressResults,
      _listener,
      null,
    );

    return _completer.future;
  }

  Future<List<Address?>?> placemarkFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    await _geocoder.getFromLocation(
      latitude,
      longitude,
      _maxAddressResults,
      _listener,
    );
    return _completer.future;
  }

  void _onGeocode(GeocodeListener listener, List<Address?>? addresses) {
    _completer.complete(addresses);
  }
}

extension _AddressExtensions on Address {
  Future<Placemark> toDartPlacemark() async {
    final String? name = await getFeatureName();
    final String? street = await getAddressLine(0);
    final String? isoCountryCode = await getCountryCode();
    final String? country = await getCountryName();
    final String? postalCode = await getPostalCode();
    final String? administrativeArea = await getAdminArea();
    final String? subAdministrativeArea = await getSubAdminArea();
    final String? locality = await getLocality();
    final String? subLocality = await getSubLocality();
    final String? thoroughfare = await getThouroughfare();
    final String? subThoroughfare = await getSubThouroughfare();

    return Placemark(
      name: name,
      street: street,
      isoCountryCode: isoCountryCode,
      country: country,
      postalCode: postalCode,
      administrativeArea: administrativeArea,
      subAdministrativeArea: subAdministrativeArea,
      locality: locality,
      subLocality: subLocality,
      thoroughfare: thoroughfare,
      subThoroughfare: subThoroughfare,
    );
  }

  Future<Location?> toDartLocation() async {
    final double? latitude = await getLatitude();
    final double? longitude = await getLongitude();

    if (latitude == null || longitude == null) {
      return null;
    }

    return Location(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
