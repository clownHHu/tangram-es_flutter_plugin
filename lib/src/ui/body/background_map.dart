part of tangram_flutter_ui;

class BackgroundMap extends StatelessWidget {
  final Widget mapWidget;
  BackgroundMap({required this.mapWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: mapWidget,
    );
  }
}