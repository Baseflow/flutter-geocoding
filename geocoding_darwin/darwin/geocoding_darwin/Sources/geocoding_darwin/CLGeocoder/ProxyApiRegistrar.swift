import Foundation

#if os(iOS)
  import Flutter
  import UIKit
#elseif os(macOS)
  import FlutterMacOS
  import Foundation
#else
  #error("Unsupported platform.")
#endif

/// Implementation of the `CLGeocoderLibraryPigeonProxyApiRegistrar` that provides any addition resources needed by API implementations.
open class ProxyApiRegistrar: CLGeocoderLibraryPigeonProxyApiRegistrar {
    init(
        binaryMessenger: FlutterBinaryMessenger
    ) {
        super.init(binaryMessenger: binaryMessenger, apiDelegate: ProxyApiDelegate())
    }
    
    /// Creates an error when a method is called on an unsupported version.
    func createUnsupportedVersionError(method: String, versionRequirements: String) -> PigeonError {
      return PigeonError(
        code: "FWFUnsupportedVersionError",
        message: createUnsupportedVersionMessage(method, versionRequirements: versionRequirements),
        details: nil)
    }

    /// Creates the error message when a method is called on an unsupported version.
    func createUnsupportedVersionMessage(_ method: String, versionRequirements: String) -> String {
      return "`\(method)` requires \(versionRequirements)."
    }

    // Creates an assertion failure when a Flutter method receives an error from Dart.
    fileprivate func assertFlutterMethodFailure(_ error: PigeonError, methodName: String) {
      assertionFailure(
        "\(String(describing: error)): Error returned from calling \(methodName): \(String(describing: error.message))"
      )
    }

    /// Handles calling a Flutter method on the main thread.
    func dispatchOnMainThread(
      execute work: @escaping (
        _ onFailure: @escaping (_ methodName: String, _ error: PigeonError) -> Void
      ) -> Void
    ) {
      DispatchQueue.main.async {
        work { methodName, error in
          self.assertFlutterMethodFailure(error, methodName: methodName)
        }
      }
    }
}

/// Implementation of `CLGeocoderLibraryPigeonProxyApiDelegate` that provides each ProxyApi delegate implementation.
class ProxyApiDelegate: CLGeocoderLibraryPigeonProxyApiDelegate {
    func pigeonApiCLGeocoder(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLGeocoder {
        return PigeonApiCLGeocoder(pigeonRegistrar: registrar, delegate: CLGeocoderProxyApiDelegate())
    }
    
    func pigeonApiCLLocation(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLLocation {
        return PigeonApiCLLocation(pigeonRegistrar: registrar, delegate: CLLocationProxyApiDelegate())
    }
    
    func pigeonApiCLLocationCoordinate2D(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLLocationCoordinate2D {
        return PigeonApiCLLocationCoordinate2D(pigeonRegistrar: registrar, delegate: CLLocationCoordinate2DProxyApiDelegate())
    }
    
    func pigeonApiCLLocationSourceInformation(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLLocationSourceInformation {
        return PigeonApiCLLocationSourceInformation(pigeonRegistrar: registrar, delegate: CLLocationSourceInformationProxyApiDelegate())
    }
    
    func pigeonApiCLPlacemark(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLPlacemark {
        return PigeonApiCLPlacemark(pigeonRegistrar: registrar, delegate: CLPlacemarkProxyApiDelegate())
    }
        
    func pigeonApiCNPostalAddress(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCNPostalAddress {
        return PigeonApiCNPostalAddress(pigeonRegistrar: registrar, delegate: CNPostalAddressProxyApiDelegate())
    }
    
    func pigeonApiLocale(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiLocale {
        return PigeonApiLocale(pigeonRegistrar: registrar, delegate: LocaleProxyApiDelegate())
    }
    
    func pigeonApiNSObject(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiNSObject {
        return PigeonApiNSObject(pigeonRegistrar: registrar, delegate: NSObjectProxyApiDelegate())
    }
    
    func pigeonApiCLFloor(_ registrar: CLGeocoderLibraryPigeonProxyApiRegistrar) -> PigeonApiCLFloor {
        return PigeonApiCLFloor(pigeonRegistrar: registrar, delegate: CLFloorProxyApiDelegate())
    }
}
