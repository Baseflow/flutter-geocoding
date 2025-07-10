// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/legacy/geocoding_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$GeocodingPlatform', () {
    test('Default instance equals null', () {
      expect(GeocodingPlatform.instance, isNull);
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        GeocodingPlatform.instance = ImplementsGeocodingPlatform();
        // In versions of `package:plugin_platform_interface` prior to fixing
        // https://github.com/flutter/flutter/issues/109339, an attempt to
        // implement a platform interface using `implements` would sometimes
        // throw a `NoSuchMethodError` and other times throw an
        // `AssertionError`.  After the issue is fixed, an `AssertionError` will
        // always be thrown.  For the purpose of this test, we don't really care
        // what exception is thrown, so just allow any exception.
      }, throwsA(anything));
    });

    test('Can be extended', () {
      GeocodingPlatform.instance = ExtendsGeocodingPlatform();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockGeocodingPlatform();
      GeocodingPlatform.instance = mock;
    });

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of locationFromAddress should throw unimplemented error',
      () {
        // Arrange
        final geocodingPlatform = ExtendsGeocodingPlatform();

        // Act & Assert
        expect(
          () => geocodingPlatform.locationFromAddress('address'),
          throwsUnimplementedError,
        );
      },
    );

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of isPresent should throw unimplemented error',
      () {
        // Arrange
        final geocodingPlatform = ExtendsGeocodingPlatform();

        // Act & Assert
        expect(() => geocodingPlatform.isPresent(), throwsUnimplementedError);
      },
    );

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of placemarkFromCoordinates should throw unimplemented error',
      () {
        // Arrange
        final geocodingPlatform = ExtendsGeocodingPlatform();

        // Act & Assert
        expect(
          () => geocodingPlatform.placemarkFromCoordinates(0, 0),
          throwsUnimplementedError,
        );
      },
    );

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of setLocale should throw unimplemented error',
      () {
        // Arrange
        final geocodingPlatform = ExtendsGeocodingPlatform();

        // Act & Assert
        expect(
          () => geocodingPlatform.setLocaleIdentifier('en_US'),
          throwsUnimplementedError,
        );
      },
    );
  });
}

class ImplementsGeocodingPlatform implements GeocodingPlatform {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockGeocodingPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements GeocodingPlatform {}

class ExtendsGeocodingPlatform extends GeocodingPlatform {}
