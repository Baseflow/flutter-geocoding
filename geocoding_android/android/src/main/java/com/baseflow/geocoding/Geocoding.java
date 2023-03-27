package com.baseflow.geocoding;

import android.content.Context;
import android.location.Address;
import android.location.Geocoder;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

/** Geocoding components to lookup address or coordinates. */
class Geocoding {
    private Geocoder geocoder;
    private Locale locale;
    private final Context androidContext;

    /**
     * Uses the given {@code androidContext} to execute geocoding features
     *
     * @param androidContext the context to use when requesting geocoding features
     */
    Geocoding(Context androidContext) {
        this.androidContext = androidContext;
        this.createGeocoder();
    }

    /**
     * Returns a list of Address objects matching the supplied coordinates.
     *
     * @param latitude the latitude point for the search
     * @param longitude the longitude point for the search
     * @param maxResults the max amount of results
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> getFromLocation(
            double latitude,
            double longitude,
            int maxResults) throws IOException {
        return geocoder.getFromLocation(latitude, longitude, maxResults);
    }

    /**
     * Returns a list of Address objects matching the supplied address string.
     *
     * @param address the address string for the search
     * @param maxResults the desired amount of max results
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws java.io.IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> getFromLocationName(String address, int maxResults) throws IOException {
        return geocoder.getFromLocationName(address, maxResults);
    }

    /**
     * Returns a list of Address objects matching the supplied address string.
     *
     * @param locationName the address string for the search
     * @param maxResults the desired amount of max results
     * @param lowerLeftLatitude the latitude of the lower left corner of the bounding box Value is between -90D and 90D inclusive
     * @param lowerLeftLongitude the longitude of the lower left corner of the bounding box Value is between -180D and 180D inclusive
     * @param upperRightLatitude the latitude of the upper right corner of the bounding box Value is between -90D and 90D inclusive
     * @param upperRightLongitude the longitude of the upper right corner of the bounding box Value is between -180D and 180D inclusive
     * @return a list of Address objects. Returns null or empty list if no matches were found or there is no backend service available.
     * @throws java.io.IOException if the network is unavailable or any other I/O problem occurs.
     */
    List<Address> getFromLocationName(
        String locationName, 
        int maxResults, 
        double lowerLeftLatitude, 
        double lowerLeftLongitude, 
        double upperRightLatitude, 
        double upperRightLongitude) throws IOException {
        return geocoder.getFromLocationName(
            locationName, 
            maxResults, 
            lowerLeftLatitude, 
            lowerLeftLongitude, 
            upperRightLatitude, 
            upperRightLongitude);
    }

    /**
     * Returns true if there is a geocoder implementation present that may return results.
     *
     * @return a bool indicating the status.
     */
    boolean isPresent() {
        return geocoder.isPresent();
    }

    /**
     * Sets the locale used for geocoding.
     *
     * @param locale the desired locale for the geocoder
     * @throws IOException if the geocoder is unavailable.
     */
    void setLocale(Locale locale) throws IOException {
        this.locale = locale;
        createGeocoder();
    }

    private void createGeocoder() {
        this.geocoder = (locale != null)
                ? new Geocoder(androidContext, locale)
                : new Geocoder(androidContext);
    }
}
