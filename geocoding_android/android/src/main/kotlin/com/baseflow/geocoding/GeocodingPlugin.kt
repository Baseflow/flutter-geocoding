package com.baseflow.geocoding

import androidx.annotation.VisibleForTesting
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

/**
 * Platform implementation of the geocoding plugin implemented with the Geocoder SDK.
 */
class GeocodingPlugin : FlutterPlugin {
    @VisibleForTesting
    var proxyApiRegistrar: ProxyApiRegistrar? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        proxyApiRegistrar =
            ProxyApiRegistrar(
                binding.binaryMessenger,
                binding.applicationContext
            )
        proxyApiRegistrar!!.setUp()
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        if (proxyApiRegistrar != null) {
            proxyApiRegistrar!!.ignoreCallsToDart = true
            proxyApiRegistrar!!.tearDown()
            proxyApiRegistrar!!.instanceManager.stopFinalizationListener()
            proxyApiRegistrar = null
        }
    }
}
