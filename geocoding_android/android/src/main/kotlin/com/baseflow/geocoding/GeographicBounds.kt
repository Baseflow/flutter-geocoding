package com.baseflow.geocoding

/// Describes a geographical box by specifying the latitude and longitude of the lower left point and upper right point.
data class GeographicBounds (val lowerLeftLatitude: Double, val lowerLeftLongitude: Double, val upperRightLatitude: Double, val upperRightLongitude: Double)