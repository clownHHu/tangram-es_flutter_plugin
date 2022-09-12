part of tangram_flutter_ui;

class RowLists extends StatelessWidget {
  RowLists({required this.location});
  final AMapLocation location;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 26),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "定位信息",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 18),
                      ))
                ],
              ),
              ///第一行
              Container(
                  margin: EdgeInsets.only(top: 16, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                            Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(location.locationflag==true?location.getTimeSinceEpoch().toString():'-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  )),
                              Text(
                                "定位时间",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                            ),
                           Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(location.locationflag==true?location.latLng.latitude.toStringAsFixed(5):'-',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    )),
                                Text(
                                  "纬度",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            )
                            ,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(location.locationflag==true?location.latLng.longitude.toStringAsFixed(5):'-',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    )),
                                Text(
                                  "经度",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                  )),
              ///第二行
              Container(
                  margin: EdgeInsets.only(top: 16, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text(location.locationflag==true?location.accuracy.toString():'-',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          Text(
                            "水平精确度",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text(location.locationflag==true?location.altitude.toString():'-',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          Text(
                            "海拔",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      )
                      ,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text(location.locationflag==true?location.bearing.toString():'-',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          Text(
                            "角度",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text(location.locationflag==true?location.speed.toString():'-',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              )),
                          Text(
                            "速度",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ))
            ]));
  }
}