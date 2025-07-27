// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$GeocodingPlatformFactory', () {
    test('Default instance equals null', () {
      expect(GeocodingPlatformFactory.instance, isNull);
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        GeocodingPlatformFactory.instance =
            ImplementsGeocodingPlatformFactory();
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
      GeocodingPlatformFactory.instance = ExtendsGeocodingPlatformFactory();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockGeocodingPlatformFactory();
      GeocodingPlatformFactory.instance = mock;
    });

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of createGeocoding should throw unimplemented error',
      () {
        // Arrange
        final geocodingPlatform = ExtendsGeocodingPlatformFactory();

        // Act & Assert
        expect(
          () => geocodingPlatform.createGeocoding(
            const GeocodingCreationParams(),
          ),
          throwsUnimplementedError,
        );
      },
    );
  });
}

class ImplementsGeocodingPlatformFactory implements GeocodingPlatformFactory {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockGeocodingPlatformFactory extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements GeocodingPlatformFactory {}

class ExtendsGeocodingPlatformFactory extends GeocodingPlatformFactory {}
