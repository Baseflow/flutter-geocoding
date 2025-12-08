package com.baseflow.geocoding.proxies

import android.location.Address
import android.location.Geocoder
import android.os.Build
import androidx.annotation.RequiresApi
import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.PigeonApiGeocodeListener
import com.baseflow.geocoding.ProxyApiRegistrar

/**
 * ProxyApi implementation for {@link GeocodeListener}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
@RequiresApi(Build.VERSION_CODES.TIRAMISU)
class GeocodeListenerProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) :
    PigeonApiGeocodeListener(pigeonRegistrar) {

    override val pigeonRegistrar: ProxyApiRegistrar
        get() = super.pigeonRegistrar as ProxyApiRegistrar

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    override fun pigeon_defaultConstructor(): Geocoder.GeocodeListener {
        return GeocodeListenerImpl(this);
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    class GeocodeListenerImpl(val api: GeocodeListenerProxyApi) : Geocoder.GeocodeListener {
        override fun onGeocode(addresses: List<Address?>) {
            api.pigeonRegistrar.runOnMainThread { api.onGeocode(this, addresses) { null } };
        }

        override fun onError(errorMessage: String?) {
            api.pigeonRegistrar.runOnMainThread { api.onError(this, errorMessage) { null } };
        }
    }

}