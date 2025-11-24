import CoreLocation
import Foundation

/// Wrapper around `Locale`.
///
/// Since `Locale` is a struct, it is pass by value instead of pass by reference. This makes
/// it not possible to modify the properties of a struct with the typical ProxyAPI system.
class LocaleWrapper {
    var value: Locale
 
    init(_ value: Locale) {
        self.value = value
    }
}

/// Wrapper around `CLLocationCoordinate2D`.
///
/// Since `CLLocationCoordinates2D` is a struct, it is pass by value instead of pass by reference. This makes
/// it not possible to modify the properties of a struct with the typical ProxyAPI system.
class CLLocationCoordinate2DWrapper {
    var value: CLLocationCoordinate2D
    
    init(_ value: CLLocationCoordinate2D) {
        self.value = value
    }
}
