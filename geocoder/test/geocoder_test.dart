import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoder/geocoder.dart';

void main() {
  const MethodChannel channel = MethodChannel('geocoder');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Geocoder.platformVersion, '42');
  });
}
