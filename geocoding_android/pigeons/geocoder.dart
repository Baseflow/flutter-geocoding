// ignore_for_file: avoid_unused_constructor_parameters

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/geocoder/geocoder.g.dart',
    kotlinOut:
        'android/src/main/kotlin/com/baseflow/geocoding/AndroidGeocoderLibrary.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.baseflow.geocoding',
      errorClassName: 'AndroidGeocoderError',
    ),
  ),
)

/// A class representing an Address, that is, a set of Strings describing a
/// location.
///
/// See https://developer.android.com/reference/android/location/Address.
@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.location.Address',
  ),
)
abstract class Address {
  /// Returns a line of the address numbered by the given index (starting at 0),
  /// or null if no such line is present.
  String? getAddressLine(int index);

  /// Returns the administrative area name of the address, for example, "CA", or
  /// null if it is unknown/
  String? getAdminArea();

  /// Returns the country code of the address, for example "US", or null if it
  /// is unknown.
  String? getCountryCode();

  /// Returns the localized country name of the address, for example "Iceland",
  /// or null if it is unknown.
  String? getCountryName();

  /// Returns the feature name of the address, for example, "Golden Gate Bridge",
  /// or null if it is unknown
  String? getFeatureName();

  /// Returns the latitude of the address if known.
  double? getLatitude();

  /// Returns the Locale associated with this address.
  Locale getLocale();

  /// Returns the locality of the address, for example "Mountain View", or null
  /// if it is unknown.
  String? getLocality();

  /// Returns the longitude of the address if known.
  double? getLongitude();

  /// Returns the largest index currently in use to specify an address line.
  int getMaxAddressLineIndex();

  /// Returns the phone number of the address if known, or null if it is
  /// unknown.
  String? getPhone();

  /// Returns the postal code of the address, for example "94110", or null if it
  /// is unknown.
  String? getPostalCode();

  /// Returns the premises of the address, or null if it is unknown.
  String? getPremises();

  /// Returns the sub-administrative area name of the address, for example,
  /// "Santa Clara County", or null if it is unknown
  String? getSubAdminArea();

  /// Returns the sub-locality of the address, or null if it is unknown.
  String? getSubLocality();

  /// Returns the sub-thoroughfare name of the address, which may be null.
  String? getSubThouroughfare();

  /// Returns the thoroughfare name of the address, for example,
  /// "1600 Ampitheater Parkway", which may be null
  String? getThouroughfare();

  /// Returns the public URL for the address if known, or null if it is unknown.
  String? getUrl();

  /// Returns true if a latitude has been assigned to this Address, false
  /// otherwise.
  bool hasLatitude();

  /// Returns true if a longitude has been assigned to this Address, false
  /// otherwise.
  bool hasLongitude();
}

/// Information about the current Android build, extracted from system properties.
@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'android.os.Build'),
)
abstract class Build {
  /// Returns the current Android SDK version that is running on the device.
  @static
  int getSdkVersion();
}

/// A listener for asynchronous geocoding results. Only one of the methods will
/// ever be invoked per geocoding attempt. There are no guarantees on how long
/// it will take for a method to be invoked, nor any guarantees on the format or
/// availability of error information.
///
/// See https://developer.android.com/reference/android/location/Geocoder.GeocodeListener.
@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.location.Geocoder.GeocodeListener',
    minAndroidApi: 33,
  ),
)
abstract class GeocodeListener {
  GeocodeListener();

  late void Function(String? errorMessage) onError;

  late void Function(List<Address?> addresses) onGeocode;
}

/// A class for handling geocoding and reverse geocoding.
///
/// See https://developer.android.com/reference/android/location/Geocoder.
@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.location.Geocoder',
  ),
)
abstract class Geocoder {
  /// Creates a [Geocoder].
  Geocoder({Locale? locale});

  /// Provides an array of Addresses that attempt to describe the area
  /// immediately surrounding the given latitude and longitude.
  void getFromLocation(
    double latitude,
    double longitude,
    int maxResults,
    GeocodeListener listener,
  );

  /// Provides an array of Addresses that attempt to describe the area
  /// immediately surrounding the given latitude and longitude.
  ///
  /// Note: this method has been deprecated in Android API 33 as it can result
  /// in blocking the main thread. On Android devices running API 33 or higher
  /// please use the [Geocoder.getFromLocation] method.
  @Deprecated(
      'This method was deprecated in Android API level 33. Use `getFromLocation` instead.')
  List<Address?>? getFromLocationPreAndroidApi33(
    double latitude,
    double longitude,
    int maxResults,
  );

  /// Returns an array of Addresses that attempt to describe the named location,
  /// which may be a place name such as "Dalvik, Iceland", an address such as
  /// "1600 Amphitheatre Parkway, Mountain View, CA", an airport code such as
  /// "SFO", and so forth.
  ///
  /// Additional [bounds] can be specified to describe a geographical box
  /// to which the search area will be limited.
  void getFromLocationName(
    String locationName,
    int maxResults,
    GeocodeListener listener, {
    GeographicBounds? bounds,
  });

  /// Returns an array of Addresses that attempt to describe the named location,
  /// which may be a place name such as "Dalvik, Iceland", an address such as
  /// "1600 Amphitheatre Parkway, Mountain View, CA", an airport code such as
  /// "SFO", and so forth.
  ///
  /// Additional [bounds] can be specified to describe a geographical box
  /// to which the search area will be limited.
  ///
  /// Note: this method has been deprecated in Android API 33 as it can result
  /// in blocking the main thread. On Android devices running API 33 or higher
  /// please use the [Geocoder.getFromLocation] method.
  @Deprecated(
      'This method was deprecated in Android API level 33. Use `getFromLocationName` instead.')
  List<Address?>? getFromLocationNamePreAndroidApi33(
    String locationName,
    int maxResults, {
    GeographicBounds? bounds,
  });

  /// Returns true if there is a geocoder implementation present on the device
  /// that may return results.
  @static
  bool isPresent();
}

/// Geographical bounds describing a geographic box.
@ProxyApi()
abstract class GeographicBounds {
  GeographicBounds();

  late final double lowerLeftLatitude;
  late final double lowerLeftLongitude;
  late final double upperRightLatitude;
  late final double upperRightLongitude;
}

/// A `Locale` object represents a specific geographical, political, or cultural
/// region.
///
/// See https://developer.android.com/reference/java/util/Locale.
@ProxyApi(
    kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.util.Locale'))
abstract class Locale {
  /// Creates a [Locale].
  Locale(String identifier);

  /// Returns the country/region code for this locale, which should either be
  /// the empty string, an uppercase ISO 3166 2-letter code, or a UN M.49
  /// 3-digit code.
  String getCountry();

  /// If the country matches an ISO 3166-1 alpha-2 code, the corresponding
  /// ISO 3166-1 alpha-3 uppercase code is returned.
  String getISO3Country();

  /// If the language matches an ISO 639-1 two-letter code, the corresponding
  /// ISO 639-2/T three-letter lowercase code is returned.
  String getISO3Language();

  /// Returns the language code of this Locale.
  String getLanguage();

  /// Returns the script for this locale, which should either be the empty
  /// string or an ISO 15924 4-letter script code.
  String getScript();

  /// Returns the variant code for this locale.
  String getVariant();
}
