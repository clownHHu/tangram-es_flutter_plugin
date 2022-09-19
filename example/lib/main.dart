
import 'package:flutter/material.dart';
import 'package:tangram_plugin/tangram_flutter_base.dart';
import 'package:tangram_plugin/tangram_flutter_map.dart';
import 'package:tangram_plugin/tangram_flutter_ui.dart';
import 'configs.dart';

void main() =>runApp( MaterialApp(home:MyApp() ,debugShowCheckedModeBanner: false,));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  late TangramWidget tmap;
  late TMapController _mapController;
  late AMapLocation location=AMapLocation(latLng: const LatLng(0,0),locationflag: false);
  late Navigation navigation=Navigation();
  late bool navFlag=false;
  double top = 0.0;
  int listIndex=0;


  @override
  void initState() {
    super.initState();
    tmap =TangramWidget(
      tangramkey:Configs.tangramApiKey,
      ampApiKey: Configs.amapApiKeys,
      privacyStatement:Configs.amapPrivacyStatement,
      onMapCreated: onMapCreated,
      onLocationChanged: _onLocationChanged,
      onCameraMove: _onCameraMove,
      onCameraMoveEnd: _onCameraMoveEnd,
      onLongPress: _onMapLongPress,
      onTap: _onMapTap,
      onNavigation: _onNavigation,
    );
  }


  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      body: _stack(size),
    );
  }


  Stack _stack(Size size){
    double baseTop=size.height*0.8;
    double iconBarHeight=54.0;
    return Stack(
      children: <Widget>[
        BackgroundMap(
        mapWidget: Center(
           child: SizedBox(
             child: tmap,
           ),
         ),
        ),
        _topSection(size,top,baseTop),
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            final double scrollPos = details.globalPosition.dy;
            if (scrollPos < baseTop && scrollPos > iconBarHeight) {
              setState(() {
                top = scrollPos;
              });
            }
          },
          child: DraggableSection(
            top: top == 0.0 ? baseTop : top,
            iconBarHeight: iconBarHeight,
            icon: setIcon(top,baseTop),
            location: location,
            navigation: navigation,
            index: listIndex,
            changeListIndex: _changeListIndex,
            onNavigation: _navigationSwitch,
          ),
        ),
      ],
    );
  }

  Widget _topSection(Size size,double top,double baseTop){
    final List<Widget> children=<Widget>[];
    children.add(
        FancyBar(
          width: 35,
          height: 35,
          margin: const EdgeInsets.only(right: 20, top: 40),
          onTap: ()async{
            await _mapController.locationSwitch();
          },
          child: const Icon(Icons.location_on, color: Colors.black, size: 20),)
    );
    children.add(
        FancyBar(
          width: 35,
          height: 35,
          margin: EdgeInsets.only(right: 20, top: (this.top-170>baseTop/2||this.top==0)?this.top==0?baseTop-170:this.top-170<baseTop-170?this.top-170:baseTop-170:baseTop/2),
          onTap: ()async{
            await _mapController.flyToLoction();
          },
          child: const Icon(Icons.my_location, color: Colors.black, size: 20),)
    );
    children.add(
        FancyBar(
          width: 35,
          height: 35,
          margin: const EdgeInsets.only(right: 20,top: 10),
          onTap: ()async{
            CameraPosition cameraPosition=const CameraPosition(latlng:LatLng(39.909187, 116.397451),zoom: 15);
            await _mapController.flyToPostion(cameraPosition);
          },
          child: const Icon(Icons.account_balance, color: Colors.black, size: 20),)
    );

    return TopSection(size: size, children: children);
  }

  void onMapCreated(TMapController controller) {
    setState(() {
      _mapController = controller;
    });
    _mapController.getlocationPermission();
  }
  void _changeListIndex(index){
    setState((){
      listIndex=index;
    });
  }
  void _navigationSwitch(){
    navFlag=!navFlag;
  }

  void _onLocationChanged(AMapLocation location) {
    setState(() {
      this.location=location;
      this.location.locationflag=true;
    });
    // this.location=location;
    // this.location.locationflag=true;

  }
  void _onNavigation(Navigation navigation) {
      if(navFlag) {
        setState(() {
          this.navigation=navigation;
        });
      }
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    print('onCameraMove===> ${cameraPosition.toMap()}');
  }

  void _onCameraMoveEnd(CameraPosition cameraPosition) {
    print('_onCameraMoveEnd===> ${cameraPosition.toMap()}');
  }

  void _onMapTap(LatLng latLng) {
    print('_onMapTap===> ${latLng.toJson()}');
  }

  void _onMapLongPress(String result) {
    print('_onMapLongPress===> $result');
  }


  setIcon(double top,double baseTop) {
      if(top==0||top>baseTop*0.7)
      {
        return const Icon(Icons.keyboard_arrow_up,size: 40,color: Colors.black,);
      }
      return const Icon(Icons.keyboard_arrow_down,size: 40,color: Colors.black,);

  }






}