package com.baseflow.geocoding

import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.annotation.ChecksSdkIntAtLeast
import androidx.annotation.RequiresApi
import com.baseflow.geocoding.proxies.AddressProxyApi
import com.baseflow.geocoding.proxies.BuildProxyApi
import com.baseflow.geocoding.proxies.GeocodeListenerProxyApi
import com.baseflow.geocoding.proxies.GeocoderProxyApi
import com.baseflow.geocoding.proxies.GeographicBoundsProxyApi
import com.baseflow.geocoding.proxies.LocaleProxyApi
import io.flutter.plugin.common.BinaryMessenger


class ProxyApiRegistrar(binaryMessenger: BinaryMessenger, val context: Context) :
    AndroidGeocoderLibraryPigeonProxyApiRegistrar(binaryMessenger) {

    // Added to be overridden for tests. The test implementation calls `callback` immediately, instead
    // of waiting for the main thread to run it.
    fun runOnMainThread(runnable: Runnable) {
        Handler(Looper.getMainLooper()).post(runnable);
    }

    override fun getPigeonApiAddress(): PigeonApiAddress {
        return AddressProxyApi(this);
    }

    override fun getPigeonApiGeographicBounds(): PigeonApiGeographicBounds {
        return GeographicBoundsProxyApi(this);
    }

    override fun getPigeonApiBuild(): PigeonApiBuild {
        return BuildProxyApi(this);
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun getPigeonApiGeocodeListener(): PigeonApiGeocodeListener {
        return GeocodeListenerProxyApi(this);
    }

    override fun getPigeonApiGeocoder(): PigeonApiGeocoder {
        return GeocoderProxyApi(this);
    }

    override fun getPigeonApiLocale(): PigeonApiLocale {
        return LocaleProxyApi(this);
    }

}