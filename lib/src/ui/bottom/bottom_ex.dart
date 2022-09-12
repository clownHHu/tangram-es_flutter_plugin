///example
// GestureDetector(
//   onPanUpdate: (DragUpdateDetails details) {
//     final double scrollPos = details.globalPosition.dy;
//     if (scrollPos < baseTop && scrollPos > searchBarHeight) {
//       setState(() {
//         top = scrollPos;
//       });
//     }
//   },
//   child: DraggableSection(
//     top: this.top == 0.0 ? baseTop : this.top,
//     searchBarHeight: searchBarHeight,
//   ),
// ),