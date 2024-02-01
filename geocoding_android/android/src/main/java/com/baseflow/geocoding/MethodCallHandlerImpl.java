package com.baseflow.geocoding;

import android.location.Address;
import android.util.Log;

import androidx.annotation.NonNull;
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
    public void onMethodCall(
            final MethodCall call,
            @NonNull final Result result
    ) {
        switch (call.method) {
            case "setLocaleIdentifier":
                setLocaleIdentifier(call, result);
                break;
            case "locationFromAddress":
                onLocationFromAddress(call, result);
                break;
            case "placemarkFromAddress":
                onPlacemarkFromAddress(call, result);
                break;
            case "placemarkFromCoordinates":
                onPlacemarkFromCoordinates(call, result);
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
        channel = new MethodChannel(messenger, "flutter.baseflow.com/geocoding", StandardMethodCodec.INSTANCE, taskQueue);
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

    private void setLocaleIdentifier(MethodCall call, Result result) {
        final String languageTag = call.argument("localeIdentifier");

        geocoding.setLocaleIdentifier(LocaleConverter.fromLanguageTag(languageTag));

        result.success(true);
    }

    private void onLocationFromAddress(MethodCall call, Result result) {
        final String address = call.argument("address");

        if (address == null || address.isEmpty()) {
            result.error(
                    "ARGUMENT_ERROR",
                    "Supply a valid value for the 'address' parameter.",
                    null);
        }

        geocoding.placemarkFromAddress(address, new GeocodeListenerAdapter() {

            @Override
            public void onGeocode(List<Address> addresses) {
                if (addresses != null && addresses.size() > 0) {
                    result.success(AddressMapper.toLocationHashMapList(addresses));
                } else {
                    result.error(
                            "NOT_FOUND",
                            String.format("No coordinates found for '%s'", address),
                            null);
                }
            }

            @Override
            public void onError(String errorMessage) {
                result.error(
                        "IO_ERROR",
                        String.format(errorMessage),
                        null);
            }
        });
    }

    private void onPlacemarkFromAddress(final MethodCall call, final Result result) {
        final String address = call.argument("address");

        if (address == null || address.isEmpty()) {
            result.error(
                    "ARGUMENT_ERROR",
                    "Supply a valid value for the 'address' parameter.",
                    null);
        }

        geocoding.placemarkFromAddress(address, new GeocodeListenerAdapter() {

            @Override
            public void onGeocode(List<Address> addresses) {
                if (addresses != null && addresses.size() > 0) {
                    result.success(AddressMapper.toAddressHashMapList(addresses));
                } else {
                    result.error(
                            "NOT_FOUND",
                            String.format("No coordinates found for '%s'", address),
                            null);
                }
            }

            @Override
            public void onError(String errorMessage) {
                result.error(
                        "IO_ERROR",
                        String.format(errorMessage),
                        null);
            }
        });
    }

    private void onPlacemarkFromCoordinates(final MethodCall call, final Result result) {
        final double latitude = call.argument("latitude");
        final double longitude = call.argument("longitude");

        geocoding.placemarkFromCoordinates(
                latitude,
                longitude, new GeocodeListenerAdapter() {

                    @Override
                    public void onGeocode(List<Address> addresses) {
                        if (addresses != null && addresses.size() > 0) {
                            result.success(AddressMapper.toAddressHashMapList(addresses));
                        } else {
                            result.error(
                                    "NOT_FOUND",
                                    String.format(
                                            Locale.ENGLISH,
                                            "No address information found for supplied coordinates (latitude: %f, longitude: %f).",
                                            latitude,
                                            longitude
                                    ),
                                    null);
                        }
                    }

                    @Override
                    public void onError(String errorMessage) {
                        result.error(
                                "IO_ERROR",
                                String.format(errorMessage),
                                null);
                    }
                });
    }
}
