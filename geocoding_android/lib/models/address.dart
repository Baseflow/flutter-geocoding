import 'package:flutter/foundation.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

/// Contains detailed Address information.
@immutable
class Address {
  /// Constructs an instance with the given values for testing. [Address]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  const Address({
    required this.addressLine,
    required this.adminArea,
    required this.countryCode,
    required this.countryName,
    required this.featureName,
    required this.latitude,
    required this.locale,
    required this.locality,
    required this.longitude,
    required this.phone,
    required this.postalCode,
    required this.premises,
    required this.subAdminArea,
    required this.subLocality,
    required this.subThoroughfare,
    required this.thoroughfare,
    required this.url,
  });

  const Address._({
    required this.addressLine,
    required this.adminArea,
    required this.countryCode,
    required this.countryName,
    required this.featureName,
    required this.latitude,
    required this.locale,
    required this.locality,
    required this.longitude,
    required this.phone,
    required this.postalCode,
    required this.premises,
    required this.subAdminArea,
    required this.subLocality,
    required this.subThoroughfare,
    required this.thoroughfare,
    required this.url,
  });

  /// The address lines associated with the address.
  final List<String> addressLine;

  /// The administrative area associated with the address.
  final String adminArea;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  final String countryCode;

  /// The name of the country associated with the address.
  final String countryName;

  /// The feature name associated with the address.
  final String featureName;

  /// The latitude associated with the address.
  final double latitude;

  /// The locale associated with the address.
  final String locale;

  /// The name of the city associated with the address.
  final String locality;

  /// The longitude associated with the address.
  final double longitude;

  /// The phone number associated with the address.
  final String phone;

  /// The postal code associated with the address.
  final String postalCode;

  /// The premises associated with the address.
  final String premises;

  /// Additional administrative area information for the placemark.
  final String subAdminArea;

  /// Additional city-level information for the address.
  final String subLocality;

  /// The street address associated with the address.
  final String thoroughfare;

  /// Additional street address information for the address.
  final String subThoroughfare;

  /// The url associated with the address.
  final String url;

  @override
  bool operator ==(dynamic other) =>
      other is Address &&
      listEquals(other.addressLine, addressLine) &&
      other.adminArea == adminArea &&
      other.countryCode == countryCode &&
      other.countryName == countryName &&
      other.featureName == featureName &&
      other.postalCode == postalCode &&
      other.latitude == latitude &&
      other.locale == locale &&
      other.locality == locality &&
      other.longitude == longitude &&
      other.phone == phone &&
      other.postalCode == postalCode &&
      other.premises == premises &&
      other.subAdminArea == subAdminArea &&
      other.subLocality == subLocality &&
      other.subThoroughfare == subThoroughfare &&
      other.thoroughfare == thoroughfare &&
      other.url == url;

  @override
  int get hashCode =>
      addressLine.hashCode ^
      adminArea.hashCode ^
      countryCode.hashCode ^
      featureName.hashCode ^
      latitude.hashCode ^
      locale.hashCode ^
      locality.hashCode ^
      longitude.hashCode ^
      phone.hashCode ^
      postalCode.hashCode ^
      premises.hashCode ^
      postalCode.hashCode ^
      subAdminArea.hashCode ^
      subLocality.hashCode ^
      subThoroughfare.hashCode ^
      thoroughfare.hashCode ^
      url.hashCode;

  /// Converts a list of [Map] instances to a list of [Address] instances.
  static List<Address> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<Address> list = message.map<Address>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Address] class.
  static Address fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> addressMap = message;

    final List<String> addressLines =
        addressMap['addressLine'].map<String>((obj) => obj.toString()).toList();

    return Address._(
      addressLine: addressLines,
      adminArea: addressMap['adminArea'] ?? '',
      countryCode: addressMap['countryCode'] ?? '',
      countryName: addressMap['countryName'] ?? '',
      featureName: addressMap['featureName'] ?? '',
      latitude: addressMap['latitude'] ?? '',
      locale: addressMap['locale'] ?? '',
      locality: addressMap['locality'] ?? '',
      longitude: addressMap['longitude'] ?? '',
      phone: addressMap['phone'] ?? '',
      postalCode: addressMap['postalCode'] ?? '',
      premises: addressMap['premises'] ?? '',
      subAdminArea: addressMap['subAdminArea'] ?? '',
      subLocality: addressMap['subLocality'] ?? '',
      subThoroughfare: addressMap['subThoroughfare'] ?? '',
      thoroughfare: addressMap['thoroughfare'] ?? '',
      url: addressMap['url'] ?? '',
    );
  }

  /// Converts the [Address] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
        'addressLine': addressLine,
        'adminArea': adminArea,
        'countryCode': countryCode,
        'countryName': countryName,
        'featureName': featureName,
        'latitude': latitude,
        'locale': locale,
        'locality': locality,
        'longitude': longitude,
        'phone': phone,
        'postalCode': postalCode,
        'premises': premises,
        'subAdminArea': subAdminArea,
        'subLocality': subLocality,
        'subThoroughfare': subThoroughfare,
        'thoroughfare': thoroughfare,
        'url': url,
      };

  @override
  String toString() {
    return '''
      FeatureName: $featureName, 
      ISO Country Code: $countryCode, 
      Country: $countryName, 
      Postal code: $postalCode, 
      Administrative area: $adminArea, 
      Subadministrative area: $subAdminArea,
      Locality: $locality,
      Sublocality: $subLocality,
      Thoroughfare: $thoroughfare,
      Subthoroughfare: $subThoroughfare''';
  }

  /// Get the placemark-data for an address.
  Placemark toPlacemark() {
    return Placemark(
      name: featureName,
      street: street,
      isoCountryCode: countryCode,
      country: countryName,
      postalCode: postalCode,
      administrativeArea: adminArea,
      subAdministrativeArea: subAdminArea,
      locality: locality,
      subLocality: subLocality,
      thoroughfare: thoroughfare,
      subThoroughfare: subThoroughfare,
    );
  }

  /// Get the placemark-data for an address
  Location toLocation() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );
  }

  /// Returns the street name associated with the address.
  String? get street {
    if (addressLine.isEmpty) {
      return null;
    }

    final splitted = addressLine.first.split(',');

    if (splitted.isNotEmpty) {
      return splitted.first;
    }

    return null;
  }
}
