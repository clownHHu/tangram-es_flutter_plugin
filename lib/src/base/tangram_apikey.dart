part of tangram_flutter_base;

class TangramApiKey {
  //iOS平台的key
  final String? iosKey;

  //Android平台的key
  final String? androidKey;

  ///构造AMapKeyConfig
  ///
  ///[iosKey] iOS平台的key
  ///
  ///[androidKey] Android平台的key
  const TangramApiKey({this.iosKey, this.androidKey});

  dynamic toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('androidKey', androidKey);
    addIfPresent('iosKey', iosKey);
    return json;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final TangramApiKey typedOther = other;
    return androidKey == typedOther.androidKey && iosKey == typedOther.iosKey;
  }

  @override
  int get hashCode => hashValues(androidKey, iosKey);

  @override
  String toString() {
    return 'TangramApiKey(androidKey: $androidKey, iosKey: $iosKey)';
  }
}
