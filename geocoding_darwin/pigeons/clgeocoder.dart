// ignore_for_file: avoid_unused_constructor_parameters

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/clgeocoder/clgeocoder.g.dart',
    swiftOut: 'darwin/geocoding_darwin/Sources/CLGeocoder/CLGeocoderLibrary.g.swift',
  ),
)
/// The floor of a building on which the user’s device is located.
///
/// See https://developer.apple.com/documentation/corelocation/clfloor
@ProxyApi(swiftOptions: SwiftProxyApiOptions(import: 'CoreLocation'))
abstract class CLFloor extends NSObject {
  /// The logical floor of the building.
  late int level;
}

/// An object that displays interactive web content, such as for an in-app
/// browser.
///
/// See https://developer.apple.com/documentation/webkit/wkwebview.
@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    import: 'CoreLocation',
    name: 'CLGeocoder',
  ),
)
abstract class CLGeocoder extends NSObject {
  /// Creates a [CLGeocoder].localLocation.
  CLGeocoder();

  /// Submits a forward-geocoding requesting using the specified address string
  /// and locale information.
  @async
  List<CLPlacemark>? geocodeAddressString(String address, {Locale? locale});

  /// Submits a forward-geocoding requesting using the specified locale and
  /// Contacts framework information.
  @async
  List<CLPlacemark>? geocodePostalAddress(
    CNPostalAddress postalAddress, {
    Locale? locale,
  });

  /// Submits a reverse-geocoding request for the specified location.
  @async
  List<CLPlacemark>? reverseGeocodeLocation(
    CLLocation location, {
    Locale? locale,
  });
}

/// The latitude, longitude, and course information reported by the system.
///
/// See https://developer.apple.com/documentation/corelocation/cllocation
@ProxyApi(swiftOptions: SwiftProxyApiOptions(import: 'CoreLocation'))
abstract class CLLocation extends NSObject {
  /// Creates a [CLLocation] based on the supplied coordinates.
  CLLocation(double latitude, double longitude);

  /// The geographical coordinate information.
  CLLocationCoordinate2D getCoordinate();

  /// The altitude above mean sea level associated with a location, measured in
  /// meters.
  double getAltitude();

  /// The altitude as a height above the World Geodetic System 1984 (WGS84)
  /// ellipsoid, measured in meters.
  double getEllipsoidalAltitude();

  /// The logical floor of the building in which the user is located.
  CLFloor? getFloor();

  /// The time at which this location was determined (in seconds since epoch).
  int getTimestamp();

  /// Information about the source that provides the location.
  CLLocationSourceInformation? getSourceInformation();

  /// The radius of uncertainty for the location, measured in meters.
  double getHorizontalAccuracy();

  /// The validity of the altitude values, and their estimated uncertainty,
  /// measured in meters.
  double getVerticalAccuracy();

  /// The instantaneous speed of the device, measured in meters per second.
  double getSpeed();

  /// The accuracy of the speed value, measured in meters per second.
  double getSpeedAccuracy();

  /// The direction in which the device is traveling, measured in degrees and
  /// relative to due north.
  double getCourse();

  /// The accuracy of the course value, measured in degrees.
  double getCourseAccuracy();

  /// Returns the distance (measured in meters) from the current object’s
  /// location to the specified location.
  double distance(CLLocation from);
}

/// The latitude and longitude associated with a location, specified using the
/// WGS 84 reference frame.
///
/// See https://developer.apple.com/documentation/corelocation/cllocationcoordinate2d
@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    import: 'CoreLocation',
    name: 'CLLocationCoordinate2DWrapper',
  ),
)
abstract class CLLocationCoordinate2D extends NSObject {
  /// The latitude in degrees.
  late double latitude;

  /// The longitude in degrees.
  late double longitude;
}

/// Information about the source that provides a location.
///
/// See https://developer.apple.com/documentation/corelocation/cllocationsourceinformation
@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    import: 'CoreLocation',
    minIosApi: '15.0.0',
    minMacosApi: '12.0.0',
  ),
)
abstract class CLLocationSourceInformation extends NSObject {
  /// A Boolean value that indicates whether the system receives the location
  /// from an external accessory.
  late bool isProducedByAccessory;

  /// A Boolean value that indicates whether the system generates the location
  /// using on-device software simulation.
  late bool isSimulatedBySoftware;
}

/// A user-friendly description of a geographic coordinate, often containing the
/// name of the place, its address, and other relevant information.
///
/// See https://developer.apple.com/documentation/corelocation/clplacemark
@ProxyApi(swiftOptions: SwiftProxyApiOptions(import: 'CoreLocation'))
abstract class CLPlacemark extends NSObject {
  /// The [CLLocation] containing latitude and longitude information.
  late CLLocation? location;

  /// The name of the placemark.
  late String? name;

  /// The street address associated with the placemark.
  late String? thoroughfare;

  /// Additional street-level information for the placemark.
  late String? subThoroughfare;

  /// The city associated with the placemark.
  late String? locality;

  /// Additional city-level information for the placemark.
  late String? subLocality;

  /// The state or province associated with the placemark.
  late String? administrativeArea;

  /// Additional administrative area information for the placemark.
  late String? subAdministrativeArea;

  /// The postal code associated with the placemark.
  late String? postalCode;

  /// The abbreviated country or region name.
  late String? isoCountryCode;

  /// The name of the country or region associated with the placemark.
  late String? country;

  /// The postal address associated with the location, formatted for use with the Contacts framework.
  late CNPostalAddress? postalAddress;
}

/// An immutable representation of the postal address for a contact.
///
/// See https://developer.apple.com/documentation/Contacts/CNPostalAddress
@ProxyApi(swiftOptions: SwiftProxyApiOptions(import: 'Contacts'))
abstract class CNPostalAddress extends NSObject {
  /// The street name in a postal address.
  late String street;

  /// The city name in a postal address.
  late String city;

  /// The state name in a postal address.
  late String state;

  /// The postal code in a postal address.
  late String postalCode;

  /// The country or region name in a postal address.
  late String country;

  /// The ISO country code for the country or region in a postal address, using
  /// the ISO 3166-1 alpha-2 standard.
  late String isoCountryCode;

  /// The subadministrative area (such as a county or other region) in a postal
  /// address.
  late String subAdministrativeArea;

  /// Additional information associated with the location, typically defined at
  /// the city or town level, in a postal address.
  late String subLocality;
}

/// Information about linguistic, cultural, and technological conventions for
/// use in formatting data for presentation.
///
/// See https://developer.apple.com/documentation/Foundation/Locale
@ProxyApi(swiftOptions: SwiftProxyApiOptions(name: 'LocaleWrapper'))
abstract class Locale {
  /// Creates a [Locale] matching the given identifier.
  Locale(String identifier);

  /// The identifier of the locale.
  String getIdentifier();
}

/// The values that can be returned in a change dictionary.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvalueobservingoptions.
enum KeyValueObservingOptions {
  /// Indicates that the change dictionary should provide the new attribute
  /// value, if applicable.
  newValue,

  /// Indicates that the change dictionary should contain the old attribute
  /// value, if applicable.
  oldValue,

  /// If specified, a notification should be sent to the observer immediately,
  /// before the observer registration method even returns.
  initialValue,

  /// Whether separate notifications should be sent to the observer before and
  /// after each change, instead of a single notification after the change.
  priorNotification,
}

/// The kinds of changes that can be observed.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvaluechange.
enum KeyValueChange {
  /// Indicates that the value of the observed key path was set to a new value.
  setting,

  /// Indicates that an object has been inserted into the to-many relationship
  /// that is being observed.
  insertion,

  /// Indicates that an object has been removed from the to-many relationship
  /// that is being observed.
  removal,

  /// Indicates that an object has been replaced in the to-many relationship
  /// that is being observed.
  replacement,

  /// The value is not recognized by the wrapper.
  unknown,
}

/// The keys that can appear in the change dictionary.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvaluechangekey.
enum KeyValueChangeKey {
  /// If the value of the `KeyValueChangeKey.kind` entry is
  /// `KeyValueChange.insertion`, `KeyValueChange.removal`, or
  /// `KeyValueChange.replacement`, the value of this key is a Set object that
  /// contains the indexes of the inserted, removed, or replaced objects.
  indexes,

  /// An object that contains a value corresponding to one of the
  /// `KeyValueChange` enum, indicating what sort of change has occurred.
  kind,

  /// If the value of the `KeyValueChange.kind` entry is
  /// `KeyValueChange.setting, and `KeyValueObservingOptions.newValue` was
  /// specified when the observer was registered, the value of this key is the
  /// new value for the attribute.
  newValue,

  /// If the `KeyValueObservingOptions.priorNotification` option was specified
  /// when the observer was registered this notification is sent prior to a
  /// change.
  notificationIsPrior,

  /// If the value of the `KeyValueChange.kind` entry is
  /// `KeyValueChange.setting`, and `KeyValueObservingOptions.old` was specified
  /// when the observer was registered, the value of this key is the value
  /// before the attribute was changed.
  oldValue,

  /// The value is not recognized by the wrapper.
  unknown,
}

/// The root class of most Objective-C class hierarchies, from which subclasses
/// inherit a basic interface to the runtime system and the ability to behave as
/// Objective-C objects.
///
/// See https://developer.apple.com/documentation/objectivec/nsobject.
@ProxyApi()
abstract class NSObject {
  NSObject();

  /// Informs the observing object when the value at the specified key path
  /// relative to the observed object has changed.
  late void Function(
    String? keyPath,
    NSObject? object,
    Map<KeyValueChangeKey, Object?>? change,
  )?
  observeValue;

  /// Registers the observer object to receive KVO notifications for the key
  /// path relative to the object receiving this message.
  void addObserver(
    NSObject observer,
    String keyPath,
    List<KeyValueObservingOptions> options,
  );

  /// Stops the observer object from receiving change notifications for the
  /// property specified by the key path relative to the object receiving this
  /// message.
  void removeObserver(NSObject observer, String keyPath);
}
