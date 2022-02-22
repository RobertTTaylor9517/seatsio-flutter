
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef SeatsIoViewCreatedCallback = void Function(SeatsViewController controller);

class SeatsIoFlutter extends StatefulWidget{
  const SeatsIoFlutter({Key? key, required this.eventId, required this.onSeatsIoViewCreated, required this.publicKey}) : super(key: key);
  
  final SeatsIoViewCreatedCallback onSeatsIoViewCreated;
  final String eventId;
  final String publicKey;
  
  @override 
  State<StatefulWidget> createState() => _SeatsIoFlutterState();
}

class _SeatsIoFlutterState extends State<SeatsIoFlutter>{
  @override
  Widget build(BuildContext context) {

    const String viewType = 'seats-io-view';
    Map<String, dynamic> creationParams = <String, dynamic>{
      "eventId": widget.eventId,
      "publicKey": widget.publicKey
    };

    switch(defaultTargetPlatform){
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  void _onPlatformViewCreated(int id){
    if(widget.onSeatsIoViewCreated == null){
      return;
    }
    widget.onSeatsIoViewCreated(SeatsViewController._(id));
  }
  
}

class SeatsViewController{
  SeatsViewController._(int id)
    : _channel = MethodChannel('seats-io-view_$id');

  final MethodChannel _channel;
}

// AndroidView androidView(String viewType, Map<String, dynamic> creationParams, _onPlatformViewCreated){
//   return AndroidView(
//     viewType: viewType,
//     creationParams: creationParams,
//     creationParamsCodec: const StandardMessageCodec(),
//     onPlatformViewCreated: _onPlatformViewCreated,
//   );
// }