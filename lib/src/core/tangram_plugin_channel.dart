import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tangram_plugin/src/core/tangram_plugin_platform.dart';
import 'package:tangram_plugin/src/tool/stream_where.dart';

import '../../tangram_flutter_base.dart';
import 'map_event.dart';
const VIEW_TYPE = 'flutter_map/view';
class MethodChannelTangram extends TangramFlutterPlatform{

  final methodChannel = const MethodChannel('test/channel');


  @override
  MethodChannel getChannel() {
    return this.methodChannel;
  }

  @override
  Future<void> init() {
    methodChannel.setMethodCallHandler((call) => _handleMethodCall(call));
    return methodChannel.invokeMethod<void>('map#sceneReady');
  }

  ///更新地图参数
  Future<void> updateMapOptions(Map<String, dynamic> newOptions) {
    return methodChannel.invokeMethod<void>(
      'map#update',
      <String, dynamic>{
        'options': newOptions,
      },
    );
  }

  Future<void> flyToPostion(CameraPosition cameraPosition)async{
    Map<String,double> map=Map();
    map["longitude"]=cameraPosition.latlng.longitude;
    map["latitude"]=cameraPosition.latlng.latitude;
    map["tilt"]=cameraPosition.tilt;
    map["rotation"]=cameraPosition.rotation;
    map["zoom"]=cameraPosition.zoom;
    await methodChannel.invokeMethod<void>('map#flyCamera',{"cameraPosition":map});
  }
  Future<void> flyToLoction()async{
    await methodChannel.invokeMethod<void>('view#flyLoction');
  }

  @override
  void dispose() {}

  @override
  Widget buildView(
      Map<String, dynamic> creationParams,
      void Function(int id) onPlatformViewCreated) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      creationParams['debugMode'] = kDebugMode;
      return AndroidView(
        viewType: VIEW_TYPE,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('当前平台:$defaultTargetPlatform, 不支持使用高德地图插件');
  }

  /// handleMethodCall的`broadcast`
  final StreamController<MapEvent> _mapEventStreamController =
  StreamController<MapEvent>.broadcast();

  Stream<MapEvent> _events() => _mapEventStreamController.stream;

  ///定位回调
  Stream<LocationChangedEvent> onLocationChanged() {
    return _events().whereType<LocationChangedEvent>();
  }

  ///Camera 移动回调
  Stream<CameraPositionMoveEvent> onCameraMove() {
    return _events().whereType<CameraPositionMoveEvent>();
  }

  ///Camera 移动结束回调
  Stream<CameraPositionMoveEndEvent> onCameraMoveEnd() {
    return _events().whereType<CameraPositionMoveEndEvent>();
  }

  Stream<MapTapEvent> onMapTap() {
    return _events().whereType<MapTapEvent>();
  }

  Stream<MapLongPressEvent> onMapLongPress() {
    return _events().whereType<MapLongPressEvent>();
  }

  Stream<MarkerTapEvent> onMarkerTap() {
    return _events().whereType<MarkerTapEvent>();
  }

  Stream<MarkerDragEndEvent> onMarkerDragEnd() {
    return _events().whereType<MarkerDragEndEvent>();
  }

  Stream<PolylineTapEvent> onPolylineTap() {
    return _events().whereType<PolylineTapEvent>();
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'view#locationChanged':
        try {
          _mapEventStreamController.add(LocationChangedEvent(
              AMapLocation.fromMap(call.arguments['location'])!));
        } catch (e) {
          print("view#locationChanged error=======>" + e.toString());
        }
        break;

      case 'camera#onMove':
        try {
          _mapEventStreamController.add(CameraPositionMoveEvent(
              CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMove error===>" + e.toString());
        }
        break;
      case 'camera#onMoveEnd':
        try {
          _mapEventStreamController.add(CameraPositionMoveEndEvent(
              CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMoveEnd error===>" + e.toString());
        }
        break;
      case 'map#onTap':
        _mapEventStreamController
            .add(MapTapEvent(LatLng.fromJson(call.arguments['latLng'])!));
        break;
      case 'map#onLongPress':
        _mapEventStreamController.add(MapLongPressEvent(
            call.arguments['onLongPress']!));
        break;

      case 'marker#onTap':
        _mapEventStreamController.add(MarkerTapEvent(
          call.arguments['markerId'],
        ));
        break;
      case 'marker#onDragEnd':
        _mapEventStreamController.add(MarkerDragEndEvent(
            LatLng.fromJson(call.arguments['position'])!,
            call.arguments['markerId']));
        break;
      case 'polyline#onTap':
        _mapEventStreamController
            .add(PolylineTapEvent(call.arguments['polylineId']));
        break;
    }
  }





}

