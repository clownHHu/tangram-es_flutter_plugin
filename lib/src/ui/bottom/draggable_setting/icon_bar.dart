part of tangram_flutter_ui;


class IconBar extends StatelessWidget {
  IconBar({required this.height,required this.icon});

  final double height;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
            height: height,
            width:  double.infinity,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 30,
                    color: Colors.grey,
                  )
                ]),
            child: icon,
          );

  }
}