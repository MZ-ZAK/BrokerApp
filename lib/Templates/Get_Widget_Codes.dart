import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

//void main() => runApp(ClassVariables(anyVarName:"Allah"));
void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Madinaty App',
    home: get_Widget_Codes_Full()));

class get_Widget_Codes_Full extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Get Widget Codes")),
        body: Column(children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "GF Buttons",
                style: TextStyle(decoration: TextDecoration.underline),
                textDirection: TextDirection.ltr,
              )),
          Row(children: <Widget>[
            GFButton(
              shape: GFButtonShape.standard,
              type: GFButtonType.solid,
              color: GFColors.DARK,
              size: GFSize.LARGE,
              buttonBoxShadow: true,
              text: "Hello GF1",
              onPressed: () {},
              //Optional
              //full-width block with rounded corners
              //blockButton: false,
              //Full-width button with rounded corners and no border on the left or right
              //fullWidthButton: false,
              //icon: Icon(Icons.add,color: Colors.white,),
              //position: GFPosition.end
            ),
            SizedBox(width: 20),
            GFButton(text: "Hello GF2", onPressed: () {}),
            SizedBox(width: 20),
            GFButton(text: "Hello GF3", onPressed: () {}),
          ]),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "GF Disabled Buttons",
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          Row(children: <Widget>[
            GFButton(text: "Hello GF11", onPressed: null),
            SizedBox(width: 20),
            GFButton(text: "Hello GF22", onPressed: null),
            SizedBox(width: 20),
            GFButton(text: "Hello GF33", onPressed: null),
          ]),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "GF Badge",
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          Row(children: <Widget>[
            GFBadge(
              shape: GFBadgeShape.standard,
              text: "1",
            ),
            SizedBox(width: 20),
            GFButton(
              text: "Hello GF11",
              onPressed: () {},
              icon: GFBadge(shape: GFBadgeShape.circle, child: Text("2")),
              position: GFPosition.end,
            ),
            SizedBox(width: 20),
            GFBadge(shape: GFBadgeShape.circle, text: "3"),
          ]),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "GF Icon Badge",
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GFIconBadge(
                    child: GFIconButton(
                        iconSize: GFSize.LARGE,
                        type: GFButtonType.transparent,
                        onPressed: () {},
                        shape: GFIconButtonShape.square,
                        icon: Icon(Icons.ac_unit)),
                    counterChild: GFBadge(
                        size: GFSize.SMALL,
                        shape: GFBadgeShape.circle,
                        child: Text("1"))),
                SizedBox(width: 20),
                GFIconBadge(
                    child: GFIconButton(
                        onPressed: () {}, icon: Icon(Icons.ac_unit)),
                    counterChild:
                        GFBadge(shape: GFBadgeShape.circle, child: Text("2"))),
                SizedBox(width: 20),
                GFIconBadge(
                    child: GFIconButton(
                        onPressed: () {}, icon: Icon(Icons.ac_unit)),
                    counterChild:
                        GFBadge(shape: GFBadgeShape.circle, child: Text("3"))),
              ]),
        ]));
  }
}
