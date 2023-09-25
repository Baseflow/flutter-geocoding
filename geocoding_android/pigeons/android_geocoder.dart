import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/geocoder.pigeon.dart',
    dartTestOut: 'test/test_geocoder.pigeon.dart',
    javaOut: 'android/src/main/java/com/baseflow/geocoding/GeocoderPigeon.java',
    javaOptions: JavaOptions(
      package: 'com.baseflow.geocoding',
      className: 'GeocoderPigeon',
    ),
  ),
)

/// A class representing an Address.
///
/// The address format is a simplified version of xAL (eXtensible Address Language, http://www.oasis-open.org/committees/ciq/ciq.html#6).
class Address {
  /// Creates a new instance of the [Address] class.
  Address(
    this.addressLines,
    this.adminArea,
    this.countryCode,
    this.countryName,
    this.featureName,
    this.latitude,
    this.locale,
    this.locality,
    this.longitude,
    this.phone,
    this.postalCode,
    this.premises,
    this.subAdminArea,
    this.subLocality,
    this.subThoroughfare,
    this.thoroughfare,
    this.url,
  );

  /// The address lines associated with the address.
  List<String?> addressLines;

  /// The administrative area associated with the address.
  String? adminArea;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  String? countryCode;

  /// The name of the country associated with the address.
  String? countryName;

  /// The feature name associated with the address.
  String? featureName;

  /// The latitude associated with the address.
  double latitude;

  /// The locale associated with the address.
  String locale;

  /// The name of the city associated with the address.
  String? locality;

  /// The longitude associated with the address.
  double longitude;

  /// The phone number associated with the address.
  String? phone;

  /// The postal code associated with the address.
  String? postalCode;

  /// The premises associated with the address.
  String? premises;

  /// Additional administrative area information for the placemark.
  String? subAdminArea;

  /// Additional city-level information for the address.
  String? subLocality;

  /// Additional street address information for the address.
  String? subThoroughfare;

  /// The street address associated with the address.
  String? thoroughfare;

  /// The url associated with the address.
  String? url;
}

/// A class representing a specific geographical, political or cultural region.
class Locale {
  /// Creates a new [Locale].
  ///
  /// Note:
  /// * ISO 639 is not a stable standard; some of the language codes it
  /// defines (specifically "iw", "ji", and "in") have changed. This
  /// constructor accepts both the old codes ("iw", "ji", and "in") and the new
  /// codes ("he", "yi", and "id").
  /// * For backward compatibility reasons, this constructor does not make any
  /// syntactic checks on the input.
  /// * The two cases ("ja", "JP", "JP") and ("th", "TH", "TH") are handled
  /// specially, see [Special Cases](https://developer.android.com/reference/java/util/Locale#special_cases_constructor) for more information.
  ///
  /// The [language] for the [Locale] should be formatted according to the
  /// ISO 639 alpha-2 or alpha-3 language code standard, or a language subtag
  /// up to 8 characters in length. See the [Android Locale class](https://developer.android.com/reference/java/util/Locale)
  /// description about valid language values.
  ///
  /// The [country] for the [Locale] should be formatted according to the
  /// ISO 3166 alpha-2 country code or a UN M.49 numeric-3 area code. See the
  /// [Android Locale class](https://developer.android.com/reference/java/util/Locale) description about valid language values.
  ///
  /// The [variant] can be any arbitrary value used to indicate a variation of
  /// a Locale. See the [Android Locale class](https://developer.android.com/reference/java/util/Locale) description about valid language values.
  Locale(
    this.language,
    this.country,
    this.variant,
  );

  /// The [language] of the current [Locale].
  ///
  /// The [language] is formatted according to the ISO 639 alpha-2 or alpha-3
  /// language code standard, or a language subtag up to 8 characters in
  /// length. See the [Android Locale class](https://developer.android.com/reference/java/util/Locale)
  /// description about valid language values.
  String language;

  /// The [country] of the current [Locale].
  ///
  /// The [country] is formatted according to the ISO 3166 alpha-2 country code
  /// or a UN M.49 numeric-3 area code. See the [Android Locale class](https://developer.android.com/reference/java/util/Locale)
  /// description about valid language values.
  String? country;

  /// The [variant] of the current [Locale].
  ///
  /// The [variant] can be any arbitrary value used to indicate a variation of
  /// a Locale. See the [Android Locale class](https://developer.android.com/reference/java/util/Locale) description about valid language values.
  String? variant;
}

/// Host API for managing the native `InstanceManager`.
@HostApi(dartHostTestHandler: 'TestInstanceManagerHostApi')
abstract class InstanceManagerHostApi {
  /// Clear the native `InstanceManager`.
  ///
  /// This is typically only used after a hot restart.
  void clear();
}

/// Handles methods calls to the native Java Object class.
///
/// Also handles calls to remove the reference to an instance with `dispose`.
///
/// See https://docs.oracle.com/javase/7/docs/api/java/lang/Object.html.
@HostApi(dartHostTestHandler: 'TestJavaObjectHostApi')
abstract class JavaObjectHostApi {
  void dispose(String identifier);
}

/// Handles callbacks methods for the native Java Object class.
///
/// See https://docs.oracle.com/javase/7/docs/api/java/lang/Object.html.
@FlutterApi()
abstract class JavaObjectFlutterApi {
  void dispose(String identifier);
}

/// Host API for `Geocoding`.
///
/// This class may handle instantiating and adding native object instances that
/// are attached to a Dart instance or handle method calls on the associated
/// native class or an instance of the class.
@HostApi(dartHostTestHandler: 'TestGeocoderHostApi')
abstract class GeocoderHostApi {
  /// Creates a new native instance and adds it to the `InstanceManager`.
  void create(
    String instanceId,
    Locale locale,
  );

  /// Request a list of [Address]es that attempt to describe the surroundings
  /// of the provided [latitude] and [longitude].
  ///
  /// The [maxResults] indicates the max number of [Address]es to be returned.
  /// Smaller numbers (1 to 5) are recommended.
  ///
  /// The [geocodeListenerInstanceId] refers to the [GeocodeListenerFlutterApi]
  /// instance that should be used to receive the results.
  void getFromLocation(
    String instanceId,
    double latitude,
    double longitude,
    int maxResults,
    String geocodeListenerInstanceId,
  );

  /// Requests an array of [Address]es that attempt to describe the named
  /// [address].
  ///
  /// The [address] may be a place name such as "Dalvik, Iceland", an address
  /// such as "1600 Amphitheatre Parkway, Mountain View, CA", an airport code
  /// such as "SFO", and so forth. The resulting addresses should be localized
  /// for the locale provided to this class's constructor.
  ///
  /// The [geocodeListenerInstanceId] refers to the [GeocodeListenerFlutterApi]
  /// instance that should be used to receive the results.
  ///
  /// You may specify a bounding box for the search results by including the
  /// latitude and longitude of the lower left point and upper right point of
  /// the box.
  void getFromLocationName(
    String instanceId,
    String address,
    String geocodeListenerInstanceId,
    int? maxResults,
    double? lowerLeftLatitude,
    double? lowerLeftLongitude,
    double? upperRightLatitude,
    double? upperRightLongitude,
  );

  /// Indicates if a geocoder implementation is present that may return results.
  ///
  /// If `true`, there is still no guarantee that any individual geocoding
  /// attempt will succeed.
  bool isPresent();
}

@HostApi(dartHostTestHandler: 'TestGeocodeListenerHostApi')
abstract class GeocodeListenerHostApi {
  void create(String instanceId);
}

@FlutterApi()
abstract class GeocodeListenerFlutterApi {
  void onError(
    String instanceId,
    String errorMessage,
  );

  void onGeocode(
    String instanceId,
    List<Address?> addresses,
  );
}
