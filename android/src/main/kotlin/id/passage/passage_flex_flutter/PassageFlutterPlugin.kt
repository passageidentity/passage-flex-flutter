package id.passage.passage_flex_flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import id.passage.passage_flex_flutter.PassageFlexFlutter
import id.passage.passage_flex_flutter.PassageFlexFlutter.Companion.invalidArgumentError
import id.passage.passageflex.PassageFlex

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class PassageFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
  private var passageFlutter: PassageFlexFlutter? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "passage_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (activity == null) {
      result.error("NO_ACTIVITY", "Activity is not attached", null)
      return
  }
      if (passageFlutter == null) {
          if (call.method == "initialize") {
              val appId = call.argument<String>("appId") ?: return invalidArgumentError(result)
              passageFlutter =  PassageFlexFlutter(activity, appId)
          }
      }

      when (call.method) {
          "initialize" -> {
            result.success(null)  
          }
          "register" -> passageFlutter?.register(call, result)
          "authenticate" -> passageFlutter?.authenticate(call, result)
          else -> {
              result.notImplemented()
          }
      }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }

}
