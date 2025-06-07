import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final mockLocation = Location(
  title: '',
  description: '',
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
      GeocodingPlatform.instance = MockGeocodingPlatform();
    });

    test('locationFromAddress', () async {
      final locations = await (locationFromAddress(''));
      expect(locations.single, mockLocation);
    });

    test('placemarkFromCoordinates', () async {
      final placemarks = await (placemarkFromCoordinates(0, 0));
      expect(placemarks.single, mockPlacemark);
    });
  });
}

class MockGeocodingPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        GeocodingPlatform {
  @override
  Future<List<Location>> locationFromAddress(
    String address, {
    Region? targetRegion,
  }) async {
    return [mockLocation];
  }

  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    return [mockPlacemark];
  }
}
