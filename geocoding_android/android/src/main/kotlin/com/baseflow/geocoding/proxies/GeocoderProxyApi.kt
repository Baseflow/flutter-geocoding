package com.baseflow.geocoding.proxies

import android.location.Address
import android.location.Geocoder
import android.os.Build
import androidx.annotation.DeprecatedSinceApi
import androidx.annotation.RequiresApi
import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.GeographicBounds
import com.baseflow.geocoding.PigeonApiGeocoder
import com.baseflow.geocoding.ProxyApiRegistrar
import java.util.Locale

/**
 * ProxyApi implementation for {@link Geocoder}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class GeocoderProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) :
    PigeonApiGeocoder(pigeonRegistrar) {
    override fun pigeon_defaultConstructor(locale: Locale?): Geocoder {
        check(pigeonRegistrar is ProxyApiRegistrar) { "The pigeonRegistrar is not an instance of ProxyApiRegistrar." }

        if (locale != null) {
            return Geocoder(pigeonRegistrar.context, locale);
        }
        return Geocoder(pigeonRegistrar.context);
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun getFromLocation(
        pigeon_instance: Geocoder,
        latitude: Double,
        longitude: Double,
        maxResults: Long,
        listener: Geocoder.GeocodeListener
    ) {
        return pigeon_instance.getFromLocation(latitude, longitude, maxResults.toInt(), listener);
    }

    @DeprecatedSinceApi(33, "Use getFromLocation(double, double, int, android.location.Geocoder.GeocodeListener) instead to avoid blocking a thread waiting for results.")
    override fun getFromLocationPreAndroidApi33(
        pigeon_instance: Geocoder,
        latitude: Double,
        longitude: Double,
        maxResults: Long
    ): List<Address?>? {
        return pigeon_instance.getFromLocation(latitude, longitude, maxResults.toInt());
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun getFromLocationName(
        pigeon_instance: Geocoder,
        locationName: String,
        maxResults: Long,
        listener: Geocoder.GeocodeListener,
        bounds: GeographicBounds?,
    ) {
        if (bounds != null) {
            return pigeon_instance.getFromLocationName(locationName, maxResults.toInt(), bounds.lowerLeftLatitude, bounds.lowerLeftLongitude, bounds.upperRightLatitude, bounds.upperRightLongitude, listener);
        }

        return pigeon_instance.getFromLocationName(locationName, maxResults.toInt(), listener);
    }

    @DeprecatedSinceApi(33,
        "Use getFromLocationName(java.lang.String, int, double, double, double, double, android.location.Geocoder.GeocodeListener) instead to avoid blocking a thread waiting for results."
    )
    override fun getFromLocationNamePreAndroidApi33(
        pigeon_instance: Geocoder,
        locationName: String,
        maxResults: Long,
        bounds: GeographicBounds?
    ): List<Address?>? {
        if (bounds != null) {
            return pigeon_instance.getFromLocationName(locationName, maxResults.toInt(), bounds.lowerLeftLatitude, bounds.lowerLeftLongitude, bounds.upperRightLatitude, bounds.upperRightLongitude)
        }

        return pigeon_instance.getFromLocationName(locationName, maxResults.toInt())
    }

    override fun isPresent(): Boolean {
        return Geocoder.isPresent();
    }
}