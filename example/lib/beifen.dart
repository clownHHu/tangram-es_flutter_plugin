// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:tangram_plugin/tangram_flutter_base.dart';
// import 'package:tangram_plugin/tangram_flutter_map.dart';
// import 'configs.dart';
//
// void main() =>runApp( MaterialApp(home:MyApp() ,debugShowCheckedModeBanner: false,));
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
//
// }
//
// class _MyAppState extends State<MyApp> {
//   int _currentIndex = 0;
//   late TangramWidget tmap;
//   late TMapController _mapController;
//   late AMapLocation location;
//   double top = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final size =MediaQuery.of(context).size;
//     tmap =TangramWidget(
//       tangramkey:Configs.tangramApiKey,
//       ampApiKey: Configs.amapApiKeys,
//       privacyStatement:Configs.amapPrivacyStatement,
//       onMapCreated: onMapCreated,
//       onLocationChanged: _onLocationChanged,
//       onCameraMove: _onCameraMove,
//       onCameraMoveEnd: _onCameraMoveEnd,
//       onLongPress: _onMapLongPress,
//       onTap: _onMapTap,
//     );
//     return Scaffold(
//       appBar: _appBar(),
//       body: _stack(size),
//       floatingActionButton: _floatingActionButton(),
//       floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
//       floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//       bottomNavigationBar:_bottomNavigationBar(),
//     );
//   }
//
//   AppBar _appBar(){
//     return AppBar(
//       //阴影设置为0
//       elevation: 0,
//       title: Text('Tangram'),
//       backgroundColor: Colors.lightBlue,
//       automaticallyImplyLeading:false,
//       actions: <Widget>[
//         // 非隐藏的菜单
//         IconButton(
//             color: Colors.black,
//             icon: const Icon(Icons.location_on),
//             tooltip: 'location switch',
//             onPressed: () async{
//               _mapController.locationSwitch();
//             }
//         ),
//       ],
//     );
//   }
//   Container _body(Size size){
//     return Container(
//       alignment:Alignment.center,
//       height: size.height,
//       width: size.width,
//       child: tmap,
//     );
//   }
//   Stack _stack(Size size){
//     double baseTop=size.height*0.6;
//     double searchBarHeight=54.0;
//     return Stack(
//       children: <Widget>[
//         BackgroundImage(
//           mapWidget: Center(
//             child: SizedBox(
//               child: tmap,
//             ),
//           ),
//         ),
//         TopSection(),
//         GestureDetector(
//           onPanUpdate: (DragUpdateDetails details) {
//             final double scrollPos = details.globalPosition.dy;
//             if (scrollPos < baseTop && scrollPos > searchBarHeight) {
//               setState(() {
//                 top = scrollPos;
//               });
//             }
//           },
//           child: DraggableSection(
//             top: this.top == 0.0 ? baseTop : this.top,
//             searchBarHeight: searchBarHeight,
//           ),
//         ),
//       ],
//     );
//   }
//   Row _floatingActionButton(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         FloatingActionButton(child: Text('fly'),
//           mini:true,
//           onPressed: () async {
//             CameraPosition cameraPosition=const CameraPosition(latlng:LatLng(39.909187, 116.397451),zoom: 15);
//             await _mapController.flyToPostion(cameraPosition);
//             //tangramView
//           },),
//         FloatingActionButton(child: Text('loc'),
//             mini:true,
//             onPressed: ()async{
//               await _mapController.flyToLoction();
//             }),
//       ],
//
//     );
//   }
//
//   BottomNavigationBar _bottomNavigationBar(){
//     return BottomNavigationBar(
//       showSelectedLabels: true,
//       currentIndex: _currentIndex, //这个是当前选中的下标
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(
//               Icons.home
//           ),
//           label: '首页',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//               Icons.favorite
//           ),
//           label:'收藏',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//               Icons.account_circle_outlined
//           ),
//           label: '设置',
//         ),
//       ],
//       onTap: (int index) {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//     );
//   }
//
//
//   void onMapCreated(TMapController controller) {
//     setState(() {
//       _mapController = controller;
//     });
//     _mapController.getlocationPermission();
//   }
//
//   void _onLocationChanged(AMapLocation location) {
//     this.location=location;
//     print('_onLocationChanged ${location.toJson()}');
//   }
//
//   void _onCameraMove(CameraPosition cameraPosition) {
//     print('onCameraMove===> ${cameraPosition.toMap()}');
//   }
//
//   void _onCameraMoveEnd(CameraPosition cameraPosition) {
//     print('_onCameraMoveEnd===> ${cameraPosition.toMap()}');
//   }
//
//   void _onMapTap(LatLng latLng) {
//     print('_onMapTap===> ${latLng.toJson()}');
//   }
//
//   void _onMapLongPress(String result) {
//     print('_onMapLongPress===> $result');
//   }
//
//
//
// }