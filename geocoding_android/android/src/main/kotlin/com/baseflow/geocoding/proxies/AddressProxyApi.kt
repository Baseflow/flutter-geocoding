package com.baseflow.geocoding.proxies

import android.location.Address
import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.PigeonApiAddress
import java.util.Locale

/**
 * ProxyApi implementation for {@link Address}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class AddressProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) :
    PigeonApiAddress(pigeonRegistrar) {
    override fun getAddressLine(pigeon_instance: Address, index: Long): String? {
        return pigeon_instance.getAddressLine(index.toInt());
    }

    override fun getAdminArea(pigeon_instance: Address): String? {
        return pigeon_instance.adminArea;
    }

    override fun getCountryCode(pigeon_instance: Address): String? {
        return pigeon_instance.countryCode;
    }

    override fun getCountryName(pigeon_instance: Address): String? {
        return pigeon_instance.countryName;
    }

    override fun getFeatureName(pigeon_instance: Address): String? {
        return pigeon_instance.featureName;
    }

    override fun getLatitude(pigeon_instance: Address): Double? {
        return pigeon_instance.latitude;
    }

    override fun getLocale(pigeon_instance: Address): Locale {
        return pigeon_instance.locale;
    }

    override fun getLocality(pigeon_instance: Address): String? {
        return pigeon_instance.locality;
    }

    override fun getLongitude(pigeon_instance: Address): Double? {
        return pigeon_instance.longitude;
    }

    override fun getMaxAddressLineIndex(pigeon_instance: Address): Long {
        return pigeon_instance.maxAddressLineIndex.toLong();
    }

    override fun getPhone(pigeon_instance: Address): String? {
        return pigeon_instance.phone;
    }

    override fun getPostalCode(pigeon_instance: Address): String? {
        return pigeon_instance.postalCode;
    }

    override fun getPremises(pigeon_instance: Address): String? {
        return pigeon_instance.premises;
    }

    override fun getSubAdminArea(pigeon_instance: Address): String? {
        return pigeon_instance.subAdminArea;
    }

    override fun getSubLocality(pigeon_instance: Address): String? {
        return pigeon_instance.subLocality;
    }

    override fun getSubThouroughfare(pigeon_instance: Address): String? {
        return pigeon_instance.subThoroughfare;
    }

    override fun getThouroughfare(pigeon_instance: Address): String? {
        return pigeon_instance.thoroughfare;
    }

    override fun getUrl(pigeon_instance: Address): String? {
        return pigeon_instance.url;
    }

    override fun hasLatitude(pigeon_instance: Address): Boolean {
        return pigeon_instance.hasLatitude();
    }

    override fun hasLongitude(pigeon_instance: Address): Boolean {
        return pigeon_instance.hasLongitude();
    }
}