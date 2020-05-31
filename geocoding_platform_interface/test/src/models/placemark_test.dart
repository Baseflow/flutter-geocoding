import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

void main() {
  group('hashCode tests:', () {
    test('hashCode hould be the same for two instances with the same values',
        () {
      // Arrange
      final firstPlacemark = Placemark();
      final secondPlacemark = Placemark();

      // Act & Assert
      expect(
        firstPlacemark.hashCode,
        secondPlacemark.hashCode,
      );
    });

    test('hashCode should not match when the name property is different', () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'different test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the isoCountryCode property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'different test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test('hashCode should not match when the country property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'different test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test('hashCode should not match when the postalCode property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'different test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the administrativeArea property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'different test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the subAdministrativeArea property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'different test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the locality property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'different test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the subLocality property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'different test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the thoroughfare property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'different test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the subThoroughfare property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'different test value',
        latitude: 0,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the latitude property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 1,
        longitude: 0,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'hashCode should not match when the longitude property is different',
        () {
      // Arrange
      final firstPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 0,
      );
      final secondPlacemark = Placemark(
        name: 'test value',
        isoCountryCode: 'test value',
        country: 'test value',
        postalCode: 'test value',
        administrativeArea: 'test value',
        subAdministrativeArea: 'test value',
        locality: 'test value',
        subLocality: 'test value',
        thoroughfare: 'test value',
        subThoroughfare: 'test value',
        latitude: 0,
        longitude: 1,
      );

      // Act & Assert
      expect(
        firstPlacemark.hashCode != secondPlacemark,
        true,
      );
    });
  });

  group('fromMaps tests:', () {
    test('fromMaps should throw argument error when message is null', () {
      expect(() => Placemark.fromMaps(null), throwsArgumentError);
    });
  });

  group('fromMap tests:', () {
    test('fromMap should throw argument error when message is null', () {
      expect(() => Placemark.fromMap(null), throwsArgumentError);
    });
  });
}
