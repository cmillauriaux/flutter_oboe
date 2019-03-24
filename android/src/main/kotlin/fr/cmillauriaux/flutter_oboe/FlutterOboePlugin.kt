package fr.cmillauriaux.flutter_oboe

import android.app.Activity
import fr.cmillauriaux.flutteroboe.PlaybackEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.view.FlutterView

class flutter_oboePlugin: MethodCallHandler {
    val activity: Activity;

  constructor(registrar: Registrar, view: FlutterView, activity: Activity) {
      this.activity = activity;
      PlaybackEngine.create(activity);
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      if (registrar.activity() == null) {
        // When a background flutter view tries to register the plugin, the registrar has no activity.
        // We stop the registration process as this plugin is foreground only.
        return;
      }

      val channel = MethodChannel(registrar.messenger(), "flutter_oboe")
      channel.setMethodCallHandler(flutter_oboePlugin(registrar, registrar.view(), registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      //System.out.println(PlaybackEngine.create(activity));
      System.out.println("Current Latency : " + PlaybackEngine.getCurrentOutputLatencyMillis())
      result.success(PlaybackEngine.getCurrentOutputLatencyMillis().toString() + "ms")
    } else if (call.method == "playTone") {
      PlaybackEngine.setToneOn(true);
    } else if (call.method == "stopTone") {
      PlaybackEngine.setToneOn(false);
    }else {
      result.notImplemented()
    }
  }
}
