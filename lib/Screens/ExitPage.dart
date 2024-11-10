import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';

class ExitPage extends StatefulWidget {
  @override
  _ExitPageState createState() => _ExitPageState();
}

class _ExitPageState extends State<ExitPage> {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "إعادة تشغيل البرنامج\nمع إعادة التعيين",
            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          GFButton(
              size: GFSize.LARGE,
              color: AppConstants.orange,
              text: "Clear Cache",
              textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
              onPressed: () {
                dataBaseProvider.dispose().then((value) {
                  dataBaseProvider.removeDatabase().then((value) {
                    Route route = MaterialPageRoute(builder: (context) => ExitPage());
                    Navigator.pushReplacement(context, route);
                    SystemNavigator.pop().then((value) {
                      exit(0);
                    });
                  });
                });
              }),
        ])
      ]),
    );
  }
}
