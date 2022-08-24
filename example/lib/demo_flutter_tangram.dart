import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tangram_plugin/options/camera_position.dart';
import 'package:tangram_plugin/options/tangram_config.dart';
import 'package:tangram_plugin/tangram_plugin.dart';

class TangramView extends StatelessWidget {

  TangramConfig config;
  TangramPlugin tangramPlugin=TangramPlugin();
  final MethodChannel _channel = TangramPlugin().getChannel();

  TangramView({required this.config}) {
    if (null == this.config)
      {
        this.config = TangramConfig(config.key);
      }
    //init();
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
        viewType:"flutter_map/view",
        creationParamsCodec: StandardMessageCodec(),
        creationParams: config.toMap(),
    );
  }

  Future<dynamic> addMarker(MarkerOption options) async {
    return _channel.invokeMethod("map#flyCamera", options.toMap());
  }
  Future<dynamic> init(String key) async {
    return tangramPlugin.setTangramKey(key);
  }
  Future<dynamic> flyToPostion(CameraPosition cameraPosition) async{
    return tangramPlugin.flyToPostion(cameraPosition);
  }
  Future<dynamic> flytToLoction() async{
    return tangramPlugin.flyToLoction();
  }


}



class MarkerOption {
  double latitude;
  double longitude;
  String title;

  MarkerOption({required this.latitude, required this.longitude, required this.title});

  Map toMap() {
    Map map = Map();
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['title'] = title;
    return map;
  }
}
