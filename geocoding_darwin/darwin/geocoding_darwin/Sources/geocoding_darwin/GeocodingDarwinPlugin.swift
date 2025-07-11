#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

public class GeocodingDarwinPlugin: NSObject, FlutterPlugin {
    var proxyApiRegistrar: ProxyApiRegistrar?
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        proxyApiRegistrar = ProxyApiRegistrar(binaryMessenger: binaryMessenger)
        proxyApiRegistrar?.setUp()
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
#if os(iOS)
  let binaryMessenger = registrar.messenger()
#else
  let binaryMessenger = registrar.messenger
#endif
        let plugin = GeocodingDarwinPlugin(binaryMessenger: binaryMessenger)
        registrar.publish(plugin)
    }

    public func detachFromEngine(for registrar: any FlutterPluginRegistrar) {
        proxyApiRegistrar!.ignoreCallsToDart = true
        proxyApiRegistrar!.tearDown()
        proxyApiRegistrar = nil
    }
}
