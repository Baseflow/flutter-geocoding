package com.baseflow.geocoding.proxies

import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.GeographicBounds
import com.baseflow.geocoding.PigeonApiGeographicBounds

/**
 * ProxyApi implementation for {@link GeographicalBounds}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class GeographicBoundsProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) :
    PigeonApiGeographicBounds(pigeonRegistrar) {
    override fun pigeon_defaultConstructor(
        lowerLeftLatitude: Double,
        lowerLeftLongitude: Double,
        upperRightLatitude: Double,
        upperRightLongitude: Double
    ): GeographicBounds {
        return GeographicBounds(lowerLeftLatitude, lowerLeftLongitude,upperRightLatitude, upperRightLongitude);
    }

    override fun lowerLeftLatitude(pigeon_instance: GeographicBounds): Double {
        return pigeon_instance.lowerLeftLatitude;
    }

    override fun lowerLeftLongitude(pigeon_instance: GeographicBounds): Double {
        return pigeon_instance.lowerLeftLongitude;
    }

    override fun upperRightLatitude(pigeon_instance: GeographicBounds): Double {
        return pigeon_instance.upperRightLatitude;
    }

    override fun upperRightLongitude(pigeon_instance: GeographicBounds): Double {
        return pigeon_instance.upperRightLongitude;
    }

}