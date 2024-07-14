import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          // Override point for customization after application launch.
//           FirebaseApp.configure()
//           IQKeyboardManager.shared.enable = true
//           IQKeyboardManager.shared.keyboardAppearance = .dark
//           IQKeyboardManager.shared.overrideKeyboardAppearance = true
//           IQKeyboardManager.shared.shouldResignOnTouchOutside = true
          return true
      }
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
