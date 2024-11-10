import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/Screens/PlayerRecorderWidget.dart';
import 'package:madinaty_app/Screens/UserPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class ContactListItemTap extends StatefulWidget {
  @override
  _ContactListItemTapState createState() => _ContactListItemTapState();
}

class _ContactListItemTapState extends State<ContactListItemTap> {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;
  bool loading = false;
  bool active;
  TextEditingController _newContactName = TextEditingController();
  TextEditingController _newContactMobile = TextEditingController();
  TextEditingController _newContactWork = TextEditingController();
  TextEditingController _newContactCar = TextEditingController();
  TextEditingController _newContactInfo = TextEditingController();

  @override
  void dispose() {
    _newContactName.dispose();
    _newContactMobile.dispose();
    _newContactWork.dispose();
    _newContactCar.dispose();
    _newContactInfo.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    AppConstants().setcanRun(true);
    loading = false;
    active = AppConstants().getselectedContact().ACTIVEUSER == 0 ? false : true;
    _newContactName = TextEditingController(text: AppConstants().getselectedContact().CONTACTNAME.toString());
    _newContactMobile = TextEditingController(text: AppConstants().getselectedContact().CONTACTMOBILE.toString());
    _newContactWork = TextEditingController(text: AppConstants().getselectedContact().CONTACTWORK.toString());
    _newContactCar = TextEditingController(text: AppConstants().getselectedContact().CONTACTCAR.toString());
    _newContactInfo = TextEditingController(text: AppConstants().getselectedContact().INFO.toString());
  }

  bool checkSaveButtonState(){
    bool a = false;
    setState(() {
      if(AppConstants().getselectedContact().SQLID > 0 && AppConstants.idClientIsUpdating == false && AppConstants.isRecord == false)
        {
          a =  true;
        }
      else{
        a =  false;
      }
    });
    return a;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: AppConstants.orange,
              title: GestureDetector(
                onTap: () {
                  debugPrint("Back To User Page");
                  Get.offAll(UserPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 30, color: AppConstants.grey),
                    Spacer(),
                    Text(
                      "تعديل بيانات العميل او إضافة طلب",
                      style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: AppConstants.grey,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 2.0.w),
                            Flexible(
                              fit: FlexFit.loose,
                              child: GFCheckbox(
                                  size: GFSize.SMALL,
                                  activeBgColor: AppConstants.orange,
                                  onChanged: (value) {
                                    setState(() {
                                      active = value;
                                    });
                                  },
                                  value: active),
                            ),
                            SizedBox(width: 4.0.w),
                            Text(
                              "تفعيل التنبية:",
                              style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 2.0.w),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                ),
                                //height: 50.0,
                                child: TextField(
                                  controller: _newContactName,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintText: 'أدخل الاسم',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0.sp,
                                      fontFamily: "Bell Gothic Light",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.0.w),
                            Text(
                              "الأسم:",
                              style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 2.0.w),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _newContactMobile,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintText: 'أدخل الهاتف',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0.sp,
                                      fontFamily: "Bell Gothic Light",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 9.0.w),
                            GestureDetector(
                              onLongPress: () async {
                                if(_newContactMobile.text != "")
                                {
                                  FlutterPhoneDirectCaller.callNumber(_newContactMobile.text);
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.phone,color: AppConstants.orange,size: 24),
                                  Text(
                                    "الهاتف:  ",
                                    style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 2.0.w),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .60,
                                //alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _newContactWork,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintText: 'أدخل الوظيفة',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0.sp,
                                      fontFamily: "Bell Gothic Light",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.5.w),
                            Text(
                              "الوظيفة:",
                              style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 2.0.w),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .6,
                                //alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.white,
                                ),
                                //height: 50.0,
                                child: TextField(
                                  controller: _newContactCar,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintText: 'أدخل نوع السيارة',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0.sp,
                                      fontFamily: "Bell Gothic Light",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 7.5.w),
                            Text(
                              "نوع السيارة:",
                              style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 2.0.w),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        //Info _newContactInfo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "مذكرة كتابية",
                              style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .85,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                ),
                                //height: 50.0,
                                child: Scrollbar(
                                  thickness: 5,
                                  child: TextField(
                                    showCursor: true,
                                    maxLines: 8,
                                    controller: _newContactInfo,
                                    textAlign: _newContactInfo.text == "" ? TextAlign.center : TextAlign.right,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                    textDirection: TextDirection.rtl,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      border: InputBorder.none,
                                      hintText: '\n\n\nمذكرة كتابية',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18.0.sp,
                                        fontFamily: "Bell Gothic Light",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .85,
                              child: GFButton(
                                color: AppConstants.orange,
                                textColor: AppConstants.grey,
                                child: Text("إضافة سطر جديد بتاريخ اليوم", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                                onPressed: () {
                                  String year = DateTime.now().year.toString();
                                  String month = DateTime.now().month.toString();
                                  String day = DateTime.now().day.toString();
                                  bool hourMoreThan12 = DateTime.now().hour > 12 ? true : false;
                                  String dayNight = hourMoreThan12 ? "مساءً" : "صباحاً";
                                  String hour = hourMoreThan12 ? (DateTime.now().hour - 12).toString() : DateTime.now().hour.toString();
                                  String minute = DateTime.now().minute < 10 ? "0" + DateTime.now().minute.toString() : DateTime.now().minute.toString();
                                  _newContactInfo.text == ""
                                      ? _newContactInfo.text = "التاريخ : " + "سنة-شهر-يوم" + '\n' + "التاريخ : " + year + "-" + month + "-" + day + '\n' + "الساعة : " + hour + ":" + minute + " " + dayNight + '\n'
                                      : _newContactInfo.text = _newContactInfo.text +
                                          '\n' +
                                          "-------------------------" +
                                          '\n' +
                                          "التاريخ : " +
                                          "سنة-شهر-يوم" +
                                          '\n' +
                                          "التاريخ : " +
                                          year +
                                          "-" +
                                          month +
                                          "-" +
                                          day +
                                          '\n' +
                                          "الساعة : " +
                                          hour +
                                          ":" +
                                          minute +
                                          " " +
                                          dayNight +
                                          '\n';
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),
                        //PlayerRecorder
                        PlayerRecorderWidget(),
                        SizedBox(height: MediaQuery.of(context).size.height * .02),

                        //Save Modifications
                        checkSaveButtonState()
                            ? GFButton(
                                size: GFSize.LARGE,
                                //color: Color.fromRGBO(248, 187, 22, 1.0),
                                color: AppConstants.orange,
                                child: Text("حفظ التعديلات", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light")),
                                onPressed: (AppConstants().getcanRun()) == true ? () => editButton() : () {})
                            : SizedBox.shrink(),
                        loading == true
                            ? CircularProgressIndicator(
                                backgroundColor: AppConstants.orange,
                              )
                            : SizedBox.shrink(),
                        SizedBox(height: MediaQuery.of(context).size.height * .1),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  editButton() async {
    if(AppConstants.isRecord == false)
      {
        AppConstants().setcanRun(false);
        loading = true;
        if (_newContactName.text != "") {
          if (_newContactMobile.text != "") {
            if (_newContactMobile.text.length == 11) {
              String name = _newContactName.text != AppConstants().getselectedContact().CONTACTNAME.toString() ? _newContactName.text : AppConstants().getselectedContact().CONTACTNAME.toString();
              String translatedNumbers = "";
              String work = _newContactWork.text != AppConstants().getselectedContact().CONTACTWORK.toString() ? _newContactWork.text : AppConstants().getselectedContact().CONTACTWORK.toString();
              String car = _newContactCar.text != AppConstants().getselectedContact().CONTACTCAR.toString() ? _newContactCar.text : AppConstants().getselectedContact().CONTACTCAR.toString();
              String info = _newContactInfo.text != AppConstants().getselectedContact().INFO.toString() ? _newContactInfo.text : AppConstants().getselectedContact().INFO.toString();
              if (AppConstants().translateArabicNumToEng(_newContactMobile.text) != "Wrong Data") {
                translatedNumbers = AppConstants().translateArabicNumToEng(_newContactMobile.text);
                if (translatedNumbers == AppConstants().getselectedContact().CONTACTMOBILE.toString()) {
                  //PlayRec Files Copy
                  debugPrint("PlayList: " + AppConstants.playList.toString());
                  if (AppConstants.playList.toString() != "[]") {
                    Directory directory = await getApplicationSupportDirectory();

                    for (int i = 0; i < AppConstants.playList.length; i++) {
                      File file1 = File(directory.path + "/" + AppConstants.playList[i] + ".aac");

                      final checkPathExistence = await Directory(directory.path + "/FTPAudioContact/").exists();
                      if (checkPathExistence) {
                        try {
                          await file1.rename(directory.path + "/FTPAudioContact/" + AppConstants.playList[i].substring(5) + ".aac");
                          debugPrint("It Is THere!!!! And Copied");
                          AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                        } catch (e) {
                          await file1.copy(directory.path + "/FTPAudioContact/" + AppConstants.playList[i].substring(5) + ".aac");
                          AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                          await file1.delete();
                        }
                      } else {
                        Directory(directory.path + "/FTPAudioContact/").create().then((Directory directory) async {
                          try {
                            await file1.rename(directory.path + AppConstants.playList[i].substring(5) + ".aac");
                            debugPrint("It Is NOTNOTNOT THere!!!! And Copied");
                            AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                          } catch (e) {
                            await file1.copy(directory.path + AppConstants.playList[i].substring(5) + ".aac");
                            AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                            await file1.delete();
                          }
                        });
                      }
                    }
                  }
                  await new Future.delayed(const Duration(milliseconds: 500), () async {
                    debugPrint("Now will fire the PlayRec Names");
                    if (AppConstants.newVoiceLink.length > 0) {
                      for (int u11 = 0; u11 < AppConstants.newVoiceLink.length; u11++) {
                        AppConstants.playList.insert(u11, AppConstants.newVoiceLink[u11].toString());
                        if (u11 == AppConstants.newVoiceLink.length - 1) {
                          if (await AppConstants().editContactFunctionLocal(AppConstants().getselectedContact().ID, active == false ? 0 : 1, name, translatedNumbers, work, car, info, AppConstants.playList.toString())) {
                            if (AppConstants().getcanRun() == false) {
                              AppConstants().setcanRun(true);
                              AppConstants.playList = [];
                              //Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                              Get.offAll(UserPage());
                              Get.snackbar("تم تعديل بيانات العميل", "تم التعديل", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                            }
                          }
                        }
                      }
                    } else if (AppConstants.newVoiceLink.length == 0) {
                      if (await AppConstants().editContactFunctionLocal(AppConstants().getselectedContact().ID, active == false ? 0 : 1, name, translatedNumbers, work, car, info, AppConstants.playList.toString())) {
                        if (AppConstants().getcanRun() == false) {
                          AppConstants().setcanRun(true);
                          AppConstants.playList = [];
                          //Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                          Get.offAll(UserPage());
                          Get.snackbar("تم تعديل بيانات العميل", "تم التعديل", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                        }
                      }
                    }
                  });
                } else {
                  if (await AppConstants().checkMobileExistOrNotLocal(translatedNumbers) == true) {
                    //PlayRec Files Copy
                    if (AppConstants.playList.toString() != "[]") {
                      Directory directory = await getApplicationSupportDirectory();

                      for (int i = 0; i < AppConstants.playList.length; i++) {
                        File file1 = File(directory.path + "/" + AppConstants.playList[i] + ".aac");

                        final checkPathExistence = await Directory(directory.path + "/FTPAudioContact/").exists();
                        if (checkPathExistence) {
                          try {
                            await file1.rename(directory.path + "/FTPAudioContact/" + AppConstants.playList[i].substring(5) + ".aac");
                            debugPrint("It Is THere!!!! And Copied");
                            AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                          } catch (e) {
                            await file1.copy(directory.path + "/FTPAudioContact/" + AppConstants.playList[i].substring(5) + ".aac");
                            AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                            await file1.delete();
                          }
                        } else {
                          Directory(directory.path + "/FTPAudioContact/").create().then((Directory directory) async {
                            try {
                              await file1.rename(directory.path + AppConstants.playList[i].substring(5) + ".aac");
                              debugPrint("It Is NOTNOTNOT THere!!!! And Copied");
                              AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                            } catch (e) {
                              await file1.copy(directory.path + AppConstants.playList[i].substring(5) + ".aac");
                              AppConstants.playList[i] = AppConstants.playList[i].substring(5);
                              await file1.delete();
                            }
                          });
                        }
                      }
                    }
                    await new Future.delayed(const Duration(milliseconds: 500), () async {
                      if (AppConstants.newVoiceLink.length > 0) {
                        for (int u11 = 0; u11 < AppConstants.newVoiceLink.length; u11++) {
                          AppConstants.playList.insert(u11, AppConstants.newVoiceLink[u11].toString());
                          if (u11 == AppConstants.newVoiceLink.length - 1) {
                            if (await AppConstants().editContactFunctionLocal(AppConstants().getselectedContact().ID, active == false ? 0 : 1, name, translatedNumbers, work, car, info, AppConstants.playList.toString())) {
                              if (AppConstants().getcanRun() == false) {
                                AppConstants().setcanRun(true);
                                AppConstants.playList = [];
                                Get.offAll(UserPage());
                                Get.snackbar("تم تعديل بيانات العميل", "تم التعديل", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                              }
                            }
                          }
                        }
                      } else if (AppConstants.newVoiceLink.length == 0) {
                        if (await AppConstants().editContactFunctionLocal(AppConstants().getselectedContact().ID, active == false ? 0 : 1, name, translatedNumbers, work, car, info, AppConstants.playList.toString())) {
                          if (AppConstants().getcanRun() == false) {
                            AppConstants().setcanRun(true);
                            AppConstants.playList = [];
                            Get.offAll(UserPage());
                            Get.snackbar("تم تعديل بيانات العميل", "تم التعديل", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                          }
                        }
                      }
                    });
                  } else {
                    AppConstants().setcanRun(true);
                  }
                }
              } else {
                AppConstants().setcanRun(true);
              }
            } else {
              AppConstants().setcanRun(true);
              Get.snackbar("رقم الهاتف خطأ", "أدخل رقم صحيح ...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
            }
          } else {
            AppConstants().setcanRun(true);
            Get.snackbar("لم يتم إدخال رقم للهاتف", "أدخل رقم الهاتف ...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
          }
        } else {
          AppConstants().setcanRun(true);
          Get.snackbar("لم يتم إدخال اسم العميل", "أدخا اسم للعميل ...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        }
      }
    else
      {
        debugPrint("RECORDING IS ON");
      }
  }
}
