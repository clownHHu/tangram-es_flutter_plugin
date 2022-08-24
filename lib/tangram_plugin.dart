import 'package:flutter/services.dart';
import 'options/camera_position.dart';
import 'options/tangram_config.dart';
import 'tangram_plugin_platform_interface.dart';


class TangramPlugin {
  // TangramConfig getTangramConfig()=>TangramConfig();
  Future<String?> getPlatformVersion() {
    return TangramFlutterPluginPlatform.instance.getPlatformVersion();
  }
  Future<void> setTangramKey(String key) {
    return TangramFlutterPluginPlatform.instance.setTangramKey(key);
  }
  MethodChannel getChannel(){
    return TangramFlutterPluginPlatform.instance.getChannel();
  }
  Future<void> flyToPostion(CameraPosition cameraPosition){
    return TangramFlutterPluginPlatform.instance.flyToPostion(cameraPosition);
  }
  Future<void> flyToLoction(){
    return TangramFlutterPluginPlatform.instance.flyToLoction();
  }
}
