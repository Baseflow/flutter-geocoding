import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

void main() {
  group('hashCode tests:', () {
    test('hashCode hould be the same for two instances with the same values',
        () {
      // Arrange
      final firstLocation = Location(
          latitude: 0,
          longitude: 0,
          timestamp: DateTime.fromMillisecondsSinceEpoch((0)));
      final secondLocation = Location(
          latitude: 0,
          longitude: 0,
          timestamp: DateTime.fromMillisecondsSinceEpoch((0)));

      // Act & Assert
      expect(
        firstLocation.hashCode,
        secondLocation.hashCode,
      );
    });

    test('hashCode should not match when the latitude property is different',
        () {
      // Arrange
      final firstLocation = Location(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      );
      final secondLocation = Location(
        latitude: 1,
        longitude: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      );

      // Act & Assert
      expect(
        firstLocation.hashCode != secondLocation.hashCode,
        true,
      );
    });

    test('hashCode should not match when the longitude property is different',
        () {
      // Arrange
      final firstLocation = Location(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      );
      final secondLocation = Location(
        latitude: 0,
        longitude: 1,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      );

      // Act & Assert
      expect(
        firstLocation.hashCode != secondLocation.hashCode,
        true,
      );
    });

    test('hashCode should not match when the timestamp property is different',
        () {
      // Arrange
      final firstLocation = Location(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      );
      final secondLocation = Location(
        latitude: 0,
        longitude: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(1),
      );

      // Act & Assert
      expect(
        firstLocation.hashCode != secondLocation.hashCode,
        true,
      );
    });
  });

  group('fromMap tests:', () {
    test('fromMap should throw argument error when message is null', () {
      expect(() => Location.fromMap(null), throwsArgumentError);
    });
  });

  group('toString tests:', () {
    test('toString should list the contents of all properties', () {
      final mockLocation = Location(
        latitude: 52.2165157,
        longitude: 6.9437819,
        timestamp: DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
      );

      final expected = '''
      Latitude: ${mockLocation.latitude},
      Longitude: ${mockLocation.longitude},
      Timestamp: ${mockLocation.timestamp}''';

      expect(mockLocation.toString(), expected);
    });
  });
}
