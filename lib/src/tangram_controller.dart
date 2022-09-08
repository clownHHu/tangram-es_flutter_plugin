part of tangram_flutter_map;

final MethodChannelTangram _methodChannel = TangramFlutterPlatform.instance as MethodChannelTangram;

class TMapController{

  final _MapState _mapState;

  TMapController._(CameraPosition initCameraPosition, this._mapState) {
    _connectStreams();
  }

  ///根据传入的id初始化[AMapController]
  /// 主要用于在[AMapWidget]初始化时在[AMapWidget.onMapCreated]中初始化controller
  static Future<TMapController> init(
      CameraPosition initialCameration,
      _MapState mapState,
      ) async {
    await _methodChannel.init();
    return TMapController._(
      initialCameration,
      mapState,
    );
  }


  ///只用于测试
  ///用于与native的通信
  @visibleForTesting
  MethodChannel get channel {
    return _methodChannel.getChannel();
  }

  void getlocationPermission() async {
    final status = await Permission.location.status;
    if(!status.isGranted){
      Permission.location.request();
    }
  }

  void _connectStreams() {
    if (_mapState.widget.onLocationChanged != null) {
      _methodChannel
          .onLocationChanged()
          .listen((LocationChangedEvent e) => _mapState.widget.onLocationChanged!(e.value));
    }

    if (_mapState.widget.onCameraMove != null) {
      _methodChannel
          .onCameraMove()
          .listen((CameraPositionMoveEvent e) => _mapState.widget.onCameraMove!(e.value));
    }
    if (_mapState.widget.onCameraMoveEnd != null) {
      _methodChannel
          .onCameraMoveEnd()
          .listen((CameraPositionMoveEndEvent e) => _mapState.widget.onCameraMoveEnd!(e.value));
    }
    if (_mapState.widget.onTap != null) {
      _methodChannel.onMapTap().listen(((MapTapEvent e) => _mapState.widget.onTap!(e.value)));
    }
    if (_mapState.widget.onLongPress != null) {
      _methodChannel
          .onMapLongPress()
          .listen(((MapLongPressEvent e) => _mapState.widget.onLongPress!(e.value)));
    }

  }

  void disponse() {
    _methodChannel.dispose();
  }

  Future<void> _updateMapOptions(Map<String, dynamic> optionsUpdate) {
    return _methodChannel.updateMapOptions(optionsUpdate);
  }

  Future<void> flyToPostion(CameraPosition cameraPosition){
    return _methodChannel.flyToPostion(cameraPosition);
  }
  Future<void> flyToLoction(){
    return _methodChannel.flyToLoction();
  }
  Future<void> locationSwitch(){
    return _methodChannel.locationSwitch();
  }

}