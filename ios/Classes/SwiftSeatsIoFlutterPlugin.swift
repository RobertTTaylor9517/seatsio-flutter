import Flutter
import UIKit

public class SwiftSeatsIoFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "seats_io_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftSeatsIoFlutterPlugin()
    let factory = SeatsIoViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "seats_io_flutter")
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
