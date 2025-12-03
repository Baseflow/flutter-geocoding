import 'package:meta/meta.dart';

/// Describes a location on earth represented by geographical coordinates.the
///
/// Platform specific implementations can add additional fields by extending
/// this class.
@immutable
class Location {
  /// Creates a [Location].
  const Location({
    required this.latitude,
    required this.longitude,
    this.timestamp,
  });

  /// The latitude associated with the placemark.
  final double latitude;

  /// The longitude associated with the placemark.
  final double longitude;

  /// The UTC timestamp the coordinates have been requested.
  ///
  /// If `null`, the time the coordinates have been determined is not known or
  /// not provided by the platform (e.g. on Android).
  final DateTime? timestamp;

  @override
  bool operator ==(Object other) =>
      other is Location &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.timestamp == timestamp;

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ timestamp.hashCode;
}
