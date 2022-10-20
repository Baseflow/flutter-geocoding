//
//  CLPlacemarkExtensions.swift
//  geocoding
//
//  Created by riccardo on 20/10/22.
//

import Foundation
import Contacts
import AddressBook
import CoreLocation

extension CLPlacemark {
    var toPlacemarkDictionary: Dictionary<String, Any> {
        var street: String = ""
        if #available(macOS 10.13, *) {
            if let postalAddress = self.postalAddress {
                street = postalAddress.street
            }
        } else if #available(macOS 10.8, *) {
            if let addressDictionary = self.addressDictionary {
                street = addressDictionary[AddressBook.kABAddressStreetKey] as? String ?? ""
            }
        }
        
        return [
            "name": self.name ?? "",
            "street": street,
            "isoCountryCode": self.isoCountryCode ?? "",
            "country": self.country ?? "",
            "thoroughfare": self.thoroughfare ?? "",
            "subThoroughfare": self.subThoroughfare ?? "",
            "postalCode": self.postalCode ?? "",
            "administrativeArea": self.administrativeArea ?? "",
            "subAdministrativeArea": self.subAdministrativeArea ?? "",
            "locality": self.locality ?? "",
            "subLocality": self.subLocality ?? "",
        ]
    }
    
    var toLocationDictionary: Dictionary<String, Any>? {
        guard let location = self.location else {
            return nil
        }
        
        return [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
            "timestamp": currentTimeInMilliSeconds(location.timestamp),
        ]
    }
    
    func currentTimeInMilliSeconds(_ dateToConvert: Date) -> Double {
        let since1970: TimeInterval = dateToConvert.timeIntervalSince1970
        return since1970 * 1000
    }
}
