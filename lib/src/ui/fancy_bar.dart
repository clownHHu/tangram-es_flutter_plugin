part of tangram_flutter_base;

class FancyBar extends StatelessWidget {
  FancyBar(
      {required this.height, required this.child, required this.margin});

  final double height;
  final Widget child;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: 46,
      margin: this.margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 30,
              color: Colors.grey,
            )
          ]),
      child: child,
    );
  }
}