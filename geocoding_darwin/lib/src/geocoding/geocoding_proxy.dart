import 'geocoding.g.dart';

/// Handles constructing objects and calling static methods for the Darwin
/// CLGeocoder native library.
///
/// This class provides dependency injection for the implementations of the
/// platform interface classes. Improving the ease of unit testing and/or
/// overriding the underlying Darwin classes.
///
/// By default each function calls the default constructor of the class it
/// intends to return.
class CLGeocoderProxy {
  /// Creates a [CLGeocoderProxy].
  const CLGeocoderProxy({
    this.newCLGeocoder = CLGeocoder.new,
    this.newNSObject = NSObject.new,
  });

  /// Constructs [CLGeocoder].
  final CLGeocoder Function() newCLGeocoder;

  /// Constructs [NSObject].
  final NSObject Function({
    void Function(
      NSObject,
      String?,
      NSObject?,
      Map<KeyValueChangeKey, Object?>?,
    )?
    observeValue,
  })
  newNSObject;
}
