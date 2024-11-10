import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'file:///C:/xampp/htdocs/FlutterProjects/madinaty_app/lib/Screens/MyConnectivity.dart';
import 'file:///C:/xampp/htdocs/FlutterProjects/madinaty_app/lib/Screens/old/OfflinePage.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  //Alert alert = new Alert(context: null, title: null);

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  Future<void> _joinAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Done Successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Confirmation mail has been sent to MAIL, \nPlease check your mail... \nThanks for joining'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                //Navigator.of(context).pop();
                //Navigator.pop(context);
                //Navigator.pop(context);
                /*Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {

                  //return LoginScreen();
                  return MemberScreen();
                }));*/
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String string = "Still";
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        debugPrint("Offline");
        return Scaffold(
            appBar: AppBar(title: Text("You Are Offline")),
            body: Center(
                child: Stack(alignment: Alignment.center, children: <Widget>[
              Text("Please, Connect to the Internet",
                  style: TextStyle(fontSize: 36))
            ])));
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        debugPrint("Mobile: Online");
        return returnScaf(string);
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        debugPrint("WiFi: Online");
        return returnScaf(string);
        break;
    }
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Scaffold returnScaf(String string) {
    return Scaffold(
        appBar: AppBar(title: Text("$string")),
        body: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
          Text("$string", style: TextStyle(fontSize: 36))
        ])));
  }
}
