import 'package:flutter/services.dart';

import 'android_geocoder.dart';
import 'geocoder.pigeon.dart';
import 'instance_manager.dart';

/// Handles initialization of Flutter APIs for Android Geocoder.
class AndroidGeocoderFlutterApis {
  /// Constructs a [AndroidGeocoderFlutterApis] instance.
  AndroidGeocoderFlutterApis({
    GeocodeListenerFlutterApiImpl? geocodeListenerFlutterApi,
  }) : geocodeListenerFlutterApi =
            geocodeListenerFlutterApi ?? GeocodeListenerFlutterApiImpl();

  static bool _haveBeenSetUp = false;

  /// Mutable instance containing all Flutter APIs for Android Geocoder.
  ///
  /// This should only be changed for testing purposes.
  static AndroidGeocoderFlutterApis instance = AndroidGeocoderFlutterApis();

  /// Flutter API for [GeocodeListener].
  final GeocodeListenerFlutterApiImpl geocodeListenerFlutterApi;

  /// Ensure all Fluter APIs have been set up to receive calls from native code.
  void ensureSetUp() {
    if (_haveBeenSetUp) {
      return;
    }

    GeocodeListenerFlutterApi.setup(geocodeListenerFlutterApi);
    _haveBeenSetUp = true;
  }
}

/// Handles methods calls to the native Java Object class.
class JavaObjectHostApiImpl extends JavaObjectHostApi {
  /// Constructs a [JavaObjectHostApiImpl].
  JavaObjectHostApiImpl({
    this.binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? JavaObject.globalInstanceManager,
        super(binaryMessenger: binaryMessenger);

  /// Receives binary data across the Flutter platform barrier.
  ///
  /// If it is null, the default BinaryMessenger will be used which routes to
  /// the host platform.
  final BinaryMessenger? binaryMessenger;

  /// Maintains instances stored to communicate with native language objects.
  final InstanceManager instanceManager;
}

/// Handles callbacks methods for the native Java Object class.
class JavaObjectFlutterApiImpl implements JavaObjectFlutterApi {
  /// Constructs a [JavaObjectFlutterApiImpl].
  JavaObjectFlutterApiImpl({InstanceManager? instanceManager})
      : instanceManager = instanceManager ?? JavaObject.globalInstanceManager;

  /// Maintains instances stored to communicate with native language objects.
  final InstanceManager instanceManager;

  @override
  void dispose(String identifier) {
    instanceManager.remove(identifier);
  }
}

/// Host api implementation for [GeocodeListener].
class GeocodeListenerHostApiImpl extends GeocodeListenerHostApi {
  /// Constructs a [GeocodeListenerHostApiImpl].
  GeocodeListenerHostApiImpl({
    super.binaryMessenger,
    InstanceManager? instanceManager,
  }) : instanceManager = instanceManager ?? JavaObject.globalInstanceManager;

  /// Maintains instances stored to communicate with Java objects.
  final InstanceManager instanceManager;

  /// Helper method to convert object to instance identifier.
  ///
  /// The [createFromInstance] method is responsible for translating the
  /// supplied object into an instance identifier before calling the  [create]
  /// method which will create a matching instance on the native side.
  Future<void> createFromInstance(GeocodeListener instance) async {
    if (instanceManager.getIdentifier(instance) == null) {
      final String identifier =
          instanceManager.addDartCreatedInstance(instance);
      return create(identifier);
    }
  }
}

/// Flutter api implementation for [GeocodeListener].
class GeocodeListenerFlutterApiImpl extends GeocodeListenerFlutterApi {
  /// Constructs a [GeocodeListenerFlutterApiImpl].
  GeocodeListenerFlutterApiImpl({
    InstanceManager? instanceManager,
  }) : instanceManager = instanceManager ?? JavaObject.globalInstanceManager;

  /// Maintains instances stored to communicate with Java objects.
  final InstanceManager instanceManager;

  @override
  void onError(
    String instanceId,
    String errorMessage,
  ) {
    final GeocodeListener? instance = instanceManager
        .getInstanceWithWeakReference(instanceId) as GeocodeListener?;
    assert(
      instance != null,
      'InstanceManager does not contain a GeocodeListener with instanceId: $instanceId',
    );

    instance!.onError(
      errorMessage,
    );
  }

  @override
  void onGeocode(
    String instanceId,
    List<Address?> addresses,
  ) {
    // TODO: implement onGeocode
  }
}
