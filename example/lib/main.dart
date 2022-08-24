import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:tangram_plugin/options/camera_position.dart';
import 'package:tangram_plugin/options/tangram_config.dart';
import 'package:tangram_plugin/tangram_plugin.dart';
import 'demo_flutter_tangram.dart';

void main() =>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  TangramPlugin tangramPlugin=TangramPlugin();
  late TangramView tangramView;
  TangramConfig tangramConfig=TangramConfig("H5w9GBKJRRKcjlnVXKX4tw");

  @override
  void initState() {
    //checkPermission();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    tangramView = TangramView(
      config: TangramConfig("H5w9GBKJRRKcjlnVXKX4tw"),
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
        child: tangramView
    );
  }
  Row _floatingActionButton(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(child: Text('fly'),
          mini:true,
          onPressed: () async {
          CameraPosition cameraPosition=CameraPosition(latitude:33,longitude:44);
          await tangramView.flyToPostion(cameraPosition);
        //tangramView
        },),
          FloatingActionButton(child: Text('loc'),
              mini:true,
              onPressed: ()async{
            await tangramView.flytToLoction();
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



}