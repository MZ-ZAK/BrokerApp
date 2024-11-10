import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///C:/xampp/htdocs/FlutterProjects/madinaty_app/lib/Screens/MyConnectivity.dart';
import 'package:get/get.dart';

class TestGet extends StatelessWidget {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  Widget build(BuildContext context) {
    void showAlert(BuildContext context) {
     /* Alert(
          style: AlertStyle(
              isCloseButton: false,
              titleStyle: TextStyle(
                fontSize: 12,
              )),
          context: context,
          title: "Building No:44 Data...",
          content: Column(
            children: <Widget>[
              Text(
                "Some Data...",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                "Some Data...",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                "Some Data...",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          )).show();*/
    }
    return Scaffold(
        appBar: AppBar(title: Text("The Original ")),
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Obx(() => Text("", style: TextStyle(fontSize: 36))),
              FlatButton(
                  padding: const EdgeInsets.all(0),
                  color: Colors.white,
                  child: Text(
                    '44',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 2.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic, //
                    ),
                  ),
                  onPressed: () => showAlert(context))
            ])));
  }
}
