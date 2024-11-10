import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///C:/xampp/htdocs/FlutterProjects/madinaty_app/lib/Screens/MyConnectivity.dart';
import 'file:///C:/xampp/htdocs/FlutterProjects/madinaty_app/lib/Screens/old/OfflinePage.dart';
import 'package:get/get.dart';

class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("You Are Offline")),
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Text("Please, Connect to the Internet", style: TextStyle(fontSize: 36))
            ])));
  }
}
