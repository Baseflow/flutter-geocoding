import Foundation

/// ProxyApi implementation for `Locale`.
///
/// This class may handle instantiating native object instances that are attached to a Dart instance
/// or handle method calls on the associated native class or an instance of that class.
class LocaleProxyApiDelegate: PigeonApiDelegateLocale {

    func pigeonDefaultConstructor(pigeonApi: PigeonApiLocale, identifier: String) throws -> LocaleWrapper {
        return LocaleWrapper(Locale(identifier: identifier))
    }
    
    func getIdentifier(pigeonApi: PigeonApiLocale, pigeonInstance: LocaleWrapper) throws -> String {
        return pigeonInstance.value.identifier
    }
}
