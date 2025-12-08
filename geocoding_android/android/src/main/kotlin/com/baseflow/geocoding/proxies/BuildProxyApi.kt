package com.baseflow.geocoding.proxies

import android.os.Build
import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.PigeonApiBuild

/**
 * ProxyApi implementation for {@link Build}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class BuildProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) : PigeonApiBuild(pigeonRegistrar) {
    override fun getSdkVersion(): Long {
        return Build.VERSION.SDK_INT.toLong();
    }
}