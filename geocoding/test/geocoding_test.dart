import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart'
    as pi;
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
    setUp(() {
      GeocodingPlatformFactory.instance = MockGeocodingPlatformFactory();
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
  });
}

class MockGeocodingPlatformFactory implements GeocodingPlatformFactory {
  @override
  pi.Geocoding createGeocoding(GeocodingCreationParams params) {
    return MockGeocodingPlatform();
  }
}

class MockGeocodingPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        pi.Geocoding {
  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    Locale? locale,
  }) async {
    return [mockLocation];
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    Locale? locale,
  }) async {
    return [mockPlacemark];
  }
}
