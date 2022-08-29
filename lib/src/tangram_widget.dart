part of tangram_flutter_map;

typedef void MapCreatedCallback(TMapController controller);

class TangramWidget extends StatefulWidget{
  final TangramApiKey? tangramkey;
  final String scenePath;
  final double pickRadius;
  final String dataLayer;
  final String pointStylingPath;
  final CameraPosition cameraPosition;
  final bool isFeaturePickListener;
  final bool isLabelPickListener;
  final bool isMapChangeListener;
  final bool isMarkerPickListener;
  final bool isTouchInput;
  final bool isSceneLoadListener;

  ///高德定位配置
  final LocationModes LocationMode;
  final int interval;
  final AMapApiKey? ampApiKey;
  final bool isLocation;
  final bool isNeedAddress;
  ///高德合规声明配置
  ///
  /// 高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy
  final AMapPrivacyStatement ?privacyStatement;
  /// 创建一个展示高德地图的widget
  /// 如果使用的高德地图SDK的版本是8.1.0及以上版本，
  /// 在app首次启动时必须传入高德合规声明配置[privacyStatement],后续如果没有变化不需要重复设置
  /// <li>[privacyStatement.hasContains] 隐私权政策是否包含高德开平隐私权政策</li>
  /// <li>[privacyStatement.hasShow] 是否已经弹窗展示给用户</li>
  /// <li>[privacyStatement.hasAgree] 隐私权政策是否已经取得用户同意</li>
  /// 以上三个值，任何一个为false都会造成地图插件不工作（白屏情况）
  /// 高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy

  ///回调接口
  /// 地图创建成功的回调, 收到此回调之后才可以操作地图
  final MapCreatedCallback? onMapCreated;
  /// 相机视角持续移动的回调
  final ArgumentCallback<CameraPosition>? onCameraMove;
  /// 相机视角移动结束的回调
  final ArgumentCallback<CameraPosition>? onCameraMoveEnd;
  /// 地图单击事件的回调
  final ArgumentCallback<LatLng>? onTap;
  /// 地图长按事件的回调
  final ArgumentCallback<LatLng>? onLongPress;
  ///位置回调
  final ArgumentCallback<AMapLocation>? onLocationChanged;

  const TangramWidget({
    Key? key,
    this.tangramkey,
    this.scenePath='asset:///satellite-streets-style.yaml',
    this.pickRadius=10,
    this.dataLayer='touch',
    this.pointStylingPath='layers.touch.point.draw.icons',
    this.cameraPosition= const CameraPosition(latlng:LatLng(39.909187, 116.397451),zoom: 15),
    this.isFeaturePickListener=true,
    this.isLabelPickListener=true,
    this.isMapChangeListener=true,
    this.isMarkerPickListener=true,
    this.isTouchInput=true,
    this.isSceneLoadListener=true,

    this.LocationMode= LocationModes.High,
    this.privacyStatement,
    this.interval=2000,
    this.ampApiKey,
    this.isLocation=true,
    this.isNeedAddress=true,

    this.onLocationChanged,
    this.onCameraMove,
    this.onCameraMoveEnd,
    this.onLongPress,
    this.onMapCreated,
    this.onTap

  }): super(key: key);

  ///
  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<TangramWidget>{

  final Completer<TMapController> _controller = Completer<TMapController>();
  late _tangramConfig _tangramConfigs;
  @override
  Widget build(BuildContext context) {
    TangramUtil.init(context);
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'tangramApiKey':widget.tangramkey?.toMap(),
      'privacyStatement': widget.privacyStatement?.toMap(),
      'ampApiKey': widget.ampApiKey?.toMap(),
      'cameraPosition': widget.cameraPosition.toMap(),
      'options':_tangramConfigs.toMap(),
    };
    Widget mapView = _methodChannel.buildView(
      creationParams,
      onPlatformViewCreated,
    );
    return mapView;
  }
  @override
  void initState() {
    super.initState();
    _tangramConfigs = _tangramConfig.fromWidget(widget);
    print('initState TangramWidget');
  }

  @override
  void dispose() async {
    super.dispose();
    TMapController controller = await _controller.future;
    controller.disponse();
    print('dispose TangramWidget');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble TangramWidget');
  }

  @override
  void deactivate() async {
    super.deactivate();
    print('deactivate TangramWidget}');
  }

  @override
  void didUpdateWidget(covariant TangramWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateConfigs();
  }

  Future<void> onPlatformViewCreated(int id) async {
    final TMapController controller = await TMapController.init(
      widget.cameraPosition,
      this,
    );
    _controller.complete(controller);
    final MapCreatedCallback? _onMapCreated = widget.onMapCreated;
    if (_onMapCreated != null) {
      _onMapCreated(controller);
    }
  }

  void _updateConfigs() async {
    final _tangramConfig newConfigs = _tangramConfig.fromWidget(widget);
    final Map<String, dynamic> updates = _tangramConfigs._updatesMap(newConfigs);
    if (updates.isEmpty) {
      return;
    }
    final TMapController controller = await _controller.future;
    // ignore: unawaited_futures
    controller._updateMapOptions(updates);
    _tangramConfigs = newConfigs;
  }
}

class _tangramConfig {
  final String? scenePath;
  final double? pickRadius;
  final String? dataLayer;
  final String? pointStylingPath;
  final bool? isFeaturePickListener;
  final bool? isLabelPickListener;
  final bool? isMapChangeListener;
  final bool? isMarkerPickListener;
  final bool? isTouchInput;
  final bool? isSceneLoadListener;

  ///高德定位配置
  final LocationModes? LocationMode;
  final int? interval;
  final bool? isLocation;
  final bool? isNeedAddress;

  _tangramConfig({
    this.scenePath,
    this.pickRadius,
    this.dataLayer,
    this.pointStylingPath,
    this.isNeedAddress,
    this.isSceneLoadListener,
    this.isTouchInput,
    this.isMarkerPickListener,
    this.isMapChangeListener,
    this.isLabelPickListener,
    this.isFeaturePickListener,
    this.isLocation,
    this.interval,
    this.LocationMode
  });

  static _tangramConfig fromWidget(TangramWidget map) {
    return _tangramConfig(
        scenePath: map.scenePath,
        pickRadius:map.pickRadius,
        dataLayer:map.dataLayer,
        pointStylingPath:map.pointStylingPath,
        isNeedAddress:map.isNeedAddress,
        isSceneLoadListener:map.isSceneLoadListener,
        isTouchInput:map.isTouchInput,
        isMarkerPickListener:map.isMarkerPickListener,
        isMapChangeListener:map.isMapChangeListener,
        isLabelPickListener:map.isLabelPickListener,
        isFeaturePickListener:map.isFeaturePickListener,
        isLocation:map.isLocation,
        interval:map.interval,
        LocationMode:map.LocationMode
    );
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> configsMap = <String, dynamic>{};
    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        configsMap[fieldName] = value;
      }
    }
    addIfNonNull('scenePath', scenePath);
    addIfNonNull('pickRadius', pickRadius);
    addIfNonNull('isFeaturePickListener', isFeaturePickListener);
    addIfNonNull('isLabelPickListener', isLabelPickListener);
    addIfNonNull('isMapChangeListener',isMapChangeListener );
    addIfNonNull('isMarkerPickListener', isMarkerPickListener);
    addIfNonNull('isSceneLoadListener', isSceneLoadListener);
    addIfNonNull('isTouchInput', isTouchInput);
    addIfNonNull('dataLayer', dataLayer);
    addIfNonNull('pointStylingPath', pointStylingPath);
    addIfNonNull('isLocation', isLocation);
    addIfNonNull('interval', interval);
    addIfNonNull('isNeedAddress', isNeedAddress);
    addIfNonNull('LocationMode', LocationMode?.index);
    return configsMap;
  }

  Map<String, dynamic> _updatesMap(_tangramConfig newConfigs) {
    final Map<String, dynamic> prevOptionsMap = toMap();

    return newConfigs.toMap()
      ..removeWhere((String key, dynamic value) => (_checkChange(key, prevOptionsMap[key], value)));
  }

  bool _checkChange(String key, dynamic preValue, dynamic newValue) {
    if (key == 'myLocationStyle' || key == 'customStyleOptions') {
      return preValue?.toString() == newValue?.toString();
    } else {
      return preValue == newValue;
    }
  }
}



