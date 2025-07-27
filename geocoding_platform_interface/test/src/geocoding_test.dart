// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geocoding_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GeocodingPlatformFactory>()])
void main() {
  setUp(() {
    GeocodingPlatformFactory.instance = MockGeocodingPlatformFactoryWithMixin();
  });

  test('Cannot be implemented with `implements`', () {
    when(
      (GeocodingPlatformFactory.instance! as MockGeocodingPlatformFactory)
          .createGeocoding(any),
    ).thenReturn(ImplementsGeocoding());

    expect(() {
      Geocoding(const GeocodingCreationParams());

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
    const GeocodingCreationParams params = GeocodingCreationParams();
    when(
      (GeocodingPlatformFactory.instance! as MockGeocodingPlatformFactory)
          .createGeocoding(any),
    ).thenReturn(ExtendsGeocoding(params));

    expect(Geocoding(params), isNotNull);
  });

  test('Can be mocked with `implements`', () {
    when(
      (GeocodingPlatformFactory.instance! as MockGeocodingPlatformFactory)
          .createGeocoding(any),
    ).thenReturn(MockGeocoding());

    expect(Geocoding(const GeocodingCreationParams()), isNotNull);
  });

  test(
    // ignore: lines_longer_than_80_chars
    'Default implementation of locationFromAddress should throw unimplemented error',
    () {
      // Arrange
      final geocodingPlatform = ExtendsGeocoding(
        const GeocodingCreationParams(),
      );

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
      final geocodingPlatform = ExtendsGeocoding(
        const GeocodingCreationParams(),
      );

      // Act & Assert
      expect(() => geocodingPlatform.isPresent(), throwsUnimplementedError);
    },
  );

  test(
    // ignore: lines_longer_than_80_chars
    'Default implementation of placemarkFromAddress should throw unimplemented error',
    () {
      // Arrange
      final geocodingPlatform = ExtendsGeocoding(
        const GeocodingCreationParams(),
      );

      // Act & Assert
      expect(
        () => geocodingPlatform.placemarkFromAddress('address'),
        throwsUnimplementedError,
      );
    },
  );

  test(
    // ignore: lines_longer_than_80_chars
    'Default implementation of placemarkFromCoordinates should throw unimplemented error',
    () {
      // Arrange
      final geocodingPlatform = ExtendsGeocoding(
        const GeocodingCreationParams(),
      );

      // Act & Assert
      expect(
        () => geocodingPlatform.placemarkFromCoordinates(0.0, 0.0),
        throwsUnimplementedError,
      );
    },
  );
}

class MockGeocodingPlatformFactoryWithMixin extends MockGeocodingPlatformFactory
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin {}

class ImplementsGeocoding implements Geocoding {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockGeocoding extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements Geocoding {}

class ExtendsGeocoding extends Geocoding {
  ExtendsGeocoding(super.params) : super.implementation();
}
