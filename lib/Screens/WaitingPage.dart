
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/Screens/LoginPage.dart';

class Controller extends GetxController {}

class WaitingPage extends StatelessWidget {
  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(AppConstants.SplashImagePath,
                          height: MediaQuery.of(context).size.height * .65)),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text("لم يتم تفعيل حسابك حتي الأن",style: TextStyle(fontSize: 20),),
                  GFButton(
                    size: GFSize.LARGE,
                    //color: Color.fromRGBO(248, 187, 22, 1.0),
                    color: AppConstants.grey,
                    text: "الرجوع",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Bell Gothic Light"),
                    onPressed: () {Get.to(LoginPage());},
                  )
                ],
              ),
            ),
          )),
    );
  }
}
