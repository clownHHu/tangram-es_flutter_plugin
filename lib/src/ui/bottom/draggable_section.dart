part of tangram_flutter_ui;

class DraggableSection extends StatelessWidget {
  final double top;
  final double iconBarHeight;
  final Widget icon;
  final AMapLocation location;
  final Navigation navigation;
  final Function changeListIndex;
  final Function onNavigation;
  final int index;

  DraggableSection(
      {required this.top,
      required this.iconBarHeight,
      required this.icon,
      required this.location,
      required this.navigation,
      required this.changeListIndex,
      required this.index,
      required this.onNavigation});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.1,
        margin: EdgeInsets.only(top: top),
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 85.0,
            spreadRadius: 0.0,
          )
        ]),
        child: Stack(
          children: <Widget>[
            ListView(children: <Widget>[
              // ExploreRow(),
              RowWidgets(changeListIndex: changeListIndex),
              //RowImages(),
              // RowEvents(),
              RowLists(
                onNavigation: onNavigation,
                navigation: navigation,
                location: location,
                listIndex: index,
              )
            ]),
            IconBar(icon: icon, height: iconBarHeight),
          ],
        ));
  }
}
