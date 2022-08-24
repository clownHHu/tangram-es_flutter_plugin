import 'camera_position.dart';
class TangramConfig {
  String scenePath;
  double zoom;
  double pickRadius;
  String key;
  bool isFeaturePickListener;
  bool isLabelPickListener;
  bool isMapChangeListener;
  bool isMarkerPickListener;
  bool isTouchInput;
  bool isSceneLoadListener;
  String dataLayer;
  String pointStylingPath;
  double latitude;
  double longitude;
  late CameraPosition? cameraPosition;
  bool isLocation;
  bool isNeedAddress;
  String LocationMode;
  int interval;
  String ampApiKey;

  TangramConfig(this.key,
      {
        this.scenePath ='asset:///satellite-streets-style.yaml',
        this.latitude =33,
        this.longitude =44,
        this.zoom =18,
        this.pickRadius=10,
        this.isFeaturePickListener=true,
        this.isLabelPickListener=true,
        this.isMapChangeListener=true,
        this.isMarkerPickListener=true,
        this.isSceneLoadListener=true,
        this.isTouchInput=true,
        this.dataLayer='touch',
        this.pointStylingPath='layers.touch.point.draw.icons',

        this.isLocation=true,
        this.isNeedAddress=true,
        this.interval =2000,
        this.LocationMode="High",
        this.ampApiKey="6ed7bd40e433b4bdf3fe1bd45c88e399"
      });


  Map toMap() {
    Map map = Map();
    map['zoom'] = zoom;
    map['TangramKey']=key;
    map['latitude']=latitude;
    map['longitude']=longitude;
    map['scenePath']=scenePath;
    map['pickRadius']=pickRadius;
    map['isFeaturePickListener']=isFeaturePickListener;
    map['isLabelPickListener']=isLabelPickListener;
    map['isMapChangeListener']=isMapChangeListener;
    map['isMarkerPickListener']=isMarkerPickListener;
    map['isSceneLoadListener']=isSceneLoadListener;
    map['isTouchInput']=isTouchInput;
    map['dataLayer']=dataLayer;
    map['pointStylingPath']=pointStylingPath;

    map['isLocation'] = isLocation;
    map['interval'] = interval;
    map['isNeedAddress']=isNeedAddress;
    map['LocationMode']=LocationMode;
    map['ampApiKey']=ampApiKey;
    return map;
  }
}

class dataLayer{

}