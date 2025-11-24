import CoreLocation

/// ProxyApi implementation for `CLFloor`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLFloorProxyApiDelegate: PigeonApiDelegateCLFloor {
    func level(pigeonApi: PigeonApiCLFloor, pigeonInstance: CLFloor) throws -> Int64 {
        return Int64(pigeonInstance.level)
    }
}
