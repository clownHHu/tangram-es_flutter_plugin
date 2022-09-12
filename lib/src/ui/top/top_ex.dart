///example
//
// Widget _topSection(Size size,double top,double baseTop){
//   final List<Widget> children=<Widget>[];
//   children.add(
//       FancyBar(
//         width: 35,
//         height: 35,
//         margin: const EdgeInsets.only(right: 20, top: 40),
//         onTap: ()async{
//           await _mapController.locationSwitch();
//         },
//         child: const Icon(Icons.location_on, color: Colors.black, size: 20),)
//   );
//   children.add(
//       FancyBar(
//         width: 35,
//         height: 35,
//         margin: EdgeInsets.only(right: 20, top: this.top-170>0||this.top==0?this.top==0?baseTop-170:this.top-170<baseTop-170?this.top-170:baseTop-170:10),
//         onTap: ()async{
//           await _mapController.flyToLoction();
//         },
//         child: const Icon(Icons.my_location, color: Colors.black, size: 20),)
//   );
//   children.add(
//       FancyBar(
//         width: 35,
//         height: 35,
//         margin: const EdgeInsets.only(right: 20,top: 10),
//         onTap: ()async{
//           CameraPosition cameraPosition=const CameraPosition(latlng:LatLng(39.909187, 116.397451),zoom: 15);
//           await _mapController.flyToPostion(cameraPosition);
//         },
//         child: const Icon(Icons.account_balance, color: Colors.black, size: 20),)
//   );
//
//   return TopSection(size: size, children: children);
// }