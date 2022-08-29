import 'package:flutter/material.dart';
import 'package:tangram_plugin/tangram_flutter_base.dart';
import 'package:tangram_plugin/tangram_flutter_map.dart';

import 'base/configs.dart';

void main() =>runApp(MyApp());

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
    tmap =TangramWidget(
      tangramkey:Configs.tangramApiKey,
      ampApiKey: Configs.amapApiKeys,
      privacyStatement:Configs.amapPrivacyStatement,
      onMapCreated: onMapCreated,
    );
    return MaterialApp(
        home:Scaffold(
          appBar: _appBar(),
          body: _body(),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation:FloatingActionButtonLocation.startFloat,
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
  Container _body(){
    return Container(
      //padding: EdgeInsets.all(50),
        margin: EdgeInsetsDirectional.only(bottom: 60),
        child: tmap
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



}