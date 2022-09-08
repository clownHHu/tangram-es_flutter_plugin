part of tangram_flutter_base;

class TopSection extends StatelessWidget {
  final Size size;
  final List<Widget> children;

  TopSection({required this.size,required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height*0.55,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: children,
          ),

    );
  }



}