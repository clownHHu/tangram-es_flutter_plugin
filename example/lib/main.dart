import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tangram_plugin/tangram_flutter_base.dart';
import 'package:tangram_plugin/tangram_flutter_map.dart';
import 'configs.dart';

void main() =>runApp( MaterialApp(home:MyApp() ,debugShowCheckedModeBanner: false,));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  late TangramWidget tmap;
  late TMapController _mapController;
  late AMapLocation location;
  double top = 0.0;

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
    );
  }


  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      //appBar: _appBar(),
      body: _stack(size),
      // floatingActionButton: _floatingActionButton(),
      // floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  // AppBar _appBar(){
  //   return AppBar(
  //     //阴影设置为0
  //     elevation: 0,
  //     title: Text('Tangram'),
  //     backgroundColor: Colors.transparent,
  //     automaticallyImplyLeading:false,
  //     actions: <Widget>[
  //       // 非隐藏的菜单
  //       IconButton(
  //           color: Colors.black,
  //           icon: const Icon(Icons.location_on),
  //           tooltip: 'location switch',
  //           onPressed: () async{
  //             _mapController.locationSwitch();
  //           }
  //       ),
  //     ],
  //   );
  // }
  Stack _stack(Size size){
    double baseTop=size.height*0.6;
    double searchBarHeight=54.0;
    return Stack(
      children: <Widget>[
        BackgroundImage(
        mapWidget: Center(
           child: SizedBox(
             child: tmap,
           ),
         ),
        ),
        _topSection(size),
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            final double scrollPos = details.globalPosition.dy;
            if (scrollPos < baseTop && scrollPos > searchBarHeight) {
              setState(() {
                top = scrollPos;
              });
            }
          },
          child: DraggableSection(
            top: this.top == 0.0 ? baseTop : this.top,
            searchBarHeight: searchBarHeight,
          ),
        ),
      ],
    );
  }
  Row _floatingActionButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(child: Text('fly'),
          mini:true,
          onPressed: () async {
            CameraPosition cameraPosition=const CameraPosition(latlng:LatLng(39.909187, 116.397451),zoom: 15);
            await _mapController.flyToPostion(cameraPosition);
            //tangramView
          },),
        FloatingActionButton(child: Text('loc'),
            mini:true,
            onPressed: ()async{
              await _mapController.flyToLoction();
            }),
      ],

    );
  }
  Widget _topSection(Size size){
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
          margin: const EdgeInsets.only(right: 20, top: 300),
          onTap: ()async{
            await _mapController.flyToLoction();
          },
          child: const Icon(Icons.my_location, color: Colors.black, size: 20),)
    );
    children.add(
        FancyBar(
          width: 35,
          height: 35,
          margin: const EdgeInsets.only(right: 20),
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

  void _onLocationChanged(AMapLocation location) {
    this.location=location;
    print('_onLocationChanged ${location.toJson()}');
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
}