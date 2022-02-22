//
//  SeatsIoView.swift
//  seats_io_flutter
//
//  Created by Robert Taylor on 2/21/22.
//

import Flutter
import UIKit
import seatsio

class SeatsIoViewFactory: NSObject, FlutterPlatformViewFactory{
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger){
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        if let argsDictionary = args as? Dictionary<String, AnyObject>{
            return SeatsIoView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: argsDictionary,
                binaryMessenger: messenger
            )
        }else{
            return SeatsIoView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: [String:AnyObject](),
                binaryMessenger: messenger
            )
        }
    }
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class SeatsIoView: NSObject, FlutterPlatformView{
    
    private var _view: SeatsioWebView!
    private final var _methodChannel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Dictionary<String, AnyObject>,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ){
        let eventId: String = args["eventId"] as! String
        let publicKey: String = args["publicKey"] as! String
        let config: SeatingChartConfig = SeatingChartConfig()
            .publicKey(publicKey)
            .event(eventId)
        _view = SeatsioWebView(frame: frame, region: "eu", seatsioConfig: config)
        _methodChannel = FlutterMethodChannel(name: "seats-io-view_\(viewId)", binaryMessenger: messenger!)
        super.init()
        _methodChannel.setMethodCallHandler(onMethodCall(call:result:))
    }
    
    func onMethodCall(
        call: FlutterMethodCall,
        result: FlutterResult
    ){
        
    }
    
    func view() -> UIView {
        return _view;
    }
}
