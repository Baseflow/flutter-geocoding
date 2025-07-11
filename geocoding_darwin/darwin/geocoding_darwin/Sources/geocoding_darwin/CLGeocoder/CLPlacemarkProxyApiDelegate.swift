import CoreLocation
import Contacts

/// ProxyApi implementation for `CLPlacemark`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLPlacemarkProxyApiDelegate: PigeonApiDelegateCLPlacemark {
    
    func location(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> CLLocation? {
        return pigeonInstance.location
    }
    
    func name(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.name
    }
    
    func thoroughfare(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.thoroughfare
    }
    
    func subThoroughfare(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.subThoroughfare
    }
    
    func locality(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.locality
    }
    
    func subLocality(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.subLocality
    }
    
    func administrativeArea(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        pigeonInstance.administrativeArea
    }
    
    func subAdministrativeArea(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.subAdministrativeArea
    }
    
    func postalCode(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.postalCode
    }
    
    func isoCountryCode(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.isoCountryCode
    }
    
    func country(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> String? {
        return pigeonInstance.country
    }
    
    func postalAddress(pigeonApi: PigeonApiCLPlacemark, pigeonInstance: CLPlacemark) throws -> CNPostalAddress? {
        return pigeonInstance.postalAddress
    }
    
}
