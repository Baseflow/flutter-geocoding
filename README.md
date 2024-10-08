# Flutter geocoding plugin

[![pub package](https://img.shields.io/pub/v/geocoding.svg)](https://pub.dartlang.org/packages/geocoding)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![Buid status](https://github.com/Baseflow/flutter-geocoding/workflows/Geocoding/badge.svg)](https://github.com/Baseflow/flutter-geocoding/actions?query=workflow%3AGeocoding)
[![codecov](https://codecov.io/gh/Baseflow/flutter-geocoding/branch/main/graph/badge.svg)](https://codecov.io/gh/Baseflow/flutter-geocoding)

The Flutter geocoding plugin is build following the federated plugin architecture. A detailed explanation of the federated plugin concept can be found in the [Flutter documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins). This means the geocoding plugin is separated into the following packages:

1. [`geocoding`][1]: the app facing package. This is the package users depend on to use the plugin in their project. For details on how to use the [`geocoding`][1] plugin you can refer to its [README.md][2] file. At this moment the Android and iOS platform implementations are also part of this package;
3. [`geocoding_platform_interface`][3]: this packages declares the interface which all platform packages must implement to support the app-facing package. Instructions on how to implement a platform packages can be found in the [README.md][4] of the [`geocoding_platform_interface`][3] package.

[1]: ./geocoding
[2]: ./geocoding/README.md
[3]: ./geocoding_platform_interface
[4]: ./geocoding_platform_interface/README.md