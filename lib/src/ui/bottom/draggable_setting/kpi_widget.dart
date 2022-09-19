part of tangram_flutter_ui;

class KPIWidget extends StatefulWidget {
  KPIWidget({required this.name, required this.child,required this.index,required this.changeListIndex});
  final String name;
  final Widget child;
  final int index;
  final Function changeListIndex;
  @override
  _KPIWidgetState createState()=>_KPIWidgetState();
}
class _KPIWidgetState extends State<KPIWidget>
{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState((){
          // print("onTap");
          widget.changeListIndex(widget.index);
        });
      },
      child: SizedBox(
          width: 0.23 * MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Color(0xffeef9ff)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        blurRadius: 40,
                        color: Colors.grey,
                      )
                    ]),
                child: widget.child,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(widget.name,
                      style: const TextStyle(color: Color(0xff699ab5))))
            ],
          )),
    );
  }


}
