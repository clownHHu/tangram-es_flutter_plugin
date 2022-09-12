part of tangram_flutter_ui;

class FancyBar extends StatelessWidget {
  FancyBar({required this.height, required this.child, required this.margin,required this.onTap,required this.width});

  final double height;
  final double width;
  final Widget child;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        margin: margin,
        width:  width,
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
      ),
    );
  }
}

