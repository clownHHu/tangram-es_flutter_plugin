import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tangram_plugin/src/core/tangram_plugin_channel.dart';

abstract class TangramFlutterPlatform extends PlatformInterface {
  static final Object _token = Object();
  TangramFlutterPlatform() : super(token: _token);
  static TangramFlutterPlatform _instance = MethodChannelTangram();

  static TangramFlutterPlatform get instance => _instance;

  static set instance(TangramFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  void dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Widget buildView(
      Map<String, dynamic> creationParams,
      PlatformViewCreatedCallback onPlatformViewCreated) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
