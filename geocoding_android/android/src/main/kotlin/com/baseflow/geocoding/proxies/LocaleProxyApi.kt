package com.baseflow.geocoding.proxies

import com.baseflow.geocoding.AndroidGeocoderLibraryPigeonProxyApiRegistrar
import com.baseflow.geocoding.PigeonApiLocale
import java.util.Locale

/**
 * ProxyApi implementation for {@link Locale}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class LocaleProxyApi(pigeonRegistrar: AndroidGeocoderLibraryPigeonProxyApiRegistrar) :
    PigeonApiLocale(pigeonRegistrar) {
    override fun pigeon_defaultConstructor(
        identifier: String
    ): Locale {
        return Locale.forLanguageTag(identifier);
    }

    override fun getCountry(pigeon_instance: Locale): String {
        return pigeon_instance.country;
    }

    override fun getISO3Country(pigeon_instance: Locale): String {
        return pigeon_instance.isO3Country;
    }

    override fun getISO3Language(pigeon_instance: Locale): String {
        return pigeon_instance.isO3Language;
    }

    override fun getLanguage(pigeon_instance: Locale): String {
        return pigeon_instance.language;
    }

    override fun getScript(pigeon_instance: Locale): String {
        return pigeon_instance.script;
    }

    override fun getVariant(pigeon_instance: Locale): String {
        return pigeon_instance.variant;
    }
}