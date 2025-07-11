import CoreLocation

/// ProxyApi implementation for `CLLocationSourceInformation`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLLocationSourceInformationProxyApiDelegate: PigeonApiDelegateCLLocationSourceInformation {
    @available(iOS 15.0, macOS 12.0, *)
    func isProducedByAccessory(pigeonApi: PigeonApiCLLocationSourceInformation, pigeonInstance: CLLocationSourceInformation) throws -> Bool {
        return pigeonInstance.isProducedByAccessory
    }
    
    @available(iOS 15.0, macOS 12.0, *)
    func isSimulatedBySoftware(pigeonApi: PigeonApiCLLocationSourceInformation, pigeonInstance: CLLocationSourceInformation) throws -> Bool {
        return pigeonInstance.isSimulatedBySoftware
    }
}
