import 'package:flutter/foundation.dart';

/// Contains information about a geographical region.
@immutable
class Region {
  /// The latitude of the region's south border
  final double southLatitude;

  /// The latitude of the region's north border
  final double northLatitude;

  /// The longitude of the region's west border
  final double westLongitude;

  /// The longitude of the region's east border
  final double eastLongitude;

  static double _normalizeLatitude(double latitude) {
    if (latitude < -90) {
      return -90;
    }
    if (latitude > 90) {
      return 90;
    }
    return latitude;
  }

  static double _normalizeLongitude(double longitude) {
    if (longitude >= -180 && longitude <= 180) {
      return longitude;
    }
    return ((longitude + 180) % 360) - 180;
  }

  /// Constructs a new region from:
  /// - [southLatitude] The latitude of the region's south border
  /// - [northLatitude] The latitude of the region's north border
  /// - [westLongitude] The longitude of the region's west border
  /// - [eastLongitude] The longitude of the region's east border
  Region({
    required double southLatitude,
    required double northLatitude,
    required double westLongitude,
    required double eastLongitude,
  })  : southLatitude = _normalizeLatitude(southLatitude),
        northLatitude = _normalizeLatitude(northLatitude),
        westLongitude = _normalizeLongitude(westLongitude),
        eastLongitude = _normalizeLongitude(eastLongitude);

  @override
  bool operator ==(dynamic o) =>
      o is Region &&
      o.southLatitude == southLatitude &&
      o.northLatitude == northLatitude &&
      o.westLongitude == westLongitude &&
      o.eastLongitude == eastLongitude;

  @override
  int get hashCode => southLatitude.hashCode ^
    northLatitude.hashCode ^
    westLongitude.hashCode ^
    eastLongitude.hashCode;

  /// Converts a list of [Map] instances to a list of [Location] instances.
  static List<Region> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<Region> list = message.map<Region>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Location] class.
  static Region fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> locationMap = message;

    final double? southLatitude = locationMap['southLatitude'];
    final double? northLatitude = locationMap['northLatitude'];
    final double? westLongitude = locationMap['westLongitude'];
    final double? eastLongitude = locationMap['eastLongitude'];

    if (southLatitude == null ||
      northLatitude == null ||
      westLongitude == null ||
      eastLongitude == null
    ) {
      throw ArgumentError('The parameters'
          ' southLatitude'
          ' and northLatitude'
          ' and westLongitude'
          ' and eastLongitude'
          ' should not be null.');
    }

    return Region(
      southLatitude: southLatitude,
      northLatitude: northLatitude,
      westLongitude: westLongitude,
      eastLongitude: eastLongitude,
    );
  }

  /// Converts the [Location] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
        'southLatitude': southLatitude,
        'northLatitude': northLatitude,
        'westLongitude': westLongitude,
        'eastLongitude': eastLongitude,
      };

  @override
  String toString() {
    return '{ '
        'southLatitude: $southLatitude, '
        'northLatitude: $northLatitude, '
        'westLongitude: $westLongitude, '
        'eastLongitude: $eastLongitude '
        '}';
  }
}
