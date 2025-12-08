import 'geocoder.g.dart';

/// Handles constructing objects and calling static methods for the Android
/// Geocoder native library.
///
/// This class provides dependency injection for the implementations of the
/// platform interface classes. Improving the ease of unit testing and/or
/// overriding the underlying Android classes.
///
/// By default each function calls the default constructor of the class it
/// intends to return.
class GeocoderProxy {
  /// Creates a [GeocoderProxy].
  const GeocoderProxy({
    this.newGeocoder = Geocoder.new,
    this.newGeocodeListener = GeocodeListener.new,
    this.isPresent = Geocoder.isPresent,
  });

  /// Creates a [Geocoder].
  final Geocoder Function({Locale? locale}) newGeocoder;

  /// Creates a [GeocodeListener].
  final GeocodeListener Function({
    required void Function(
      GeocodeListener listener,
      String? errorMessage,
    ) onError,
    required void Function(
      GeocodeListener listener,
      List<Address?>? addresses,
    ) onGeocode,
  }) newGeocodeListener;

  /// Calls to [Geocoder.isPresent].
  final Future<bool> Function() isPresent;
}
