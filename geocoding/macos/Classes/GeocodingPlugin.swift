import Cocoa
import FlutterMacOS
import CoreLocation

public class GeocodingPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter.baseflow.com/geocoding", binaryMessenger: registrar.messenger)
        let instance = GeocodingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "locationFromAddress":
            if let args = call.arguments as? Dictionary<String, Any>, let address: String = args["address"] as? String {
                GeocodingHandler().geocodeFromAddress(
                    address: address,
                    locale: parseLocale(args),
                    success: { result(self.toLocationResult($0.placemarks)) },
                    failure: { result(FlutterError(code: $0.errorCode, message: $0.errorDescription, details: nil)) }
                )
            } else {
                result(FlutterError(code: "MISSING DATA", message: "Missing Address field", details: nil))
            }
        case "placemarkFromCoordinates":
            if let args = call.arguments as? Dictionary<String, Any>, let latitude = args["latitude"] as? NSNumber, let longitude = args["longitude"] as? NSNumber {
                let lat = CLLocationDegrees(latitude.doubleValue)
                let long = CLLocationDegrees(longitude.doubleValue)
                let location: CLLocation = CLLocation(latitude: lat, longitude: long)
                GeocodingHandler().geocodeToAddress(
                    location: location,
                    locale: parseLocale(args),
                    success: { result(self.toPlacemarkResult($0.placemarks)) },
                    failure: { result(FlutterError(code: $0.errorCode, message: $0.errorDescription, details: nil)) }
                )
            } else {
                result(FlutterError(code: "MISSING DATA", message: "Missing latitude or longitude fields", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func parseLocale(_ args: Dictionary<String, Any>) -> Locale? {
        
        guard let localeId: String = args["localeIdentifier"] as? String else {
            return nil
        }
        
        return Locale(identifier: localeId)
    }
    
    public func toLocationResult(_ placemarks: [CLPlacemark]) -> [Dictionary<String, Any>] {
        var result: [Dictionary<String, Any>] = []
        
        for placemark in placemarks {
            if let placeDict = placemark.toLocationDictionary {
                result.append(placeDict)
            }
        }
        
        return result
    }
    
    public func toPlacemarkResult(_ placemarks: [CLPlacemark]) -> [Dictionary<String, Any>] {
        var result: [Dictionary<String, Any>] = []
        
        for placemark in placemarks {
            result.append(placemark.toPlacemarkDictionary)
        }
        
        return result
    }
    
}
