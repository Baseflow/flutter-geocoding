## 4.0.0

* **BREAKING CHANGES** Please update to Flutter 3.29+ before updating to this version
* Updates Android CompileSDK to 35
* Migrates example project to applying Gradle plugins with the declarative plugins block
* Updates kotlin version to soon minimal supported Kotlin version `1.8.10`
* Updates Gradle version to `8.11.1`

## 3.3.1

* Removes deprecated support for Android V1 embedding as support will be removed from Flutter (see [flutter/flutter#144726](https://github.com/flutter/flutter/pull/144726)).

## 3.3.0

* Adds `setLocaleIdentifier` to the Android example app.

## 3.2.0

* Exposes isPresent() call that returns true if there is a geocoder implementation present that may return results.

## 3.1.0

* Fixes deprecation build warnings. 
* Adds Android API 34 support.

## 3.0.0

* **BREAKING CHANGES**:
  * Updates `geocoding_platform_interface` to version 3.1.0.
  * Adds method `setLocaleIdentifier` to set the locale for all calls to the geocoding platform.
  * Removes the `localeIdentifier` argument from all methods. Use method `setLocaleIdentifier` to configure the locale.
* Implements `placemarkFromAddress`.

## 2.1.2

* Downgrades Android Gradle plugin to version 7.3.1 so the project is inline with current Flutter stable (version 3.10.5).

## 2.1.1

* Updates the Android Gradle plugin to version 8 and the Android Gradle build tools to version 8.0.2.

## 2.1.0

* Splits from `geocoding` as a federated implementation.