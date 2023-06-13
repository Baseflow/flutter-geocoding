import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_android/geocoding_android.dart';
import 'package:geocoding_android/models/address.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

const mockAddress = Address(
    addressLine: ['Gronausestraat 710'],
    adminArea: 'Overijssel',
    countryName: 'Netherlands',
    countryCode: 'NL',
    locality: 'Enschede',
    featureName: 'Gronausestraat',
    postalCode: '',
    subAdminArea: 'Enschede',
    subLocality: 'Enschmarke',
    subThoroughfare: '',
    thoroughfare: 'Gronausestraat',
    latitude: 52.2165157,
    longitude: 6.9437819,
    locale: 'en_US',
    phone: '',
    premises: '',
    url: '');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('flutter.baseflow.com/geocoding_android');
  late List<MethodCall> log;

  setUp(() {
    log = <MethodCall>[];
    _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
        .defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);

      return null;
    });
  });

  test('registers instance', () {
    GeocodingAndroid.registerWith();
    expect(GeocodingPlatform.instance, isA<GeocodingAndroid>());
  });

  group('GeocodingAndroid', () {
    test('locationFromAddress', () async {
      _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
          .defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return Future<List<Map<dynamic, dynamic>>>.value([
          mockAddress.toJson(),
        ]);
      });

      final geocoding = GeocodingAndroid();
      final locations = await (geocoding.locationFromAddress(''));

      expect(
        log,
        <Matcher>[
          isMethodCall('getFromLocationName', arguments: <String, Object?>{
            'address': '',
            'maxResults': 5,
          })
        ],
      );

      expect(locations.single.latitude, mockAddress.toLocation().latitude);
      expect(locations.single.longitude, mockAddress.toLocation().longitude);
    });

    test('placemarkFromCoordinates', () async {
      _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
          .defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return Future<List<Map<dynamic, dynamic>>>.value([
          mockAddress.toJson(),
        ]);
      });

      final geocoding = GeocodingAndroid();
      final locations = await (geocoding.placemarkFromCoordinates(0, 0));

      expect(
        log,
        <Matcher>[
          isMethodCall('getFromLocation', arguments: <String, Object?>{
            'latitude': 0.0,
            'longitude': 0.0,
            'maxResults': 5
          })
        ],
      );

      expect(locations.single, mockAddress.toPlacemark());
    });

    test('getFromLocationName', () async {
      _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
          .defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return Future<List<Map<dynamic, dynamic>>>.value([
          mockAddress.toJson(),
        ]);
      });

      final geocoding = GeocodingAndroid();
      final locations =
          await (geocoding.getFromLocationName('', maxResults: 10));

      expect(
        log,
        <Matcher>[
          isMethodCall('getFromLocationName', arguments: <String, Object?>{
            'address': '',
            'maxResults': 10,
          })
        ],
      );

      expect(locations.single, mockAddress);
    });

    test('getFromLocationName with boundaries', () async {
      _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
          .defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return Future<List<Map<dynamic, dynamic>>>.value([
          mockAddress.toJson(),
        ]);
      });

      final geocoding = GeocodingAndroid();
      final locations = await (geocoding.getFromLocationName('',
          maxResults: 10,
          lowerLeftLatitude: 20,
          lowerLeftLongitude: 30,
          upperRightLatitude: 40,
          upperRightLongitude: 50));

      expect(
        log,
        <Matcher>[
          isMethodCall('getFromLocationName', arguments: <String, Object?>{
            'address': '',
            'maxResults': 10,
            'lowerLeftLatitude': 20,
            'lowerLeftLongitude': 30,
            'upperRightLatitude': 40,
            'upperRightLongitude': 50,
          })
        ],
      );

      expect(locations.single, mockAddress);
    });

    test('setLocaleIdentifier', () async {
      _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
          .defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        log.add(methodCall);
        return;
      });

      final geocoding = GeocodingAndroid();
      await (geocoding.setLocaleIdentifier('en_US'));

      expect(
        log,
        <Matcher>[
          isMethodCall('setLocale', arguments: <String, Object?>{
            'languageTag': 'en_US',
          })
        ],
      );
    });
  });
}

/// This allows a value of type T or T? to be treated as a value of type T?.
///
/// We use this so that APIs that have become non-nullable can still be used
/// with `!` and `?` on the stable branch.
T? _ambiguate<T>(T? value) => value;
