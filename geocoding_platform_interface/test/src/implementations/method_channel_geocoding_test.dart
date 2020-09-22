import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geocoding_platform_interface/src/errors/no_result_found_exception.dart';
import 'package:geocoding_platform_interface/src/implementations/method_channel_geocoding.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _mockLocation = Location(
    latitude: 52.2165157,
    longitude: 6.9437819,
    timestamp: DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
  );

  final _mockPlacemark = Placemark(
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

  group('$MethodChannelGeocoding()', () {
    final log = <MethodCall>[];
    MethodChannelGeocoding methodChannelgeocoding;
    var _mockCoordinatesNotFound = false;

    setUp(() async {
      methodChannelgeocoding = MethodChannelGeocoding();

      methodChannelgeocoding.methodChannel
          .setMockMethodCallHandler((call) async {
        log.add(call);

        switch (call.method) {
          case 'locationFromAddress':
            if (_mockCoordinatesNotFound) {
              throw PlatformException(code: 'NOT_FOUND');
            } else {
              return [_mockLocation.toJson()];
            }
            break;
          case 'placemarkFromCoordinates':
            return [_mockPlacemark.toJson()];
          default:
            return null;
        }
      });

      log.clear();
    });

    group('placemarkFromAddress: When requesting placemark based on Address',
        () {
      group('And not specifying a locale', () {
        test('Should receive a placemark containing the coordinates', () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          final locations =
              await methodChannelgeocoding.locationFromAddress(address);

          // Assert
          expect(locations.length, 1);
          expect(locations.first, _mockLocation);
        });

        test('Should not send the localeIdentifier parameter to the platform',
            () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          await methodChannelgeocoding.locationFromAddress(address);

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'locationFromAddress',
              arguments: <String, String>{'address': address},
            ),
          ]);
        });
        test('Should throw NoResultException when no results are found',
            () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';
          _mockCoordinatesNotFound = true;

          // Assert
          expect(
              methodChannelgeocoding.locationFromAddress(address),
              throwsA(isInstanceOf<NoResultFoundException>().having(
                  (e) => e.toString(),
                  'message',
                  // ignore: lines_longer_than_80_chars
                  'Could not find any result for the supplied address or coordinates.')));

          _mockCoordinatesNotFound = false;
        });
      });

      group('And specifying a locale', () {
        test('Should receive a placemark containing the coordinates', () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          final locations = await methodChannelgeocoding.locationFromAddress(
            address,
            localeIdentifier: 'nl-NL',
          );

          // Assert
          expect(locations.length, 1);
          expect(locations.first, _mockLocation);
        });

        test('Should send the localeIdentifier to the platform', () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          await methodChannelgeocoding.locationFromAddress(
            address,
            localeIdentifier: 'nl-NL',
          );

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'locationFromAddress',
              arguments: <String, dynamic>{
                'address': address,
                'localeIdentifier': 'nl-NL',
              },
            ),
          ]);
        });
      });
    });

    group('placemarkFromCoordinate: When requesting placemark based on Address',
        () {
      group('And not specifying a locale', () {
        test('Should receive a placemark containing the address', () async {
          // Arrange
          final latitude = 52.561270;
          final longitude = 5.639382;

          // Act
          final placemarks =
              await methodChannelgeocoding.placemarkFromCoordinates(
            latitude,
            longitude,
          );

          expect(placemarks.length, 1);
          expect(placemarks.first, _mockPlacemark);
        });

        test('Should not send the localeIdentifier parameter to the platform',
            () async {
          // Assert
          final latitude = 52.561270;
          final longitude = 5.639382;

          // Act
          await methodChannelgeocoding.placemarkFromCoordinates(
            latitude,
            longitude,
          );

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'placemarkFromCoordinates',
              arguments: <String, dynamic>{
                'latitude': latitude,
                'longitude': longitude,
              },
            ),
          ]);
        });
      });

      group('And specifying a locale', () {
        test('Should receive a placemark containing the address', () async {
          // Arrange
          final latitude = 52.561270;
          final longitude = 5.639382;

          // Act
          final placemarks =
              await methodChannelgeocoding.placemarkFromCoordinates(
            latitude,
            longitude,
            localeIdentifier: 'nl-NL',
          );

          expect(placemarks.length, 1);
          expect(placemarks.first, _mockPlacemark);
        });

        test('Should send the localeIdentifier to the platform', () async {
          // Assert
          final latitude = 52.561270;
          final longitude = 5.639382;

          // Act
          await methodChannelgeocoding.placemarkFromCoordinates(
            latitude,
            longitude,
            localeIdentifier: 'nl-NL',
          );

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'placemarkFromCoordinates',
              arguments: <String, dynamic>{
                'latitude': latitude,
                'longitude': longitude,
                'localeIdentifier': 'nl-NL',
              },
            ),
          ]);
        });
      });
    });
  });
}
