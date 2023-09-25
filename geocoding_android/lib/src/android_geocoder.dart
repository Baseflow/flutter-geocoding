import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'android_geocoder_api_impls.dart';
import 'geocoder.pigeon.dart';
import 'instance_manager.dart';

/// Root of the Java class hierarchy.
///
/// See https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html.
class JavaObject with Copyable {
  /// Constructs a [JavaObject] without creating the associated Java object.
  ///
  /// This should only be used by subclasses created by this library or to
  /// create copies.
  @protected
  JavaObject.detached({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
  }) : _api = JavaObjectHostApiImpl(
          binaryMessenger: binaryMessenger,
          instanceManager: instanceManager,
        );

  /// Global instance of [InstanceManager].
  static final InstanceManager globalInstanceManager = _initInstanceManager();

  static InstanceManager _initInstanceManager() {
    WidgetsFlutterBinding.ensureInitialized();
    // Clears the native `InstanceManager` on initial use of the Dart one.
    InstanceManagerHostApi().clear();
    return InstanceManager(
      onWeakReferenceRemoved: (String identifier) {
        JavaObjectHostApiImpl().dispose(identifier);
      },
    );
  }

  /// Pigeon Host Api implementation for [JavaObject].
  final JavaObjectHostApiImpl _api;

  /// Release the reference to a native Java instance.
  static void dispose(JavaObject instance) {
    instance._api.instanceManager.removeWeakReference(instance);
  }

  @override
  JavaObject copy() {
    return JavaObject.detached();
  }
}

/// The interface to be used to receive the results of a geocode request.
@immutable
class GeocodeListener extends JavaObject {
  /// Constructs a [GeocodeListener].
  GeocodeListener({
    required this.onError,
    required this.onGeocode,
    @visibleForTesting super.binaryMessenger,
    @visibleForTesting super.instanceManager,
  }) : super.detached() {
    AndroidGeocoderFlutterApis.instance.ensureSetUp();
    api.createFromInstance(this);
  }

  /// Pigeon Host api implementation for [GeocodeListener].
  /// 
  /// This API is used internally upon construction of the [GeocodeListener]
  /// to create a matching object on the native host. This field is exposed
  /// for testing purposes only and should not be called externally.
  @visibleForTesting
  static GeocodeListenerHostApiImpl api = GeocodeListenerHostApiImpl();

  /// Notify the host application that the geocode attempt failed.
  final void Function(String errorMessage) onError;

  /// Notify the host application of a successful geocode translation.
  ///
  /// The [addresses] contains an array of [Address] objects attempting to
  /// describe the location.
  final void Function(List<Address?> addresses) onGeocode;
}
