package com.example.flutter_utils_z

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


enum class PluginMethods{
  getPlatformVersion,
  getAssetPath,
  getAssetPathPrefix
}

class FlutterUtils_zPlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_utils_z")
      channel.setMethodCallHandler(FlutterUtils_zPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == PluginMethods.getPlatformVersion.name) {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == PluginMethods.getAssetPath.name) {
      result.success("getAssetPath return")
    } else if (call.method == PluginMethods.getAssetPathPrefix.name) {
      result.success("getAssetPathPrefix return")
    } else {
      result.notImplemented()
    }
  }
}
