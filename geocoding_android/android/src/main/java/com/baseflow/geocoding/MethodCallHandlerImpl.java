package com.baseflow.geocoding;

import android.location.Address;
import android.util.Log;

import androidx.annotation.Nullable;

import com.baseflow.geocoding.utils.AddressMapper;
import com.baseflow.geocoding.utils.LocaleConverter;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMethodCodec;

/**
 * Translates incoming Geocoding MethodCalls into well formed Java function calls for {@link
 * Geocoding}.
 */
final class MethodCallHandlerImpl implements MethodCallHandler {
    private static final String TAG = "MethodCallHandlerImpl";
    private final Geocoding geocoding;
    @Nullable
    private MethodChannel channel;

    /**
     * Forwards all incoming MethodChannel calls to the given {@code geocoding}.
     */
    MethodCallHandlerImpl(Geocoding geocoding) {
        this.geocoding = geocoding;
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        switch (call.method) {
            case "getFromLocation":
                getFromLocation(call, result);
                break;
            case "getFromLocationName":
                getFromLocationName(call, result);
                break;
            case "setLocale":
                setLocale(call, result);
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
        final BinaryMessenger.TaskQueue taskQueue = messenger.makeBackgroundTaskQueue();
        channel = new MethodChannel(messenger, "flutter.baseflow.com/geocoding_android", StandardMethodCodec.INSTANCE, taskQueue);
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

    private void getFromLocation(final MethodCall call, final Result result) {
        final double latitude = call.argument("latitude");
        final double longitude = call.argument("longitude");
        final int maxResults = call.argument("maxResults");

        try {
            final List<Address> addresses = geocoding.getFromLocation(
                    latitude,
                    longitude,
                    maxResults);
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

    private void getFromLocationName(MethodCall call, Result result) {
        final String address = call.argument("address");
        final int maxResults = call.argument("maxResults");

        Double lowerLeftLatitude = null;
        if (call.hasArgument("lowerLeftLatitude")) {
            lowerLeftLatitude = call.argument("lowerLeftLatitude");
        }

        Double lowerLeftLongitude = null;
        if (call.hasArgument("lowerLeftLongitude")) {
            lowerLeftLongitude = call.argument("lowerLeftLongitude");
        }

        Double upperRightLatitude = null;
        if (call.hasArgument("upperRightLatitude")) {
            upperRightLatitude = call.argument("upperRightLatitude");
        }

        Double upperRightLongitude = null;
        if (call.hasArgument("upperRightLongitude")) {
            upperRightLongitude = call.argument("upperRightLongitude");
        }

        if (address == null || address.isEmpty()) {
            result.error(
                    "ARGUMENT_ERROR",
                    "Supply a valid value for the 'address' parameter.",
                    null);
        }

        try {
            List<Address> addresses = null;

            if (lowerLeftLatitude == null) {
                addresses = geocoding.getFromLocationName(
                        address,
                        maxResults);
            } else {
                addresses = geocoding.getFromLocationName(
                        address,
                        maxResults,
                        lowerLeftLatitude,
                        lowerLeftLongitude,
                        upperRightLatitude,
                        upperRightLongitude);
            }

            if (addresses == null || addresses.isEmpty()) {
                result.error(
                        "NOT_FOUND",
                        String.format("No coordinates found for '%s'", address),
                        null);
                return;
            }

            result.success(AddressMapper.toAddressHashMapList(addresses));
        } catch (IOException ex) {
            result.error(
                    "IO_ERROR",
                    String.format("A network error occurred trying to lookup the address ''.", address),
                    null
            );
        }
    }
    
    private void setLocale(MethodCall call, Result result) {
        final String languageTag = call.argument("languageTag");

        if (languageTag == null) {
            result.error(
                "ARGUMENT_ERROR",
                "Supply a valid value for the 'languageTag' parameter.",
                null);
        }
        final Locale locale = LocaleConverter.fromLanguageTag(languageTag);
        if (locale == null) {
            result.error(
                "ARGUMENT_ERROR",
                "Supply a valid value for the 'languageTag' parameter.",
                null);
        }

        try {
            geocoding.setLocale(locale);

            result.success(null);
        } catch (IOException ex) {
            result.error(
                    "IO_ERROR",
                    String.format("A network error occurred trying to set the locale '%f'.", languageTag),
                    null
            );
        }
    }

    private void isPresent(MethodCall call, Result result) {
        final boolean present = geocoding.isPresent();

        result.success(present);
    }
}
