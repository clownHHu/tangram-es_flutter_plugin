import 'package:flutter/material.dart';
import 'package:tangram_plugin/tangram_flutter_base.dart';
import 'package:tangram_plugin/tangram_flutter_map.dart';

import 'configs.dart';

void main() =>runApp( MaterialApp(home:MyApp() ,));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  late TangramWidget tmap;
  late TMapController _mapController;

  @override
  void initState() {
    //checkPermission();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
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
    return MaterialApp(
        title: 'material app',
        home:Scaffold(
          appBar: _appBar(),
          body: _body(size),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          bottomNavigationBar:_bottomNavigationBar(),
        ));
  }

  AppBar _appBar(){
    return AppBar(
      title: Text('Tangram'),
      backgroundColor: Colors.lightBlue,
      automaticallyImplyLeading:false,
    );
  }
  Container _body(Size size){
    return Container(
        height: size.height,
        width: size.width,
        child: tmap,
        margin: EdgeInsets.only(bottom: 30),
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


  BottomNavigationBar _bottomNavigationBar(){
    return BottomNavigationBar(
      showSelectedLabels: true,
      currentIndex: _currentIndex, //这个是当前选中的下标
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
              Icons.home
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.favorite
          ),
          label:'收藏',
        ),
        BottomNavigationBarItem(
          icon: Icon(
              Icons.account_circle_outlined
          ),
          label: '设置',
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }


  void onMapCreated(TMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onLocationChanged(AMapLocation location) {
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