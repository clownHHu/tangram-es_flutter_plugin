import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'options/camera_position.dart';
import 'tangram_plugin_method_channel.dart';

abstract class TangramFlutterPluginPlatform extends PlatformInterface {
  /// 构造一个 TangramFlutterPluginPlatform。
  TangramFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TangramFlutterPluginPlatform _instance = MethodChannelTangramFlutterPlugin();

  static TangramFlutterPluginPlatform get instance => _instance;

  static set instance(TangramFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  //设置地图key
  Future<void> setTangramKey(String key);

  MethodChannel getChannel();

  //旋转镜头
  Future<void> flyToPostion(CameraPosition cameraPosition);

  Future<void> flyToLoction();
}

