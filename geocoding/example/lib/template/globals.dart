import 'dart:core';

import 'package:flutter/material.dart';
import 'package:geocoding_example/plugin_example/geocode_page.dart';

import 'info_page.dart';

class Globals {
  static const String pluginName = 'Geocoding';
  static const String githubURL =
      'https://github.com/Baseflow/flutter-geocoding';
  static const String baseflowURL = 'https://baseflow.com';
  static const String pubDevURL = 'https://pub.dev/packages/geocoding';

  static const EdgeInsets defaultHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets defaultVerticalPadding =
      EdgeInsets.symmetric(vertical: 24);

  static final icons = [
    Icons.location_on,
    Icons.info_outline,
  ];

  static final pages = [
    GeocodeWidget(),
    InfoPage(),
  ];
}
