import CoreLocation

/// ProxyApi implementation for `CLLocationCoordinate2D`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLLocationCoordinate2DProxyApiDelegate: PigeonApiDelegateCLLocationCoordinate2D {
    func latitude(pigeonApi: PigeonApiCLLocationCoordinate2D, pigeonInstance: CLLocationCoordinate2DWrapper) throws
    -> Double {
        return pigeonInstance.value.latitude
    }
    
    func longitude(pigeonApi: PigeonApiCLLocationCoordinate2D, pigeonInstance: CLLocationCoordinate2DWrapper) throws
    -> Double {
        return pigeonInstance.value.longitude
    }
}
