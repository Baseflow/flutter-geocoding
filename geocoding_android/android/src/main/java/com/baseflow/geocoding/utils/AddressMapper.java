package com.baseflow.geocoding.utils;

import android.location.Address;
import android.util.Log;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

public class AddressMapper {

    public static List<Map<String, Object>> toAddressHashMapList(List<Address> addresses) {
        List<Map<String, Object>> hashMaps = new ArrayList<>(addresses.size());

        for (Address address : addresses) {
            Map<String, Object> hashMap = AddressMapper.toAddressHashMap(address);
            hashMaps.add(hashMap);
        }

        return hashMaps;
    }

    private static Map<String, Object> toAddressHashMap(Address address) {
        Map<String, Object> mappedAddress = new HashMap<>();

        final List<String> addressLineArray = new ArrayList<>(address.getMaxAddressLineIndex());
        for (int i = 0; i <= address.getMaxAddressLineIndex(); i++) {
            addressLineArray.add(address.getAddressLine(i));
            Log.w("APP", address.getAddressLine(i));
        }
        mappedAddress.put("addressLine", addressLineArray);
        mappedAddress.put("adminArea", address.getAdminArea());
        mappedAddress.put("countryCode", address.getCountryCode());
        mappedAddress.put("countryName", address.getCountryName());
        mappedAddress.put("featureName", address.getFeatureName());
        mappedAddress.put("latitude", address.getLatitude());
        mappedAddress.put("locale", address.getLocale().toLanguageTag());
        mappedAddress.put("locality", address.getLocality());
        mappedAddress.put("longitude", address.getLongitude());
        mappedAddress.put("phone", address.getPhone());
        mappedAddress.put("postalCode", address.getPostalCode());
        mappedAddress.put("premises", address.getPremises());
        mappedAddress.put("subAdminArea", address.getSubAdminArea());
        mappedAddress.put("subLocality", address.getSubLocality());
        mappedAddress.put("subThoroughfare", address.getSubThoroughfare());
        mappedAddress.put("thoroughfare", address.getThoroughfare());
        mappedAddress.put("url", address.getUrl());

        return mappedAddress;
    }
}
