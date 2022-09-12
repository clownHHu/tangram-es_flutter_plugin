part of tangram_flutter_ui;


class DraggableSection extends StatelessWidget {
  final double top;
  final double iconBarHeight;
  final Widget icon;
  final AMapLocation location;
  DraggableSection({required this.top, required this.iconBarHeight,required this.icon,required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.1,
        margin: EdgeInsets.only(top: this.top),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 85.0,
                  spreadRadius: 0.0,
              )
            ]
        ),
        child: Stack(
          children: <Widget>[
            ListView(children: <Widget>[
              // ExploreRow(),
              RowWidgets(),
              //RowImages(),
              // RowEvents(),
              RowLists(location: location,)
            ]),
            IconBar(
                icon: icon,
                height: iconBarHeight),
          ],
        ));
  }
}