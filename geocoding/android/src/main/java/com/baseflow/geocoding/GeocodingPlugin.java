package com.baseflow.geocoding;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * Plugin implementation that uses the new {@code io.flutter.embedding} package.
 *
 * <p>Instantiate this in an add to app scenario to gracefully handle activity and context changes.
 */
public final class GeocodingPlugin implements FlutterPlugin {
  private static final String TAG = "GeocodingPlugin";
  @Nullable private MethodCallHandlerImpl methodCallHandler;
  @Nullable private Geocoding geocoding;

  /**
   * Registers a plugin implementation that uses the stable {@code io.flutter.plugin.common}
   * package.
   *
   * <p>Calling this automatically initializes the plugin. However plugins initialized this way
   * won't react to changes in activity or context, unlike {@link GeocodingPlugin}.
   */
  public static void registerWith(Registrar registrar) {
    MethodCallHandlerImpl handler =
            new MethodCallHandlerImpl(new Geocoding(registrar.activeContext()));
    handler.startListening(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    geocoding = new Geocoding(binding.getApplicationContext());
    methodCallHandler = new MethodCallHandlerImpl(geocoding);
    methodCallHandler.startListening(binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (methodCallHandler == null) {
      Log.wtf(TAG, "Already detached from the engine.");
      return;
    }

    methodCallHandler.stopListening();
    methodCallHandler = null;
    geocoding = null;
  }
}
