import Flutter
import UIKit
import PassageFlex

public class PassageFlutterPlugin: NSObject, FlutterPlugin {
    
    private var channel: FlutterMethodChannel?
    private var passageFlex: PassageFlexFlutter?
    private var appId: String?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "passage_flutter", binaryMessenger: registrar.messenger())
        let instance = PassageFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.channel = channel
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if passageFlex == nil {
            if
                call.method == "initialize",
                let appId = (call.arguments as? [String: String])?["appId"]
            {
                passageFlex = PassageFlexFlutter(appId: appId)
            }
            guard passageFlex != nil else {
                result(FlutterError(code: "NOT_INITIALIZED", message: "PassageFlutter has not been initialized", details: nil))
                return
            }
        }
        switch call.method {
        case "initialize": ()
        case "register":
            passageFlex?.register(call: call, result: result)
        case "authenticate":
            passageFlex?.authenticate(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
