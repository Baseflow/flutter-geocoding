package com.baseflow.geocoding;

import android.location.Address;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

public interface GeocodeListenerAdapter {
    void onGeocode(@Nullable List<Address> addresses);
    void onError(@Nullable String errorMessage);
}