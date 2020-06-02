import 'package:meta/meta.dart';

/// Contains detailed location information.
@immutable
class Location {
  /// Constructs an instance with the given values for testing. [Location]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  Location({
    this.latitude,
    this.longitude,
    this.timestamp,
  });

  Location._({
    this.latitude,
    this.longitude,
    this.timestamp,
  });

  /// The latitude associated with the placemark.
  final double latitude;

  /// The longitude associated with the placemark.
  final double longitude;

  /// The UTC timestamp the coordinates have been requested.
  final DateTime timestamp;

  @override
  bool operator ==(dynamic o) =>
      o is Location &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.timestamp == timestamp;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      timestamp.hashCode;

  /// Converts a list of [Map] instances to a list of [Location] instances.
  static List<Location> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<Location> list = message.map<Location>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Location] class.
  static Location fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> locationMap = message;
    final timestamp = locationMap['timestamp'] != null
        ? DateTime.fromMillisecondsSinceEpoch(locationMap['timestamp'].toInt(),
            isUtc: true)
        : null;

    return Location._(
      latitude: locationMap['latitude'] ?? null,
      longitude: locationMap['longitude'] ?? null,
      timestamp: timestamp,
    );
  }

  /// Converts the [Location] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp?.millisecondsSinceEpoch ?? null,
      };

  @override
  String toString() {
    return '''
      Latitude: $latitude,
      Longitude: $longitude,
      Timestamp: $timestamp''';
  }
}
