part of tangram_flutter_base;

class TangramUtil {
  static TangramUtil _instance = TangramUtil._();
  static double _devicePixelRatio = 0;
  static void init(BuildContext context) {
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  TangramUtil._();

  factory TangramUtil() {
    return _instance;
  }

  /// 获取当前设备的屏幕像素比
  static double get devicePixelRatio => _devicePixelRatio;
}