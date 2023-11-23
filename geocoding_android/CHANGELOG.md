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