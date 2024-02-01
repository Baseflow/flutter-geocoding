package com.baseflow.geocoding;

import androidx.annotation.Nullable;

import android.content.Context;
import android.location.Address;
import android.location.Geocoder;
import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


/**
 * Geocoding components to lookup address or coordinates.
 */
class Geocoding {
    private final Context androidContext;
    @Nullable
    private Locale locale;

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
    @SuppressWarnings("deprecation")
    void placemarkFromAddress(String address, GeocodeListenerAdapter callback) throws IOException {
        final Geocoder geocoder = createGeocoder(androidContext, locale);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getAddressesWithGeocodeListener(geocoder, address, 5, callback);
        } else {
            List<Address> addresses = geocoder.getFromLocationName(address, 5);
            callback.onGeocode(addresses);
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.TIRAMISU)
    private void getAddressesWithGeocodeListener(Geocoder geocoder, String address, int maxResults, GeocodeListenerAdapter callback) {
        geocoder.getFromLocationName(address, maxResults, new Geocoder.GeocodeListener() {
            @Override
            public void onGeocode(List<Address> geocodedAddresses) {
                callback.onGeocode(geocodedAddresses);
            }

            @Override
            public void onError(@Nullable String errorMessage) {
                callback.onError(errorMessage);
            }
        });
    }

    /**
     * Returns a list of Address objects matching the supplied coordinates.
     *
     * @param latitude  the latitude point for the search
     * @param longitude the longitude point for the search
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws IOException if the network is unavailable or any other I/O problem occurs.
     */
    @SuppressWarnings("deprecation")
    void placemarkFromCoordinates(
            double latitude,
            double longitude,
            GeocodeListenerAdapter callback
    ) throws IOException {
        final Geocoder geocoder = createGeocoder(androidContext, locale);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getLocationWithGeocodeListener(geocoder, latitude, longitude, 5, callback);
        } else {
            callback.onGeocode(geocoder.getFromLocation(latitude, longitude, 5));
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.TIRAMISU)
    private void getLocationWithGeocodeListener(Geocoder geocoder, double latitude, double longitude, int maxResults, GeocodeListenerAdapter callback) {
        geocoder.getFromLocation(latitude, longitude, maxResults, new Geocoder.GeocodeListener() {
            @Override
            public void onGeocode(List<Address> geocodedAddresses) {
                callback.onGeocode(geocodedAddresses);
            }

            @Override
            public void onError(@Nullable String errorMessage) {
                callback.onError(errorMessage);
            }
        });
    }

    private static Geocoder createGeocoder(Context androidContext, @Nullable Locale locale) {
        return (locale != null)
                ? new Geocoder(androidContext, locale)
                : new Geocoder(androidContext);
    }
}
