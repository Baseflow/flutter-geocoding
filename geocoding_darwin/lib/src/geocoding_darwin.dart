import 'package:flutter/widgets.dart' as flt;
import 'package:geocoding_darwin/src/clgeocoder/clgeocoder.g.dart';
import 'package:geocoding_darwin/src/clgeocoder/clgeocoder_proxy.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

export 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

/// Object specifying creation parameters for a [GeocodingDarwin] instance.
@flt.immutable
class GeocodingDarwinCreationParams extends GeocodingCreationParams {
  //// Creates a [GeocodingDarwinCreationParams].
  GeocodingDarwinCreationParams({
    @flt.visibleForTesting
    this.coreLocationGeocoderProxy = const CLGeocoderProxy(),
    @flt.visibleForTesting PigeonInstanceManager? instanceManager,
  }) : _instanceManager = instanceManager ?? PigeonInstanceManager.instance;

  /// Creates a [GeocodingDarwinCreationParams] using a
  /// [GeocodingCreationParams].
  GeocodingDarwinCreationParams.fromGeocodingCreationParams(
    GeocodingCreationParams params, {
    @flt.visibleForTesting
    CLGeocoderProxy coreLocationGeocoderProxy = const CLGeocoderProxy(),
    @flt.visibleForTesting PigeonInstanceManager? instanceManager,
  }) : this(
         coreLocationGeocoderProxy: coreLocationGeocoderProxy,
         instanceManager: instanceManager,
       );

  /// Handles constructing objects and calling static method for the Core
  /// Location Geocoder native library.
  @flt.visibleForTesting
  final CLGeocoderProxy coreLocationGeocoderProxy;

  // Maintains instances used to communicate with the native objects they
  // represent.
  final PigeonInstanceManager _instanceManager;
}

/// An implementation of the [Geocoding] interface for the Darwin (iOS, macOS)
/// platforms.
class GeocodingDarwin extends Geocoding {
  /// Creates a [GeocodingDarwin].
  GeocodingDarwin(GeocodingCreationParams params)
    : super.implementation(
        (params is GeocodingDarwinCreationParams)
            ? params
            : GeocodingDarwinCreationParams.fromGeocodingCreationParams(params),
      );

  late final CLGeocoder _coreLocationGeocoder = _darwinParams
      .coreLocationGeocoderProxy
      .newCLGeocoder();

  GeocodingDarwinCreationParams get _darwinParams =>
      params as GeocodingDarwinCreationParams;

  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    flt.Locale? locale,
  }) async {
    final Locale? nativeLocale = locale != null
        ? Locale(identifier: locale.toString())
        : null;

    final List<CLPlacemark>? placemarks = await _coreLocationGeocoder
        .geocodeAddressString(address, nativeLocale);

    if (placemarks == null) {
      return <Location>[];
    }

    final Iterable<Future<Location?>> futures = placemarks.map(
      (CLPlacemark placemark) async => await placemark.toDartLocation(),
    );

    return (await Future.wait(futures)).nonNulls.toList();
  }

  @override
  Future<bool> isPresent() => Future.value(true);

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    flt.Locale? locale,
  }) async {
    final Locale? nativeLocale = locale != null
        ? Locale(identifier: locale.toString())
        : null;

    final List<CLPlacemark>? placemarks = await _coreLocationGeocoder
        .geocodeAddressString(address, nativeLocale);

    return placemarks
            ?.map((CLPlacemark placemark) => placemark.toDartPlacemark())
            .toList() ??
        <Placemark>[];
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    flt.Locale? locale,
  }) async {
    final Locale? nativeLocale = locale != null
        ? Locale(identifier: locale.toString())
        : null;

    final List<CLPlacemark>? placemarks = await _coreLocationGeocoder
        .reverseGeocodeLocation(
          CLLocation(latitude: latitude, longitude: longitude),
          nativeLocale,
        );

    return placemarks
            ?.map((CLPlacemark placemark) => placemark.toDartPlacemark())
            .toList() ??
        <Placemark>[];
  }
}

extension _CLPlacemarkExtensions on CLPlacemark {
  Placemark toDartPlacemark() => Placemark(
    name: name,
    street: postalAddress?.street,
    isoCountryCode: isoCountryCode,
    country: country,
    postalCode: postalAddress?.postalCode ?? postalCode,
    administrativeArea: administrativeArea,
    subAdministrativeArea: subAdministrativeArea,
    locality: locality,
    subLocality: subLocality,
    thoroughfare: thoroughfare,
    subThoroughfare: subThoroughfare,
  );

  Future<Location?> toDartLocation() async {
    final CLLocation? localLocation = location;

    if (localLocation == null) {
      return null;
    }

    final CLLocationCoordinate2D coordinate = await localLocation
        .getCoordinate();
    final int timestamp = await localLocation.getTimestamp();

    return Location(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }
}
