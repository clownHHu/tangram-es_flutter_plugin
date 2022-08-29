part of tangram_flutter_base;

class CameraPosition {
  /// 构造一个CameraPosition 对象
  ///
  /// 如果[rotation], [latlng], [tilt], 或者 [zoom] 为null时会返回[AssertionError]
  const CameraPosition({
    required this.latlng,
    this.tilt = 0.0,
    this.zoom = 10,
    this.rotation=0.0
  });

  /// 目标位置的屏幕中心点经纬度坐标。
  final LatLng latlng;

  /// 目标可视区域的倾斜度，以角度为单位。范围从0到360度
  final double tilt;

  /// 目标可视区域的缩放级别
  final double zoom;

  final double rotation;

  /// 将[CameraPosition]装换成Map
  ///
  /// 主要在插件内部使用
  dynamic toMap() => <String, dynamic>{
    'latlng': latlng.toJson(),
    'tilt': tilt,
    'zoom': zoom,
    'rotation':rotation,
  };

  /// 从Map转换成[CameraPosition]
  ///
  /// 主要在插件内部使用
  static CameraPosition? fromMap(dynamic json) {
    if (json == null || !(json is Map<dynamic, dynamic>)) {
      return null;
    }
    final LatLng? latlng = LatLng.fromJson(json['target']);
    if (latlng == null) {
      return null;
    }
    return CameraPosition(
      latlng: latlng,
      tilt: json['tilt'],
      zoom: json['zoom'],
      rotation: json['rotation'],
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final CameraPosition typedOther = other;
    return latlng == typedOther.latlng &&
        tilt == typedOther.tilt &&
        zoom == typedOther.zoom &&
        rotation==typedOther.rotation;
  }

  @override
  int get hashCode => hashValues(latlng, tilt, zoom,rotation);

  @override
  String toString() =>
      'CameraPosition(latlng: $latlng, tilt: $tilt, zoom: $zoom, rotation:$rotation)';
}
