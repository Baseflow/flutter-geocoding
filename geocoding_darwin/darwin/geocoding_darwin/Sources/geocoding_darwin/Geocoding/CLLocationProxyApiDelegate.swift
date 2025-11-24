import CoreLocation

/// ProxyApi implementation for `CLLocation`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class CLLocationProxyApiDelegate: PigeonApiDelegateCLLocation {
    func pigeonDefaultConstructor(pigeonApi: PigeonApiCLLocation, latitude: Double, longitude: Double) throws -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getCoordinate(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> CLLocationCoordinate2DWrapper {
        return CLLocationCoordinate2DWrapper(pigeonInstance.coordinate)
    }
    
    func getAltitude(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.altitude
    }
    
    func getEllipsoidalAltitude(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        if #available(iOS 15.0, macOS 12.0, *) {
            return pigeonInstance.ellipsoidalAltitude
        } else {
            throw (pigeonApi.pigeonRegistrar as! ProxyApiRegistrar).createUnsupportedVersionError(
                method: "CLLocation.ellipsoidalAltitude",
                versionRequirements: "iOS 15.0, macOS 12.0")
        }
    }
    
    func getFloor(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> CLFloor? {
        return pigeonInstance.floor
    }
    
    func getTimestamp(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Int64 {
        return Int64(pigeonInstance.timestamp.timeIntervalSince1970 * 1000)
    }
    
    @available(iOS 15.0, macOS 12.0, *)
    func getSourceInformation(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> CLLocationSourceInformation? {
        return pigeonInstance.sourceInformation
    }
    
    func getHorizontalAccuracy(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.horizontalAccuracy
    }
    
    func getVerticalAccuracy(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.verticalAccuracy
    }
    
    func getSpeed(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.speed
    }
    
    func getSpeedAccuracy(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.speedAccuracy
    }
    
    func getCourse(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        return pigeonInstance.course
    }
    
    func getCourseAccuracy(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation) throws -> Double {
        if #available(iOS 13.4, macOS 10.15.4, *) {
            return pigeonInstance.courseAccuracy
        } else {
            throw (pigeonApi.pigeonRegistrar as! ProxyApiRegistrar).createUnsupportedVersionError(
                method: "CLLocation.sourceInformation",
                versionRequirements: "iOS 13.4, macOS 10.15.4")
        }
    }
    
    func distance(pigeonApi: PigeonApiCLLocation, pigeonInstance: CLLocation, from: CLLocation) throws -> Double {
        return pigeonInstance.distance(from: from)
    }
}
