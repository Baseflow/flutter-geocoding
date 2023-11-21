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
    @Nullable private Locale locale;

    /**
     * Uses the given {@code androidContext} to execute geocoding features
     *
     * @param androidContext the context to use when requesting geocoding features
     */
    Geocoding(Context androidContext) {
        this.androidContext = androidContext;
    }

    void setLocaleIdentifier(@Nullable Locale locale) {
        this.locale = locale;
    }

    /**
     * Returns a list of Address objects matching the supplied address string.
     *
     * @param address the address string for the search
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws java.io.IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> placemarkFromAddress(String address) throws IOException {

        final Geocoder geocoder = createGeocoder(androidContext, locale);
        return geocoder.getFromLocationName(address, 5);
    }

    /**
     * Returns a list of Address objects matching the supplied coordinates.
     *
     * @param latitude the latitude point for the search
     * @param longitude the longitude point for the search
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> placemarkFromCoordinates(
            double latitude,
            double longitude
    ) throws IOException {
        final Geocoder geocoder = createGeocoder(androidContext, locale);
        return geocoder.getFromLocation(latitude, longitude, 5);
    }

    private static Geocoder createGeocoder(Context androidContext, @Nullable Locale locale) {
        return (locale != null)
                ? new Geocoder(androidContext, locale)
                : new Geocoder(androidContext);
    }
}
