import Flutter
import UIKit

public class SwiftFlutterUtils_zPlugin: NSObject, FlutterPlugin {
    public var registrar:FlutterPluginRegistrar? = nil;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_utils_z", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterUtils_zPlugin()
        instance.registrar = registrar
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "getAssetPathPrefix"){
            var retPath: String?
            let path1: String? = (call.arguments as! Dictionary<String, String>)["existedPath"];
            if (path1 != nil && path1!.count > 0){
                let key = self.registrar?.lookupKey(forAsset: path1!)
                let path = Bundle.main.path(forResource: key, ofType: nil)
                let subStr: Substring? = path?.prefix((path?.count ?? 0) - (path1?.count ?? 0))
                if (subStr != nil){
                    retPath = String(subStr!)
                }
            }
            result(retPath)
        } else if (call.method == "getAssetPath"){
            var retPath: String?
            let arguments: [String: String] = call.arguments as! Dictionary;
            let path1: String = arguments["path"] ?? "";
            if (path1.count > 0) {
                let key:String? = self.registrar?.lookupKey(forAsset: path1)
                let path = Bundle.main.path(forResource: key, ofType: nil)
                retPath = path;
            }
            result(retPath)
        } else {
            result(nil)
        }
    }
}
