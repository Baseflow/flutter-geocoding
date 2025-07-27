/// An exception thrown after unsuccessfully attempting to retrieve
/// a [Placemark] from coordinates as [double] latitude and longitude
/// or [Location] from address as [String]
class NoResultFoundException implements Exception {
  /// Constructs the [LocationServiceDisabledException]
  const NoResultFoundException();

  @override
  String toString() =>
      'Could not find any result for the supplied address or coordinates.';
}
