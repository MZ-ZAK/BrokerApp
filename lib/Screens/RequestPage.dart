import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';

import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/Screens/MyConnectivity.dart';
import 'package:madinaty_app/Screens/UserPage.dart';
import 'package:madinaty_app/Screens/WaitingPage.dart';
import 'package:madinaty_app/Utilities/StateFulWraper.dart';

class Controller extends GetxController {}

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController _companyCodeController = TextEditingController();
  TextEditingController _companyUserMobileController = TextEditingController();
  TextEditingController _companyUserNameController = TextEditingController();
  bool loggingButtonEnabled = true;

  void initState() {
    super.initState();
    loggingButtonEnabled = true;
  }

  @override
  Widget build(context) {
    /*
    switch (AppConstants().listenToConnectivity().keys.toList()[0]) {
      case ConnectivityResult.none:
        debugPrint("Offline");
        Get.defaultDialog(
            title: "Simple Dialog", content: Text("Offline"));
        AppConstants().init();
        break;
      case ConnectivityResult.mobile:
        debugPrint("Mobile: Online");
        Get.defaultDialog(
            title: "Simple Dialog", content: Text("Mobile: Online"));
        AppConstants().init();
        break;
      case ConnectivityResult.wifi:
      //("WiFi: Online");
        debugPrint("WiFi: Online");
        Get.defaultDialog(
            title: "Simple Dialog", content: Text("WiFi: Online"));
        AppConstants().init();
        break;
    }
    */
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
                  Center(child: Image.asset(AppConstants.SplashImagePath, height: MediaQuery.of(context).size.height * .45)),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  //Center(child: Text("Please enter your company name:",style: TextStyle(fontSize: 20),textDirection: TextDirection.ltr,textAlign: TextAlign.center,)),
                  //Code
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    //alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: AppConstants.grey,
                    ),
                    //height: 50.0,
                    child: TextField(
                      controller: _companyCodeController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'أدخل رقم الشركة أو كود التفعيل ',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          fontFamily: "Bell Gothic Light",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  //Name
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    //alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: AppConstants.grey,
                    ),
                    //height: 50.0,
                    child: TextField(
                      controller: _companyUserNameController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'أدخل اسمك',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          fontFamily: "Bell Gothic Light",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  //Phone
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    //alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: AppConstants.grey,
                    ),
                    //height: 50.0,
                    child: TextField(
                      controller: _companyUserMobileController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'أدخل رقمك',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          fontFamily: "Bell Gothic Light",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  GFButton(
                      size: GFSize.LARGE,
                      //color: Color.fromRGBO(248, 187, 22, 1.0),
                      color: AppConstants.grey,
                      text: "تفعيل الطلب",
                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                      onPressed: loggingButtonEnabled == true
                          ? () async => await AppConstants().CheckInternet(context, () async {
                                loggingButtonEnabled = false;
                                setState(() {
                                  loggingButtonEnabled = false;
                                });
                                String translatedNumbersCode = "";
                                String translatedNumbersMobile = "";
                                if (AppConstants().translateArabicNumToEng(_companyCodeController.text) != "Wrong Data") {
                                  translatedNumbersCode = AppConstants().translateArabicNumToEng(_companyCodeController.text);
                                  if (AppConstants().translateArabicNumToEng(_companyUserMobileController.text) != "Wrong Data") {
                                    translatedNumbersMobile = AppConstants().translateArabicNumToEng(_companyUserMobileController.text);
                                    if (await AppConstants().requestFunction(translatedNumbersCode, _companyUserNameController.text, translatedNumbersMobile) == true) {
                                      Get.off(WaitingPage());
                                    } else {
                                      loggingButtonEnabled = true;
                                      setState(() {
                                        loggingButtonEnabled = true;
                                      });
                                      debugPrint("SERVR");
                                      Get.snackbar("كود غير صحيح", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                                    }
                                  }
                                  else
                                  {
                                    loggingButtonEnabled = true;
                                    setState(() {
                                      loggingButtonEnabled = true;
                                    });
                                    debugPrint("Mobile");
                                    Get.snackbar("رقم هاتفك غير صحيح", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                                  }
                                }
                                else
                                  {
                                    loggingButtonEnabled = true;
                                    setState(() {
                                      loggingButtonEnabled = true;
                                    });
                                    debugPrint("CODE");
                                    Get.snackbar("كود غير صحيح", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                                  }
                              })
                          : () {}),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  loggingButtonEnabled == false
                      ? CircularProgressIndicator(
                          backgroundColor: AppConstants.orange,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          )),
    );
  }
}
