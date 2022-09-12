part of tangram_flutter_ui;

class TopSection extends StatelessWidget {
  final Size size;
  final List<Widget> children;

  TopSection({required this.size,required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: children,
          ),

    );
  }



}