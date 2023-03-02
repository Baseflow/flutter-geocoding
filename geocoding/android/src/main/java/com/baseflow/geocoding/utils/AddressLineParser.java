package com.baseflow.geocoding.utils;

import java.util.StringTokenizer;

public class AddressLineParser {
    private final static String ADDRESS_LINE_DELIMITER = ",";

    public static String getStreet(String addressLine) {
        if(addressLine == null || addressLine.isEmpty()) {
            return null;
        }

        StringTokenizer tokenizer = new StringTokenizer(addressLine, ADDRESS_LINE_DELIMITER, false);

        if(tokenizer.hasMoreTokens()) {
            return tokenizer.nextToken();
        }

        return null;
    }
}
