package com.baseflow.geocoding;

import androidx.annotation.Nullable;

import android.annotation.NonNull;
import android.annotation.Nullable;
import android.content.Context;
import android.location.Address;
import android.location.Geocoder;

import com.baseflow.geocoding.utils.AddressMapper;

import io.flutter.plugin.common.MethodChannel.Result;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/** Geocoding components to lookup address or coordinates. */
class Geocoding {
    private final Context androidContext;
    @Nullable private Locale locale;

    private static interface GeocodeListenerAdapter {
        void onGeocode(@NonNull List<Address> addresses);
        void onError(@Nullable String errorMessage);
    }

    @FunctionalInterface
    static interface PlacemarkMapper {
        public List<Map<String, Object>> toHashMapList(List<Address> addresses);
    }

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
     * Calls result.success with a list of Address objects if matches were found, or
     * calls result.error if no matches were found or there is no backend service available.
     *
     * @param address the address string for the search
     * @param placemarkMapper the method to use to convert the result into the desired format
     * @param result the result object to call with the result of the search
     */
    void placemarkFromAddress(String address, PlacemarkMapper placemarkMapper, Result result) {
        final Geocoder geocoder;
        try {
            geocoder = createGeocoder(androidContext, locale);
        } catch (Exception ex) {
            result.error(
                    "ERROR",
                    String.format("Geocoder could not be instantiated"),
                    null
            );
            return;
        }

        GeocodeListenerAdapter listenerAdapter = new GeocodeListenerAdapter() {
            @Override
            public void onGeocode(List<Address> list) {
                if (addresses == null || addresses.isEmpty()) {
                    result.error(
                            "NOT_FOUND",
                            String.format("No coordinates found for '%s'", address),
                            null);
                } else {
                    result.success(placemarkMapper.toHashMapList(addresses));
                }
            }

            @Override
            public void onError(String errorMessage) {
                result.error(
                        "IO_ERROR",
                        String.format("A network error occurred trying to lookup the address '%s': %s", address, errorMessage),
                        null
                );
            }
        };

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            // Use async API on Android 33+
            geocoder.getFromLocationName(address, 5, new Geocoder.GeocodeListener() {
                @Override
                public void onGeocode(List<Address> list) {
                    listenerAdapter.onGeocode(list);
                }

                @Override
                public void onError(String errorMessage) {
                    listenerAdapter.onError(errorMessage);
                }
            });
        } else {
            // Use deprecated sync API for Android 16-32
            try {
                listenerAdapter.onGeocode(geocoder.getFromLocationName(address, 5));
            } catch (IOException ex) {
                listenerAdapter.onError(ex.getMessage());
            }
        }
    }

    /**
     * Returns a list of Address objects matching the supplied coordinates.
     *
     * @param latitude the latitude point for the search
     * @param longitude the longitude point for the search
     * @param result the result object to call with the result of the search
     */
    void placemarkFromCoordinates(double latitude, double longitude, Result result) {
        final Geocoder geocoder;
        try {
            geocoder = createGeocoder(androidContext, locale);
        } catch (Exception ex) {
            result.error(
                    "ERROR",
                    String.format("Geocoder could not be instantiated"),
                    null
            );
            return;
        }

        GeocodeListenerAdapter listenerAdapter = new GeocodeListenerAdapter() {
            @Override
            public void onGeocode(List<Address> list) {
                if (addresses == null || addresses.isEmpty()) {
                    result.error(
                            "NOT_FOUND",
                            String.format(
                                    Locale.ENGLISH,
                                    "No address information found for supplied coordinates (latitude: %f, longitude: %f).",
                                    latitude,
                                    longitude
                            ),
                            null);
                } else {
                    result.success(placemarkMapper.toHashMapList(addresses));
                }
            }

            @Override
            public void onError(String errorMessage) {
                result.error(
                        "IO_ERROR",
                        String.format(
                                Locale.ENGLISH,
                                "A network error occurred trying to lookup the supplied coordinates (latitude: %f, longitude: %f).",
                                latitude,
                                longitude
                        ),
                        null
                );
            }
        };

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            // Use async API on Android 33+
            geocoder.getFromLocation(latitude, longitude, 5, new Geocoder.GeocodeListener() {
                @Override
                public void onGeocode(List<Address> list) {
                    listenerAdapter.onGeocode(list);
                }

                @Override
                public void onError(String errorMessage) {
                    listenerAdapter.onError(errorMessage);
                }
            });
        } else {
            // Use deprecated sync API for Android 16-32
            try {
                listenerAdapter.onGeocode(geocoder.getFromLocation(latitude, longitude, 5));
            } catch (IOException ex) {
                listenerAdapter.onError(ex.getMessage());
            }
        }
    }

    private static Geocoder createGeocoder(Context androidContext, @Nullable Locale locale) {
        return (locale != null)
                ? new Geocoder(androidContext, locale)
                : new Geocoder(androidContext);
    }
}
