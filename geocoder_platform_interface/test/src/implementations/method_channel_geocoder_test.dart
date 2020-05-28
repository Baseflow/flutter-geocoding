import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:geocoder_platform_interface/geocoder_platform_interface.dart';
import 'package:geocoder_platform_interface/src/implementations/method_channel_geocoder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _mockPlacemark = Placemark(
      administrativeArea: 'Overijssel',
      country: 'Netherlands',
      isoCountryCode: 'NL',
      latitude: 52.561270,      
      locality: 'Enschede',
      longitude: 5.639382,
      name: 'Gronausestraat',
      postalCode: '',
      subAdministrativeArea: 'Enschede',
      subLocality: 'Enschmarke',
      subThoroughfare: '',
      thoroughfare: 'Gronausestraat');

  group('$MethodChannelGeocoder()', () {
    final log = <MethodCall>[];
    MethodChannelGeocoder methodChannelGeocoder;

    setUp(() async {
      methodChannelGeocoder = MethodChannelGeocoder();

      methodChannelGeocoder.methodChannel
          .setMockMethodCallHandler((call) async {
        log.add(call);

        switch (call.method) {
          case 'placemarkFromAddress':
            return [_mockPlacemark.toJson()];
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
          final placemarks =
              await methodChannelGeocoder.placemarkFromAddress(address);

          // Assert
          expect(placemarks.length, 1);
          expect(placemarks.first, _mockPlacemark);
        });

        test('Should not send the localeIdentifier parameter to the platform',
            () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          await methodChannelGeocoder.placemarkFromAddress(address);

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'placemarkFromAddress',
              arguments: <String, String>{'address': address},
            ),
          ]);
        });
      });

      group('And specifying a locale', () {
        test('Should receive a placemark containing the coordinates', () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          final placemarks = await methodChannelGeocoder.placemarkFromAddress(
            address,
            localeIdentifier: 'nl-NL',
          );

          // Assert
          expect(placemarks.length, 1);
          expect(placemarks.first, _mockPlacemark);
        });

        test('Should send the localeIdentifier to the platform', () async {
          // Arrange
          final address = 'Gronausestraat, Enschede';

          // Act
          await methodChannelGeocoder.placemarkFromAddress(
            address,
            localeIdentifier: 'nl-NL',
          );

          // Assert
          expect(log, <Matcher>[
            isMethodCall(
              'placemarkFromAddress',
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
              await methodChannelGeocoder.placemarkFromCoordinates(
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
          await methodChannelGeocoder.placemarkFromCoordinates(
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
              await methodChannelGeocoder.placemarkFromCoordinates(
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
          await methodChannelGeocoder.placemarkFromCoordinates(
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
