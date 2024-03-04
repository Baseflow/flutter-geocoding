## 3.0.0

  **Breaking Change** 
  * Fixes to configure the locale.
  * Removes the `localeIdentifier` argument from all methods. Use method `setLocaleIdentifier` to configure the locale.
  * Removes old iOS version checks and expects iOS 12 and above. (minimal iOS version is 12 per 2.2.0)

## 2.3.0

  * Implements `isPresent` that always returns true.

## 2.2.0

  * Updates `geocoding_platform_interface` to version 3.1.0.
  * Updates minimal iOS version of the example application to 12.

## 2.1.1

* Removes obsolete version check in `toPlacemarkDictionary`. This removes kABPersonAddressStreetKey deprecation warning from occurring.

## 2.1.0

* Splits from `geocoding` as a federated implementation.
