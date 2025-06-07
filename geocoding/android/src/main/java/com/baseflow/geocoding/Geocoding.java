package com.baseflow.geocoding;

import androidx.annotation.Nullable;
import android.content.Context;
import android.location.Address;
import android.location.Geocoder;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

/** Geocoding components to lookup address or coordinates. */
class Geocoding {
    private final Context androidContext;

    /**
     * Uses the given {@code androidContext} to execute geocoding features
     *
     * @param androidContext the context to use when requesting geocoding features
     */
    Geocoding(Context androidContext) {
        this.androidContext = androidContext;
    }

    /**
     * Returns a list of Address objects matching the supplied address string.
     *
     * @param address the address string for the search
     * @param locale the desired Locale for the query results
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws java.io.IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> placemarkFromAddress(String address,
                                       Locale locale,
                                       Double lowerLeftLatitude,
                                       Double lowerLeftLongitude,
                                       Double upperRightLatitude,
                                       Double upperRightLongitude) throws IOException {
        final Geocoder geocoder = createGeocoder(androidContext, locale);
        if (lowerLeftLatitude == null || lowerLeftLongitude == null || upperRightLatitude == null || upperRightLongitude == null) {
            return geocoder.getFromLocationName(address, 5);
        }else {
            return geocoder.getFromLocationName(
                    address,
                    5,
                    lowerLeftLatitude,
                    lowerLeftLongitude,
                    upperRightLatitude,
                    upperRightLongitude
            );
        }
    }

    /**
     * Returns a list of Address objects matching the supplied coordinates.
     *
     * @param latitude the latitude point for the search
     * @param longitude the longitude point for the search
     * @param locale the desired Locale for the query results
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> placemarkFromCoordinates(
            double latitude,
            double longitude,
            Locale locale) throws IOException {

        final Geocoder geocoder = createGeocoder(androidContext, locale);
        return geocoder.getFromLocation(latitude, longitude, 5);
    }

    private static Geocoder createGeocoder(Context androidContext, @Nullable Locale locale) {
        return (locale != null)
                ? new Geocoder(androidContext, locale)
                : new Geocoder(androidContext);
    }
}