import Flutter
import UIKit

public class VariableAppIconPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "variable_app_icon", binaryMessenger: registrar.messenger())
    let instance = VariableAppIconPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    guard let arguments = call.arguments as? [String: Any] else { return }

    switch call.method {
    case "changeAppIcon":
      let defaultIcon = arguments["defaultiOS"] as! String
      let currentIcon = arguments["iosIcon"] as! String
        setApplicationIconName(defaultIcon == currentIcon ? nil : currentIcon)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    func setApplicationIconName(_ iconName: String?) {
            if UIApplication.shared.responds(to: #selector(getter: UIApplication.supportsAlternateIcons)) && UIApplication.shared.supportsAlternateIcons {
                
                typealias setAlternateIconName = @convention(c) (NSObject, Selector, NSString?, @escaping (NSError) -> ()) -> ()
                
                let selectorString = "_setAlternateIconName:completionHandler:"
                
                let selector = NSSelectorFromString(selectorString)
                let imp = UIApplication.shared.method(for: selector)
                let method = unsafeBitCast(imp, to: setAlternateIconName.self)
                method(UIApplication.shared, selector, iconName as NSString?, { _ in })
            }
        }
}
