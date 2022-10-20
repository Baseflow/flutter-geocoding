//
//  GeocodingHandler.swift
//  geocoding
//
//  Created by riccardo on 20/10/22.
//

import Foundation
import CoreLocation

struct GeocodingSuccess {
    var placemarks: [CLPlacemark]
}

struct GeocodingFailure {
    var errorCode: String
    var errorDescription: String
}

class GeocodingHandler {
    var _geocoder: CLGeocoder
    
    init() {
        self._geocoder = CLGeocoder()
    }
    
    func geocodeFromAddress(address: String?, locale: Locale?, success successHandler: @escaping (GeocodingSuccess) -> Void, failure failureHandler: @escaping (GeocodingFailure) -> Void) {
        guard let address = address, !address.isEmpty else {
            failureHandler(GeocodingFailure(errorCode: "ARGUMENT_ERROR", errorDescription: "Please supply a valid string containing the address to lookup"))
            return;
        }
        if #available(macOS 10.13, *) {
            _geocoder.geocodeAddressString(
                address,
                in: nil,
                preferredLocale: locale
            ) { placemarks, error in
                self.completeGeocodingWith(placemarks: placemarks, error: error, success: successHandler, failure: failureHandler)
            }
        } else {
            var defaultLanguages: [String] = []
            if let locale = locale {
                defaultLanguages = UserDefaults.standard.array(forKey: "AppleLanguages") as? [String] ?? []
                UserDefaults.standard.setValue(languageCode(locale: locale), forKey: "AppleLanguages")
            }
            
            _geocoder.geocodeAddressString(address) { placemarks, error in
                self.completeGeocodingWith(placemarks: placemarks, error: error, success: successHandler, failure: failureHandler)
                if let _ = locale {
                    UserDefaults.standard.setValue(defaultLanguages, forKey: "AppleLanguages")
                }
            }
        }
    }
    
    func geocodeToAddress(location: CLLocation, locale: Locale?, success successHandler: @escaping (GeocodingSuccess) -> Void, failure failureHandler: @escaping (GeocodingFailure) -> Void) {
        
        if #available(macOS 10.13, *) {
            _geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
                self.completeGeocodingWith(placemarks: placemarks, error: error, success: successHandler, failure: failureHandler)
            }
        } else {
            var defaultLanguages: [String] = []
            if let locale = locale {
                defaultLanguages = UserDefaults.standard.array(forKey: "AppleLanguages") as? [String] ?? []
                UserDefaults.standard.setValue(languageCode(locale: locale), forKey: "AppleLanguages")
            }
            
            _geocoder.reverseGeocodeLocation(location) { placemarks, error in
                self.completeGeocodingWith(placemarks: placemarks, error: error, success: successHandler, failure: failureHandler)
                if let _ = locale {
                    UserDefaults.standard.setValue(defaultLanguages, forKey: "AppleLanguages")
                }
            }
        }
    }
    
    func completeGeocodingWith(placemarks: [CLPlacemark]?, error: Error?, success successHandler: @escaping (GeocodingSuccess) -> Void, failure failureHandler: @escaping (GeocodingFailure) -> Void) {
        if let error = error {
            if let clError = (error as? CLError), clError.code == CLError.Code.geocodeFoundNoResult {
                failureHandler(GeocodingFailure(errorCode: "NOT_FOUND", errorDescription: "Could not find any result for the supplied address or coordinates."))
            } else {
                failureHandler(GeocodingFailure(errorCode: "IO_ERROR", errorDescription: error.localizedDescription))
            }
        } else if placemarks == nil {
            failureHandler(GeocodingFailure(errorCode: "NOT_FOUND", errorDescription: "Could not find any result for the supplied address or coordinates."))
        } else {
            successHandler(GeocodingSuccess(placemarks: placemarks!))
        }
    }
    
    func languageCode(locale: Locale) -> String? {
        if #available(macOS 10.12, *) {
            return locale.languageCode
        } else {
            let localeString = locale.identifier
            let index = localeString.index(localeString.startIndex, offsetBy: 2)
            let subString = localeString[..<index]
            return String(subString)
        }
    }
}
