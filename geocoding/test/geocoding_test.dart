import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart'
    as pi;

final mockLocation = Location(
  latitude: 52.2165157,
  longitude: 6.9437819,
  timestamp: DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
);

const mockPlacemark = Placemark(
    administrativeArea: 'Overijssel',
    country: 'Netherlands',
    isoCountryCode: 'NL',
    locality: 'Enschede',
    name: 'Gronausestraat',
    postalCode: '',
    street: 'Gronausestraat 710',
    subAdministrativeArea: 'Enschede',
    subLocality: 'Enschmarke',
    subThoroughfare: '',
    thoroughfare: 'Gronausestraat');

void main() {
  group('Geocoding', () {
    late MockGeocodingPlatform platform;

    setUp(() {
      platform = MockGeocodingPlatform();
      GeocodingPlatformFactory.instance =
          MockGeocodingPlatformFactory(platform);
    });

    test('locationFromAddress', () async {
      final locations = await (Geocoding().locationFromAddress(''));
      expect(locations.single, mockLocation);
    });

    test('placemarkFromAddress', () async {
      final placemarks = await (Geocoding().placemarkFromAddress(''));
      expect(placemarks.single, mockPlacemark);
    });

    test('placemarkFromCoordinates', () async {
      final placemarks = await (Geocoding().placemarkFromCoordinates(0, 0));
      expect(placemarks.single, mockPlacemark);
    });

    group('locale', () {
      const constructorLocale = Locale('nl', 'NL');
      const methodLocale = Locale('en', 'US');

      test('locationFromAddress uses the constructor locale', () async {
        final geocoding = Geocoding(locale: constructorLocale);
        await geocoding.locationFromAddress('');
        expect(platform.lastLocale, constructorLocale);
      });

      test('placemarkFromAddress uses the constructor locale', () async {
        final geocoding = Geocoding(locale: constructorLocale);
        await geocoding.placemarkFromAddress('');
        expect(platform.lastLocale, constructorLocale);
      });

      test('placemarkFromCoordinates uses the constructor locale', () async {
        final geocoding = Geocoding(locale: constructorLocale);
        await geocoding.placemarkFromCoordinates(0, 0);
        expect(platform.lastLocale, constructorLocale);
      });

      test('method locale overrides the constructor locale', () async {
        final geocoding = Geocoding(locale: constructorLocale);
        await geocoding.locationFromAddress('', locale: methodLocale);
        expect(platform.lastLocale, methodLocale);
      });
    });
  });
}

class MockGeocodingPlatformFactory extends GeocodingPlatformFactory {
  @override
  pi.Geocoding createGeocoding(GeocodingCreationParams params) {
    return MockGeocodingPlatform(params);
  }
}

class MockGeocodingPlatform extends pi.Geocoding {
  MockGeocodingPlatform(super.params) : super.implementation();

  Locale? lastLocale;

  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    Locale? locale,
  }) async {
    lastLocale = locale;
    return [mockLocation];
  }

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    Locale? locale,
  }) async {
    lastLocale = locale;
    return [mockPlacemark];
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    Locale? locale,
  }) async {
    lastLocale = locale;
    return [mockPlacemark];
  }

  @override
  Future<List<Placemark>> placemarkFromAddress(
    String address, {
    Locale? locale,
  }) async {
    return [mockPlacemark];
  }
}
