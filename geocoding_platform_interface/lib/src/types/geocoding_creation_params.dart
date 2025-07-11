import 'package:meta/meta.dart';

/// Object specifying creation parameters for creating a [Geocoding].
///
/// Platform specific implementations can add additional fields by extending
/// this class.
///
/// This example demonstrates how to extend the [GeocodingCreationParams] to
/// provide additional platform specific parameters.
///
/// When extending [GeocodingCreationParams] additional
/// parameters should always accept `null` or have a default value to prevent
/// breaking changes.
///
/// ```dart
/// class AndroidGeocodingCreationParams extends GeocodingCreationParams {
///   AndroidGeocodingCreationParams._(
///     // This parameter prevents breaking changes later.
///     // ignore: avoid_unused_constructor_parameters
///     GeocodingCreationParams params, {
///     this.filter,
///   }) : super();
///
///   factory AndroidGeocodingCreationParams.fromGeocodingCreationParams(
///       GeocodingCreationParams params, {
///       String? filter,
///   }) {
///     return AndroidGeocodingCreationParams._(params, filter: filter);
///   }
///
///   final String? filter;
/// }
/// ```
@immutable
class GeocodingCreationParams {
  /// Used by the platform implementation to create a new
  /// [GeocodingCreationParams].
  const GeocodingCreationParams();
}
