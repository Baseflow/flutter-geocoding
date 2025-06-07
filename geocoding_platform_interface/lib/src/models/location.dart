import 'package:flutter/foundation.dart';

/// Contains detailed location information.
@immutable
class Location {
  /// Constructs an instance with the given values for testing. [Location]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  Location({
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Location._({
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  /// The title associated with the placemark, might be empty
  final String title;

  /// The description associated with the placemark, might be empty
  final String description;

  /// The latitude associated with the placemark.
  final double latitude;

  /// The longitude associated with the placemark.
  final double longitude;

  /// The UTC timestamp the coordinates have been requested.
  final DateTime timestamp;

  @override
  bool operator ==(dynamic o) =>
      o is Location &&
      o.title == title &&
      o.description == description &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.timestamp == timestamp;

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ timestamp.hashCode;

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
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
        locationMap['timestamp'].toInt(),
        isUtc: true);

    if (locationMap['latitude'] == null || locationMap['longitude'] == null) {
      throw ArgumentError(
          'The parameters latitude and longitude should not be null.');
    }

    return Location._(
      title: locationMap['title'] ?? '',
      description: locationMap['description'] ?? '',
      latitude: locationMap['latitude'],
      longitude: locationMap['longitude'],
      timestamp: timestamp,
    );
  }

  /// Converts the [Location] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };

  @override
  String toString() {
    return '''
      Title: $title,
      Description: $description,
      Latitude: $latitude,
      Longitude: $longitude,
      Timestamp: $timestamp''';
  }
}
