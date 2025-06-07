## 3.2.1

- Fixed analysis warnings from `flutter analyse`.

## 3.2.0

- Adds `isPresent` method to the platform interface.

## 3.1.0

- Adds `placemarkFromAddress` method to the platform interface.

## 3.0.0

- **Breaking Change** Changes to the platform interface calls, the locale is now set in a separate call.
- Removes the default method channel implementation.

## 2.0.1

- Updated the installation instructions in the README.md file.

## 2.0.0

- Migrate to null safety.

## 1.0.1+1

- Make sure the README.md mentions the correct version number.

## 1.0.1

- Added NoResultFoundException to indicate when no results are found, instead of PlatformException

## 1.0.0+3

- Renamed the method `placemarkFromAddress` to `locationFromAddress`.

## 1.0.0+2

- Return `location` class from the `placemarkFromAddress` method.

## 1.0.0+1

- Add missing street and toString implementation to Placemark.

## 1.0.0

- Initial open-source release.
