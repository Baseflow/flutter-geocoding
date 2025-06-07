package com.baseflow.geocoding;

import android.location.Address;
import android.os.AsyncTask;
import android.util.Log;
import androidx.annotation.Nullable;

import com.baseflow.geocoding.utils.AddressMapper;
import com.baseflow.geocoding.utils.LocaleConverter;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.io.IOException;
import java.util.List;

/**
 * Translates incoming Geocoding MethodCalls into well formed Java function calls for {@link
 * Geocoding}.
 */
final class MethodCallHandlerImpl implements MethodCallHandler {
    private static final String TAG = "MethodCallHandlerImpl";
    private final Geocoding geocoding;
    @Nullable private MethodChannel channel;

    /** Forwards all incoming MethodChannel calls to the given {@code geocoding}. */
    MethodCallHandlerImpl(Geocoding geocoding) {
        this.geocoding = geocoding;
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        switch (call.method) {
            case "locationFromAddress":
                AsyncTask.execute(new Runnable() {
                    @Override
                    public void run() {
                        onLocationFromAddress(call, result);
                    }
                });
                break;
            case "placemarkFromCoordinates":
                AsyncTask.execute(new Runnable() {
                    @Override
                    public void run() {
                        onPlacemarkFromCoordinates(call, result);
                    }
                });
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * Registers this instance as a method call handler on the given {@code messenger}.
     *
     * <p>Stops any previously started and unstopped calls.
     *
     * <p>This should be cleaned with {@link #stopListening} once the messenger is disposed of.
     */
    void startListening(BinaryMessenger messenger) {
        if (channel != null) {
            Log.wtf(TAG, "Setting a method call handler before the last was disposed.");
            stopListening();
        }

        channel = new MethodChannel(messenger, "flutter.baseflow.com/geocoding");
        channel.setMethodCallHandler(this);
    }

    /**
     * Clears this instance from listening to method calls.
     *
     * <p>Does nothing if {@link #startListening} hasn't been called, or if we're already stopped.
     */
    void stopListening() {
        if (channel == null) {
            Log.d(TAG, "Tried to stop listening when no MethodChannel had been initialized.");
            return;
        }

        channel.setMethodCallHandler(null);
        channel = null;
    }

    // Parses a string as a double and returns the parsed value.
    // If parsing is not possible or fails, returns null.
    private static Double parseDoubleOrReturnNull(final String _string){
        try{
            return Double.parseDouble(_string);
        }catch (Throwable t){
            return null;
        }
    }

    private void onLocationFromAddress(MethodCall call, Result result) {
        final String address = call.argument("address");
        final String languageTag = call.argument("localeIdentifier");
        final String targetRegionSLat = call.argument("targetRegionSLat");
        final String targetRegionNLat = call.argument("targetRegionNLat");
        final String targetRegionWLng = call.argument("targetRegionWLng");
        final String targetRegionELng = call.argument("targetRegionELng");

        if (address == null || address.isEmpty()) {
            result.error(
                    "ARGUMENT_ERROR",
                    "Supply a valid value for the 'address' parameter.",
                    null);
        }

        try {
            final List<Address> addresses = geocoding.placemarkFromAddress(
                    address,
                    LocaleConverter.fromLanguageTag(languageTag),
                    parseDoubleOrReturnNull(targetRegionSLat), // lowerLeftLatitude,
                    parseDoubleOrReturnNull(targetRegionWLng), // lowerLeftLongitude,
                    parseDoubleOrReturnNull(targetRegionNLat), // upperRightLatitude,
                    parseDoubleOrReturnNull(targetRegionELng) // upperRightLongitude
            );

            if (addresses == null || addresses.isEmpty()) {
                result.error(
                        "NOT_FOUND",
                        String.format("No coordinates found for '%s'", address),
                        null);
                return;
            }

            result.success(AddressMapper.toLocationHashMapList(addresses));
        } catch (IOException ex) {
            result.error(
                    "IO_ERROR",
                    String.format("A network error occurred trying to lookup the address ''.", address),
                    null
            );
        }
    }

    private void onPlacemarkFromCoordinates(MethodCall call, Result result) {
        final double latitude = call.argument("latitude");
        final double longitude = call.argument("longitude");
        final String languageTag = call.argument("localeIdentifier");

        try {
            final List<Address> addresses = geocoding.placemarkFromCoordinates(
                    latitude,
                    longitude,
                    LocaleConverter.fromLanguageTag(languageTag));

            if (addresses == null || addresses.isEmpty()) {
                result.error(
                        "NOT_FOUND",
                        String.format("No address information found for supplied coordinates (latitude: %f, longitude: %f).", latitude, longitude),
                        null);
                return;
            }

            result.success(AddressMapper.toAddressHashMapList(addresses));
        } catch (IOException ex) {
            result.error(
                    "IO_ERROR",
                    String.format("A network error occurred trying to lookup the supplied coordinates (latitude: %f, longitude: %f).", latitude, longitude),
                    null
            );
        }
    }
}