# Contributing to `geocoding_darwin`

Please start by taking a look at the general guide to contributing to the `baseflow/flutter-geocoding` repo:
https://github.com/baseflow/flutter-geocoding/blob/main/CONTRIBUTING.md

## Package Structure

This plugin serves as a platform implementation plugin as outlined in [federated plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages#federated-plugins).
The sections below will provide an overview of how this plugin implements this portion with iOS and
macOS.

For making changes to this package, please take a look at [changing federated plugins](https://github.com/flutter/flutter/blob/master/docs/ecosystem/contributing/README.md#changing-federated-plugins).

### Quick Overview

This plugin implements the platform interface provided by `geocoding_platform_interface` using
the native CLGeocoding APIs (pre iOS 26) or MapKit APIs (post iOS 26) to convert location 
information into addresses and vice versa.

#### SDK Wrappers

To access native APIS, this plugins uses Dart wrappers of the native library. The native library is
wrapped using using the `ProxyApi` feature from the `pigeon` package.

The wrappers for the native library can be updated and modified by changing `pigeons/clgeocoder.dart`
or `pigeons/mapkit.dart`.

The generated files are located at:
* `lib/src/common/clgeocoder.g.dart`
* `lib/src/common/mapkit.g.dart`
* `darwin/Sources/CLGeocoder/CLGeocoderLibrary.g.swift`
* `darwin/Sources/MapKit/MapKitLibrary.g.swift`

To update the wrapper, follow the steps below:

##### 1. Make changes to the respective pigeon file that matches the native SDK

* CLGeocoder Dependency: https://developer.apple.com/documentation/corelocation/clgeocoder
* MapKit Dependency: https://developer.apple.com/documentation/mapkit
* Pigeon files to update: 
  * `pigeons/clgeocoder.dart` for updates on the native CLGeocoder SDK (deprecated as of iOS 26)
  * `pigeons/mapkit.dart` for updated on the native MapKit SDK


##### 2. Run the code generator from the terminal

After applying the updates, generate the code to update the implementations:

* `dart run pigeon --input pigeons/clgeocoder.dart`
* `dart run pigeon --input pigeons/mapkit.dart`

##### 3. Update the generated APIs in native code

Running the `flutter build` command from step 1 again should provide build errors and indicate what
needs to be done. Alternatively, it can be easier to update native code with the platform's specific
IDE:

Open `example/ios/` or `example/macos/` in Xcode.

##### 4. Write API tests

Assuming a non-static method or constructor was added to the native wrapper, a native test will need
to be added.

Tests location: `darwin/Tests`