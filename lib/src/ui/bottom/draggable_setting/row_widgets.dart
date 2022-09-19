part of tangram_flutter_ui;

class RowWidgets extends StatelessWidget {
  RowWidgets({required this.changeListIndex});

  final Function changeListIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 14),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          KPIWidget(
            name: "定位信息",
            index: 0,
            changeListIndex: changeListIndex,
            child: const Icon(Icons.map, color: Color(0xffFF2D55), size: 26),
          ),
          KPIWidget(
            name: "导航",
            index: 1,
            changeListIndex: changeListIndex,
            child: const Icon(Icons.directions_walk, color: Color(0xff27AE60), size: 26),
          ),
          KPIWidget(
            name: "设置",
            index: 2,
            changeListIndex: changeListIndex,
            child: const Icon(Icons.settings, color: Color(0xff2F80ED), size: 26),
          ),
          // KPIWidget(
          //   name: "More",
          //   child: Icon(Icons.more_horiz, color: Color(0xffF2994A), size: 26),
          // ),
        ],
      ),
    );
  }
}