part of tangram_flutter_ui;

class RowLists extends StatelessWidget {
  RowLists({required this.location, required this.listIndex,required this.navigation,required this.onNavigation});
  final AMapLocation location;
  final Navigation navigation;
  final Function onNavigation;
  final int listIndex;
  @override
  Widget build(BuildContext context) {
    switch (listIndex) {
      case 0:
        return _location();
      case 1:
        return _navigation();
      case 2:
        return const Text("2");
      default:
        return const Text("listIndex outRanged");
    }
  }

  Container _location() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 26),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "定位信息",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 18),
                      )),
                ],
              ),

              ///第一行
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.getTimeSinceEpoch().toString()
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "定位时间",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.latLng.latitude
                                        .toStringAsFixed(5)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "纬度",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.latLng.longitude
                                        .toStringAsFixed(5)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "经度",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )),

              ///第二行
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.accuracy.toStringAsFixed(3)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "水平精确度",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.altitude.toStringAsFixed(3)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "海拔",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.bearing.toStringAsFixed(3)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "角度",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(
                                location.locationflag == true
                                    ? location.speed.toStringAsFixed(3)
                                    : '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          const Text(
                            "速度",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ))
            ]));
  }

  Container _navigation() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "导航信息",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 18),
                    )),
                ElevatedButton(
                  onPressed: (){
                    onNavigation();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      //设置按下时的背景颜色
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green[200];
                      }
                      //默认不使用背景颜色
                      return Colors.grey[400];
                    }),
                    shape: MaterialStateProperty.all(const CircleBorder(
                        side: BorderSide(
                      //设置 界面效果
                      color: Colors.green,
                      width: 280.0,
                      style: BorderStyle.none,
                    ))), //圆角弧度
                  ),
                  child: const Icon(
                    Icons.pause,
                    size: 20,
                  ),
                )
              ],
            ),
            ///第一行
            Container(
              margin: const EdgeInsets.only(top: 16, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        location.locationflag == true
                            ? location.speed.toStringAsFixed(3)
                            : '-',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                      )),
                  const Text(
                    "总里程",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
            ),

            ///第二行
            Container(
                margin: const EdgeInsets.only(top: 16, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? location.getTimeSinceEpoch().toString()
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "总耗时",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? navigation.upAltitude.toStringAsFixed(3)
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "上升",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? navigation.downAltitude.toStringAsFixed(3)
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "下降",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )),

            ///第三行
            Container(
                margin: const EdgeInsets.only(top: 16, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? navigation.minAltitude.toStringAsFixed(3)
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "最低海拔",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? navigation.maxAltitude.toStringAsFixed(3)
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "最高海拔",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              location.locationflag == true
                                  ? navigation.averSpeed.toStringAsFixed(3)
                                  : '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )),
                        const Text(
                          "平均速度",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ))
          ]),
    );
  }
}
