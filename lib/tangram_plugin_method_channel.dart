import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'options/camera_position.dart';
import 'tangram_plugin_platform_interface.dart';

/// 使用方法通道的 [TangramFlutterPluginPlatform] 的实现。
class MethodChannelTangramFlutterPlugin extends TangramFlutterPluginPlatform {
  /// 用于与原生平台交互的方法通道。
  @visibleForTesting
  final methodChannel = const MethodChannel('test/channel');

  @override
  MethodChannel getChannel() {
    return this.methodChannel;
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> setTangramKey(String key) async{
    await methodChannel.invokeMethod<void>('map#setkey',{"TangramKey":key});
  }

  Future<void> flyToPostion(CameraPosition cameraPosition)async{
    Map<String,double> map=Map();
    map["longitude"]=cameraPosition.longitude;
    map["latitude"]=cameraPosition.latitude;
    map["tilt"]=cameraPosition.tilt;
    map["rotation"]=cameraPosition.rotation;
    map["zoom"]=cameraPosition.zoom;
    await methodChannel.invokeMethod<void>('map#flyCamera',{"cameraPosition":map});
  }
  Future<void> flyToLoction()async{
    await methodChannel.invokeMethod<void>('map#flyLoction');
  }
}


