import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:sizer/sizer.dart';

class PositionedDraggableIcon extends StatefulWidget {
  final double top;
  final double left;
  final String stage;

  PositionedDraggableIcon({Key key, this.top, this.left, this.stage}) : super(key: key);

  @override
  _PositionedDraggableIconState createState() => _PositionedDraggableIconState();
}

class _PositionedDraggableIconState extends State<PositionedDraggableIcon> {
  GlobalKey _key = GlobalKey();
  double top, left;
  double xOff, yOff;
  Offset position = Offset(0.0, 0.0);
  double scale = 1.0;
  double widthLength = 5000;
  double heightLength = 5000;

  String stage;

  bool firstTime = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    top = widget.top;
    left = widget.left;
    stage = widget.stage;
    super.initState();
    debugPrint("$left $top");
  }

  _getSizes() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    //print("SIZE of Red: $sizeRed");
  }

  _getPositions() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    //print("POSITION of Red: $positionRed ");
    top = positionRed.dy;
    left = positionRed.dx;

    //print("POSITION of Top: $top ");
    //print("POSITION of Left: $left ");
  }

  void _afterLayout(_) {
    _getSizes();
    _getPositions();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppConstants.orange,
          title: Text(
            "ضع الرقم فوق الوحدة المراد تسجيلها",
            style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),),
      backgroundColor: AppConstants.grey,
      body: Center(
        key: _key,
        child: Zoom(
          initZoom: 0,
          backgroundColor: AppConstants.grey,
            width: widthLength,
            height: heightLength,
            onPositionUpdate: (Offset position1) {
              WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
              //debugPrint("Position: $position1");
              position = position1;
            },
            onScaleUpdate: (double scale1, double zoom) {
              WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
              scale = scale1;
              debugPrint("Scale: $scale");
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Image(
                    image: Image.asset(stage,
                    //image: Image.asset("assets/Villa/Color/VG1.jpg",
                      fit: BoxFit.fill,
                  ).image,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),/*
                SvgPicture.asset(
                  "assets/Villa/Color/VG1.svg",
                  width: 3584,
                  height: 3584,
                ),*/
                Positioned(
                  top: top,
                  left: left,
                  child: Draggable(
                    child: SizedBox(
                      width: 15.0.w,
                      height: 8.0.h,
                      child: GFButton(
                        borderShape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black,width: 1.0.w),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        color: Colors.red,
                        shape: GFButtonShape.pills,
                        text: AppConstants.location,
                        textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
                        onPressed: (){}
                      ),
                    ),
                    feedback: SizedBox(
                      width: 15.0.w,
                      height: 8.0.h,
                      child: GFButton(
                          borderShape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black,width: 1.0.w),
                              borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          color: Colors.red,
                          shape: GFButtonShape.pills,
                          text: AppConstants.location,
                          textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
                          onPressed: (){}
                      ),
                    ),
                    childWhenDragging: Container(),
                    onDragEnd: (drag) {
                      setState(() {
                        top = (position.dy + drag.offset.dy - 70) / scale;
                        left = (position.dx + drag.offset.dx) / scale;

                        if (top < 0) {
                          top = 30.0;
                        } else if (top > heightLength) {
                          top = heightLength - 30;
                        }

                        if (left < 0) {
                          left = 30.0;
                        } else if (left > widthLength) {
                          left = widthLength - 30;
                        }
                        debugPrint("Scale Value: $scale , top is: $top, left is: $left");
                        setState(() {
                          AppConstants.unitLocation = Offset(left,top);
                        });
                        debugPrint("App Constants: " + AppConstants.unitLocation.toString());

                      });
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
