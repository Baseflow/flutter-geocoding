import Contacts

/// ProxyApi implementation for `CNPostalAddress`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CNPostalAddressProxyApiDelegate: PigeonApiDelegateCNPostalAddress {
    func street(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.street
    }
    
    func city(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.city
    }
    
    func state(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.state
    }
    
    func postalCode(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.postalCode
    }
    
    func country(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.country
    }
    
    func isoCountryCode(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.isoCountryCode
    }
    
    func subAdministrativeArea(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.subAdministrativeArea
    }
    
    func subLocality(pigeonApi: PigeonApiCNPostalAddress, pigeonInstance: CNPostalAddress) throws -> String {
        return pigeonInstance.subLocality
    }
}
