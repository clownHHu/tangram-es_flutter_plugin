part of tangram_flutter_base;

class BackgroundImage extends StatelessWidget {
  final Widget mapWidget;
  BackgroundImage({required this.mapWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: mapWidget,
    );
  }
}