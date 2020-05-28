// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geocoding_platform_interface/src/implementations/method_channel_geocoding.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$geocodingPlatform', () {
    test('$MethodChannelgeocoding is the default instance', () {
      expect(geocodingPlatform.instance, isA<MethodChannelgeocoding>());
    });

    test('Cannot be implemented with `implements`', () {
      expect(() {
        geocodingPlatform.instance = ImplementsgeocodingPlatform();
      }, throwsNoSuchMethodError);
    });

    test('Can be extended', () {
      geocodingPlatform.instance = ExtendsgeocodingPlatform();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockgeocodingPlatform();
      geocodingPlatform.instance = mock;
    });

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of placemarkFromAddress should throw unimplemented error',
      (){
        // Arrange
        final geocodingPlatform = ExtendsgeocodingPlatform();

        // Act & Assert
        expect(
          () => geocodingPlatform.placemarkFromAddress('address'),
          throwsUnimplementedError,
        );
    });

    test(
      // ignore: lines_longer_than_80_chars
      'Default implementation of placemarkFromCoordinates should throw unimplemented error',
      (){
        // Arrange
        final geocodingPlatform = ExtendsgeocodingPlatform();

        // Act & Assert
        expect(
          () => geocodingPlatform.placemarkFromCoordinates(0, 0),
          throwsUnimplementedError,
        );
    });
  });
}

class ImplementsgeocodingPlatform implements geocodingPlatform {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockgeocodingPlatform extends Mock
    // ignore: prefer_mixin
    with MockPlatformInterfaceMixin
    implements geocodingPlatform {}

class ExtendsgeocodingPlatform extends geocodingPlatform {}