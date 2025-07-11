import CoreLocation
import Contacts

/// ProxyApi implementation for `CLGeocoder`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLGeocoderProxyApiDelegate: PigeonApiDelegateCLGeocoder {
    func pigeonDefaultConstructor(pigeonApi: PigeonApiCLGeocoder) throws -> CLGeocoder {
        return CLGeocoder()
    }
    
    func geocodeAddressString(pigeonApi: PigeonApiCLGeocoder, pigeonInstance: CLGeocoder, address: String, locale: LocaleWrapper?, completion: @escaping (Result<[CLPlacemark]?, any Error>) -> Void) {
        pigeonInstance.geocodeAddressString(address, in: nil, preferredLocale: locale?.value) { placemarks, error in
            if error != nil {
                let error = PigeonError(code: "GeocodeAddressError", message: "Failed to geocode address.", details: error! as NSError)
                completion(.failure(error))
                return
            }
            
            completion(.success(placemarks))
        }
    }
    
    func geocodePostalAddress(pigeonApi: PigeonApiCLGeocoder, pigeonInstance: CLGeocoder, postalAddress: CNPostalAddress, locale: LocaleWrapper?, completion: @escaping (Result<[CLPlacemark]?, any Error>) -> Void) {
        pigeonInstance.geocodePostalAddress(postalAddress, preferredLocale: locale?.value) { placemarks, error in
            if error != nil {
                let error = PigeonError(code: "GeocodeAddressError", message: "Failed to geocode address.", details: error! as NSError)
                completion(.failure(error))
                return
            }
            
            completion(.success(placemarks))
        }
    }
    
    func reverseGeocodeLocation(pigeonApi: PigeonApiCLGeocoder, pigeonInstance: CLGeocoder, location: CLLocation, locale: LocaleWrapper?, completion: @escaping (Result<[CLPlacemark]?, any Error>) -> Void) {
        pigeonInstance.reverseGeocodeLocation(location, preferredLocale: locale?.value) { placemarks, error in
            if error != nil {
                let error = PigeonError(code: "GeocodeAddressError", message: "Failed to geocode address.", details: error! as NSError)
                completion(.failure(error))
                return
            }
            
            completion(.success(placemarks))
        }
    }
}
