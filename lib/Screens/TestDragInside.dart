import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/Screens/PositionedDraggableIcon.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TestDragInside extends StatefulWidget {
  final double top;
  final double left;

  TestDragInside({Key key, this.top, this.left}) : super(key: key);
  @override
  _TestDragInsideState createState() => _TestDragInsideState();
}

class _TestDragInsideState extends State<TestDragInside> {
  double width = 1000;
  double height = 1000;

  double top = 1000;
  double left = 1000;

  @override
  void initState() {
    top = widget.top;
    left = widget.left;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Zoom(
        width: width,
        height: height,
        onPositionUpdate: (Offset position1) {
        },
        onScaleUpdate: (double scale1, double zoom) {
        },
        child: PositionedDraggableIcon(top: top, left: left)
      ),
    ));
  }
}
