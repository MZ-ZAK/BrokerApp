import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:get/get.dart';
import 'package:madinaty_app/Constants/CurrencyPtBrFormatter.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/MadinatyStages.dart';
import 'package:madinaty_app/Screens/PhotoPicker.dart';
import 'package:madinaty_app/Screens/PlayRec.dart';
import 'package:madinaty_app/Screens/PlayRecWidget.dart';
import 'package:madinaty_app/Screens/TestDragInside.dart';
import 'package:madinaty_app/Screens/UserPage.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';

import 'package:sizer/sizer.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../DragScrollSheetWithFab.dart';
import '../PositionedDraggableIcon.dart';
import '../controller_example.dart';

class AddNewUnit extends StatefulWidget {
  @override
  _AddNewUnitState createState() => _AddNewUnitState();
}

class _AddNewUnitState extends State<AddNewUnit> {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;

  TextEditingController name = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  TextEditingController work = TextEditingController();

  TextEditingController unitNumber = TextEditingController();
  TextEditingController unitArea = TextEditingController();
  TextEditingController gardenArea = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController bathRooms = TextEditingController();
  TextEditingController rent = TextEditingController();
  TextEditingController cash = TextEditingController();
  TextEditingController allOver = TextEditingController();
  TextEditingController deposit = TextEditingController();
  TextEditingController paid = TextEditingController();
  TextEditingController over = TextEditingController();
  TextEditingController left = TextEditingController();
  TextEditingController months = TextEditingController();
  TextEditingController info = TextEditingController();

  //Unit Data
  int offerType = 0;
  int unit = 0;
  List<dynamic> stage = ['', 0];
  int group = 0;
  int villaStructure = 0;
  List<String> unitVillaSection = [''];
  List<String> unitAppSection = [''];
  String unitSection = '';
  List<dynamic> level = ['', 0];
  String unitType = "";
  int garden = 0;
  int furnished = 0;
  int cashOrInstall = 0;
  String wanted = "";

  bool loading = false;

  //from to
  String areaFrom = "100";
  String areaTo = "111";
  String areaValues = "";

  @override
  void dispose() {
    name.dispose();
    phone1.dispose();
    phone2.dispose();
    work.dispose();

    unitNumber.dispose();
    unitArea.dispose();
    gardenArea.dispose();
    rooms.dispose();
    bathRooms.dispose();
    rent.dispose();
    cash.dispose();
    allOver.dispose();
    deposit.dispose();
    paid.dispose();
    over.dispose();
    left.dispose();
    months.dispose();
    info.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new CurrencyPtBrFormatter(maxDigits: 12);
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
                    //debugPrint("Back To User Page");
                    Get.offAll(
                      UserPage(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 30, color: AppConstants.grey),
                      Spacer(),
                      Text(
                        "إضافة وحدة",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Bell Gothic Light"),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                )),
            backgroundColor: AppConstants.grey,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                phone1.text = AppConstants().translateArabicNumToEng(phone1.text);
                phone2.text = AppConstants().translateArabicNumToEng(phone2.text);
                unitNumber.text = AppConstants().translateArabicNumToEng(unitNumber.text);
                unitArea.text = AppConstants().translateArabicNumToEng(unitArea.text);
                gardenArea.text = AppConstants().translateArabicNumToEng(gardenArea.text);
                rooms.text = AppConstants().translateArabicNumToEng(rooms.text);
                bathRooms.text = AppConstants().translateArabicNumToEng(bathRooms.text);
                rent.text = AppConstants().translateArabicNumToEng(rent.text);
                cash.text = AppConstants().translateArabicNumToEng(cash.text);
                allOver.text = AppConstants().translateArabicNumToEng(allOver.text);
                deposit.text = AppConstants().translateArabicNumToEng(deposit.text);
                paid.text = AppConstants().translateArabicNumToEng(paid.text);
                over.text = AppConstants().translateArabicNumToEng(over.text);
                months.text = AppConstants().translateArabicNumToEng(months.text);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Owner Data
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      GFAccordion(
                          contentBackgroundColor: AppConstants.grey,
                          contentBorder: Border.all(color: AppConstants.orange),
                          titleChild: Text('بيانات المالك', textAlign: TextAlign.right, textDirection: TextDirection.rtl, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight)),
                          contentChild: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            SizedBox(height: MediaQuery.of(context).size.height * .05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    //height: 50.0,
                                    child: TextField(
                                      controller: name,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: InputBorder.none,
                                        hintText: 'أسم المالك',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontFamily: "Bell Gothic Light",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "أسم المالك",
                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .60,
                                    //alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: Colors.white,
                                    ),
                                    //height: 50.0,
                                    child: TextField(
                                      controller: phone1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: InputBorder.none,
                                        hintText: 'أدخل الهاتف',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontFamily: "Bell Gothic Light",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "الهاتف",
                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .60,
                                    //alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: Colors.white,
                                    ),
                                    //height: 50.0,
                                    child: TextField(
                                      controller: phone2,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: InputBorder.none,
                                        hintText: 'أدخل الهاتف',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontFamily: "Bell Gothic Light",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "الهاتف",
                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * .60,
                                    //alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color: Colors.white,
                                    ),
                                    //height: 50.0,
                                    child: TextField(
                                      controller: work,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: InputBorder.none,
                                        hintText: 'أدخل الوظيفة',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontFamily: "Bell Gothic Light",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "الوظيفة",
                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * .05),
                          ])),
                      //Unit Data
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      GFAccordion(
                          contentBackgroundColor: AppConstants.grey,
                          contentBorder: Border.all(color: AppConstants.orange),
                          titleChild: Text('بيانات الوحدة', textAlign: TextAlign.right, textDirection: TextDirection.rtl, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight)),
                          contentChild: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            //Unit Data Start
                            //Villa or App
                            Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              Text(
                                "شقة",
                                style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(width: 2.0.w),
                              GFRadio<int>(
                                size: GFSize.SMALL,
                                value: 2,
                                groupValue: unit,
                                onChanged: (value) {
                                  setState(() {
                                    unit = value;

                                    offerType = 0;
                                    stage = ["B1", 1];
                                    group = 11;
                                    villaStructure = 0;
                                    unitNumber.text = "";
                                    unitSection = "";
                                    level = ['', 0];
                                    unitType = "";
                                    unitArea.text = "";
                                    garden = 0;
                                    gardenArea.text = "";
                                    rooms.text = "";
                                    bathRooms.text = "";
                                    furnished = 0;

                                    rent.text = "";
                                    cash.text = "";

                                    allOver.text = "";
                                    deposit.text = "";
                                    paid.text = "";
                                    over.text = "";
                                    months.text = "";
                                    info.text = "";
                                  });
                                },
                                inactiveIcon: null,
                                activeBorderColor: AppConstants.orange,
                                radioColor: AppConstants.orange,
                              ),
                              SizedBox(width: 4.0.w),
                              Text(
                                "فيلا",
                                style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(width: 2.0.w),
                              GFRadio<int>(
                                size: GFSize.SMALL,
                                value: 1,
                                groupValue: unit,
                                onChanged: (value) {
                                  setState(() {
                                    unit = value;

                                    offerType = 0;
                                    stage = ["VG1", 1];
                                    group = 1;
                                    villaStructure = 1;
                                    unitNumber.text = "";
                                    unitSection = "";
                                    level = ['', 0];
                                    unitType = "";
                                    unitArea.text = "";
                                    garden = 0;
                                    gardenArea.text = "";
                                    rooms.text = "";
                                    bathRooms.text = "";
                                    furnished = 0;

                                    rent.text = "";
                                    cash.text = "";

                                    allOver.text = "";
                                    deposit.text = "";
                                    paid.text = "";
                                    over.text = "";
                                    months.text = "";
                                    info.text = "";
                                  });
                                },
                                inactiveIcon: null,
                                activeBorderColor: AppConstants.orange,
                                radioColor: AppConstants.orange,
                              ),
                              SizedBox(width: 4.0.w),
                              Text(
                                "نوع الوحدة",
                                style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ]),
                            SizedBox(height: MediaQuery.of(context).size.height * .02),
                            //Villa Structure
                            unit == 1
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    //Quad
                                    (stage[1] != 4 && stage[1] != 2 && stage[1] != 1)
                                        ? Text(
                                            "رباعي",
                                            style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                          )
                                        : SizedBox.shrink(),
                                    (stage[1] != 4 && stage[1] != 2 && stage[1] != 1) ? SizedBox(width: 2.0.w) : SizedBox.shrink(),

                                    (stage[1] != 4 && stage[1] != 2 && stage[1] != 1)
                                        ? GFRadio<int>(
                                            size: GFSize.SMALL,
                                            value: 3,
                                            groupValue: villaStructure,
                                            onChanged: (value) {
                                              setState(() {
                                                villaStructure = value;
                                              });
                                            },
                                            inactiveIcon: null,
                                            activeBorderColor: AppConstants.orange,
                                            radioColor: AppConstants.orange,
                                          )
                                        : SizedBox.shrink(),
                                    (stage[1] != 4 && stage[1] != 2 && stage[1] != 1) ? SizedBox(width: 4.0.w) : SizedBox.shrink(),
                                    //Twin
                                    Text(
                                      "ثنائي",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 2,
                                      groupValue: villaStructure,
                                      onChanged: (value) {
                                        setState(() {
                                          villaStructure = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 4.0.w),
                                    //Single
                                    Text(
                                      "أحادي",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 1,
                                      groupValue: villaStructure,
                                      onChanged: (value) {
                                        setState(() {
                                          villaStructure = value;
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit == 1 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Stage
                            unit > 0
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    unit == 1 && villaStructure > 0
                                        ? returnVillaStage()
                                        : unit == 2
                                            ? returnAppStage()
                                            : SizedBox.shrink(),
                                    SizedBox(width: 20.0.w),
                                    Text(
                                      "المرحلة",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Group
                            unit > 0
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    unit == 1 && stage[1] > 0 ? returnGroupVilla() : SizedBox.shrink(),
                                    unit == 2 && stage[1] > 0 ? returnGroupApp() : SizedBox.shrink(),
                                    SizedBox(width: 17.0.w),
                                    Text(
                                      "المجموعة",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //unitNumber
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: unitNumber,
                                            onChanged: (string) {
                                              unitSection = '';
                                            },
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'رقم المبني',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "رقم المبني",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Add Location
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GFButton(
                                          color: AppConstants.orange,
                                          textColor: AppConstants.grey,
                                          child: Text("أضافة", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                                          onPressed: () async {
                                            if (unitNumber.text.isEmpty == false) {
                                              FocusScope.of(context).unfocus();
                                              await new Future.delayed(const Duration(milliseconds: 100), () {
                                                AppConstants.location = AppConstants().translateArabicNumToEngWithNoMark(unitNumber.text);
                                                Get.to(PositionedDraggableIcon(stage: AppConstants.getStageImage(stage[0], true), left: AppConstants.unitLocation.dx, top: AppConstants.unitLocation.dy));
                                                //Get.to(PositionedDraggableIcon(stage: AppConstants.getStageImage(stage[0], false), left: MediaQuery.of(context).size.width*5, top: MediaQuery.of(context).size.height));
                                              });
                                            }
                                          }),
                                      Text(
                                        "أضافة الموقع علي الخريطة",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unitNumber.text.isEmpty == false && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Level
                            unit == 2
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    unit == 2 ? returnAppLevel() : SizedBox.shrink(),
                                    unit == 2 ? SizedBox(width: 20.0.w) : SizedBox.shrink(),
                                    unit == 2
                                        ? Text(
                                            "الدور",
                                            style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                          )
                                        : SizedBox.shrink(),
                                  ])
                                : SizedBox.shrink(),
                            unit == 2 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //unitSection
                            ((stage[1] == 3 || stage[1] == 4 || stage[1] == 5) && (villaStructure == 2 || villaStructure == 3) && unit == 1) ||
                                    (stage[1] == 2 && group == 10 && checkIfUnitGroupIs() && unit == 1) ||
                                    unit == 2 ||
                                    (unit == 1 && stage[1] == 1 && group == 8 && checkIfUnitGroupIsVG1() && villaStructure == 2)
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    unit == 1 && stage[1] > 0 ? returnUnitSectionVilla() : SizedBox.shrink(),
                                    unit == 2 && stage[1] > 0 ? returnUnitSectionApp() : SizedBox.shrink(),
                                    SizedBox(width: 14.0.w),
                                    Text(
                                      "رقم الوحدة",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //UnitType
                            unit > 0
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Text(
                                      areaValues,
                                      style: TextStyle(color: Colors.white, fontSize: 16.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 10.0.w),
                                    unit == 1
                                        ? returnVillaUnitType()
                                        : unit == 2
                                            ? returnAppUnitType()
                                            : SizedBox.shrink(),
                                    SizedBox(width: 10.0.w),
                                    Text(
                                      "نموذج",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Area for both
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: unitArea,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'مساحة الوحدة',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "مساحة\nالوحدة",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Garden Or no
                            unit == 2 && level[1] == 0
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    unit == 2 && level[1] == 0
                                        ? Text(
                                            "لا يوجد",
                                            style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                          )
                                        : SizedBox.shrink(),
                                    unit == 2 && level[1] == 0 ? SizedBox(width: 2.0.w) : SizedBox.shrink(),

                                    unit == 2 && level[1] == 0
                                        ? GFRadio<int>(
                                            size: GFSize.SMALL,
                                            value: 2,
                                            groupValue: garden,
                                            onChanged: (value) {
                                              setState(() {
                                                garden = value;
                                                gardenArea.text = "";
                                              });
                                            },
                                            inactiveIcon: null,
                                            activeBorderColor: AppConstants.orange,
                                            radioColor: AppConstants.orange,
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(width: 10.0.w),
                                    //Twin
                                    Text(
                                      "يوجد",
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    unit == 2 && level[1] == 0 ? SizedBox(width: 2.0.w) : SizedBox.shrink(),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 1,
                                      groupValue: garden,
                                      onChanged: (value) {
                                        setState(() {
                                          garden = value;
                                          gardenArea.text = "";
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 15.0.w),
                                    Text(
                                      "حديقة",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),
                            unit == 2 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Area for Garden
                            unit == 1 || (level[1] == 0 && garden == 1)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: gardenArea,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'مساحة الحديقة',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "مساحة\nالحديقة",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit == 1 || (level[1] == 0 && garden == 1) ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Rooms for both
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: rooms,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'عدد الغرف',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "عدد الغرف",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //bathRooms for both
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: bathRooms,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'عدد الحمامات',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "عدد\nالحمامات",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Furnished
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          //Furnished
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              //Private Furnished
                                              Row(
                                                children: [
                                                  Text(
                                                    "خاص",
                                                    style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                                    textDirection: TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  SizedBox(width: 2.0.w),
                                                  GFRadio<int>(
                                                    size: GFSize.SMALL,
                                                    value: 2,
                                                    groupValue: furnished,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        furnished = value;
                                                      });
                                                    },
                                                    inactiveIcon: null,
                                                    activeBorderColor: AppConstants.orange,
                                                    radioColor: AppConstants.orange,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 8.0.w),
                                              //Company
                                              Row(
                                                children: [
                                                  Text(
                                                    "شركة",
                                                    style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                                    textDirection: TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  SizedBox(width: 2.0.w),
                                                  GFRadio<int>(
                                                    size: GFSize.SMALL,
                                                    value: 1,
                                                    groupValue: furnished,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        furnished = value;
                                                      });
                                                    },
                                                    inactiveIcon: null,
                                                    activeBorderColor: AppConstants.orange,
                                                    radioColor: AppConstants.orange,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                            //NOT Furnished
                                            Row(
                                              children: [
                                                Text(
                                                  "لا",
                                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(width: 2.0.w),
                                                GFRadio<int>(
                                                  size: GFSize.SMALL,
                                                  value: 4,
                                                  groupValue: furnished,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      furnished = value;
                                                    });
                                                  },
                                                  inactiveIcon: null,
                                                  activeBorderColor: AppConstants.orange,
                                                  radioColor: AppConstants.orange,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 3.0.w),
                                            //rent
                                            Row(
                                              children: [
                                                Text(
                                                  "مفروش",
                                                  style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(width: 2.0.w),
                                                GFRadio<int>(
                                                  size: GFSize.SMALL,
                                                  value: 3,
                                                  groupValue: furnished,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      furnished = value;
                                                    });
                                                  },
                                                  inactiveIcon: null,
                                                  activeBorderColor: AppConstants.orange,
                                                  radioColor: AppConstants.orange,
                                                ),
                                              ],
                                            ),
                                          ])
                                        ],
                                      ),
                                      SizedBox(width: 12.0.w),
                                      Text(
                                        "تشطيب",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                          ])),
                      //Money Section
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      GFAccordion(
                          contentBackgroundColor: AppConstants.grey,
                          contentBorder: Border.all(color: AppConstants.orange),
                          titleChild: Text('البيانات المالية', textAlign: TextAlign.right, textDirection: TextDirection.rtl, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight)),
                          contentChild: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            //offer type
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                            //Offer Types Radios
                            unit > 0
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    //Near
                                    Text(
                                      "الأقرب",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 3,
                                      groupValue: offerType,
                                      onChanged: (value) {
                                        setState(() {
                                          offerType = value;
                                          cashOrInstall = 0;
                                          rent.text = "";
                                          cash.text = "";
                                          allOver.text = "";
                                          deposit.text = "";
                                          paid.text = "";
                                          over.text = "";
                                          months.text = "";
                                        });
                                      },
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 8.0.w),
                                    Text(
                                      "إيجار",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 2,
                                      groupValue: offerType,
                                      onChanged: (value) {
                                        setState(() {
                                          offerType = value;
                                          cashOrInstall = 0;
                                          rent.text = "";
                                          cash.text = "";
                                          allOver.text = "";
                                          deposit.text = "";
                                          paid.text = "";
                                          over.text = "";
                                          months.text = "";
                                        });
                                      },
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 8.0.w),
                                    Text(
                                      "بيع",
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 1,
                                      groupValue: offerType,
                                      onChanged: (value) {
                                        setState(() {
                                          offerType = value;
                                          cashOrInstall = 0;
                                          rent.text = "";
                                          cash.text = "";
                                          allOver.text = "";
                                          deposit.text = "";
                                          paid.text = "";
                                          over.text = "";
                                          months.text = "";
                                        });
                                      },
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                  ])
                                : SizedBox.shrink(),

                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                            //Rent Value
                            unit > 0 && (offerType == 2 || offerType == 3)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: rent,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              //prefixText: _currency,
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'الإيجار',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "الإيجار",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            unit > 0 && (offerType == 2 || offerType == 3) ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                            //Cash or Install
                            unit > 0 && (offerType == 1 || offerType == 3)
                                ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    //Not Furnished
                                    Text(
                                      "تقسيط",
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 2,
                                      groupValue: cashOrInstall,
                                      onChanged: (value) {
                                        setState(() {
                                          cashOrInstall = value;
                                          cash.text = "";
                                          allOver.text = "";
                                          deposit.text = "";
                                          paid.text = "";
                                          over.text = "";
                                          months.text = "";
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 8.0.w),
                                    Text(
                                      "كاش",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(width: 2.0.w),
                                    GFRadio<int>(
                                      size: GFSize.SMALL,
                                      value: 1,
                                      groupValue: cashOrInstall,
                                      onChanged: (value) {
                                        setState(() {
                                          cashOrInstall = value;
                                          cash.text = "";
                                          allOver.text = "";
                                          deposit.text = "";
                                          paid.text = "";
                                          over.text = "";
                                          months.text = "";
                                        });
                                      },
                                      inactiveIcon: null,
                                      activeBorderColor: AppConstants.orange,
                                      radioColor: AppConstants.orange,
                                    ),
                                    SizedBox(width: 8.0.w),
                                    Text(
                                      "المطلوب",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                    ),
                                  ])
                                : SizedBox.shrink(),

                            unit > 0 && (offerType == 1 || offerType == 3) ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //cash Value
                            cashOrInstall == 1 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: cash,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'سعر البيع المطلوب',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "سعر البيع\nالمطلوب",
                                        style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 1 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Over All
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: allOver,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'إجمالي العقد',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "إجمالي\nالعقد",
                                        style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //deposit
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: deposit,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'وديعة',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "وديعة",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //paid
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: paid,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'المدفوع',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "المدفوع",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Over
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: over,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'فوق المدفوع',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                            inputFormatters: [
                                              //WhitelistingTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.digitsOnly,
                                              maskFormatter,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "فوق\nالمدفوع",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //wanted
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          child: SizedBox(
                                            width: 85,
                                            height: 30,
                                            child: Text(
                                              intFormat(wantedIs()),
                                              style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          //height: 50.0,
                                        ),
                                      ),
                                      Text(
                                        "المطلوب",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //Left
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          child: SizedBox(
                                            width: 85,
                                            height: 30,
                                            child: Text(
                                              intFormat(leftIs()),
                                              style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          //height: 50.0,
                                        ),
                                      ),
                                      Text(
                                        "المتبقي",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),

                            cashOrInstall == 2 && unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                            //months
                            cashOrInstall == 2 && unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * .60,
                                          //alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            color: Colors.white,
                                          ),
                                          //height: 50.0,
                                          child: TextField(
                                            controller: months,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              alignLabelWithHint: true,
                                              border: InputBorder.none,
                                              hintText: 'الشهور المتبقية',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0.sp,
                                                fontFamily: "Bell Gothic Light",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "الشهور\nالمتبقية",
                                        style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                          ])),
                      //Info Section
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      GFAccordion(
                          contentBackgroundColor: AppConstants.grey,
                          contentBorder: Border.all(color: AppConstants.orange),
                          titleChild: Text('بيانات إضافية', textAlign: TextAlign.right, textDirection: TextDirection.rtl, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight)),
                          contentChild: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            //Info
                            unit > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "مذكرة كتابية",
                                        style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            unit > 0
                                ? Row(
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
                                              controller: info,
                                              textAlign: info.text == "" ? TextAlign.center : TextAlign.right,
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
                                  )
                                : SizedBox.shrink(),
                            unit > 0
                                ? Row(
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
                                            info.text == ""
                                                ? info.text = "التاريخ : " + "سنة-شهر-يوم" + '\n' + "التاريخ : " + year + "-" + month + "-" + day + '\n' + "الساعة : " + hour + ":" + minute + " " + dayNight + '\n'
                                                : info.text = info.text +
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
                                  )
                                : SizedBox.shrink(),
                            unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .04) : SizedBox.shrink(),
                            /*
                        //photo
                        unit > 0 ? PhotoPicker() : SizedBox.shrink(),
                        unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

                        //Voice Recorder
                        unit > 0 ? PlayRecWidget() : SizedBox.shrink(),
                        unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                        */
                          ])),

                      //Save Data
                      whatToSave() > 0
                          ? GFButton(
                              size: GFSize.LARGE,
                              //color: Color.fromRGBO(248, 187, 22, 1.0),
                              color: AppConstants.orange,
                              child: Text("حفظ التعديلات", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light")),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                phone1.text = AppConstants().translateArabicNumToEngWithNoMark(phone1.text);
                                phone2.text = AppConstants().translateArabicNumToEngWithNoMark(phone2.text);
                                unitNumber.text = AppConstants().translateArabicNumToEngWithNoMark(unitNumber.text);
                                unitArea.text = AppConstants().translateArabicNumToEngWithNoMark(unitArea.text);
                                gardenArea.text = AppConstants().translateArabicNumToEngWithNoMark(gardenArea.text);
                                rooms.text = AppConstants().translateArabicNumToEngWithNoMark(rooms.text);
                                bathRooms.text = AppConstants().translateArabicNumToEngWithNoMark(bathRooms.text);
                                rent.text = AppConstants().translateArabicNumToEngWithNoMark(rent.text);
                                cash.text = AppConstants().translateArabicNumToEngWithNoMark(cash.text);
                                allOver.text = AppConstants().translateArabicNumToEngWithNoMark(allOver.text);
                                deposit.text = AppConstants().translateArabicNumToEngWithNoMark(deposit.text);
                                paid.text = AppConstants().translateArabicNumToEngWithNoMark(paid.text);
                                over.text = AppConstants().translateArabicNumToEngWithNoMark(over.text);
                                months.text = AppConstants().translateArabicNumToEngWithNoMark(months.text);

                                //SAVE DATA
                                if (unit == 1) {
                                  if (await dataBaseProvider.aDCheckUnitNumber(unit, stage[1], "V" + group.toString(), int.parse(unitNumber.text), 0, unitSection)) {
                                    //debugPrint("Villa Found");
                                    Get.snackbar("لا يجوز ادخال وحدة مرتين", "راجع قائمة الوحدات ...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                  else {
                                    //debugPrint("Villa NOT Found");
                                    int unitInserted1 = await dataBaseProvider.aDInsertUnit(AllData.withNoID(
                                        0,
                                        AppConstants().getcurrentUserData().OwnerId,
                                        AppConstants().getcurrentUserData().SQLID,
                                        AppConstants().getcurrentUserData().Name,
                                        "",
                                        name.text,
                                        phone1.text,
                                        phone2.text,
                                        work.text,
                                        unit,
                                        offerType,
                                        stage[1],
                                        "V" + group.toString(),
                                        villaStructure,
                                        unitNumber.text != "" ? int.parse(unitNumber.text) : 0,
                                        unitSection,
                                        level[1],
                                        unitType,
                                        unitArea.text != "" ? int.parse(unitArea.text) : 0,
                                        garden,
                                        gardenArea.text != "" ? int.parse(gardenArea.text) : 0,
                                        rooms.text != "" ? int.parse(rooms.text) : 0,
                                        bathRooms.text != "" ? int.parse(bathRooms.text) : 0,
                                        furnished,
                                        rent.text != "" ? int.parse(rent.text) : 0,
                                        cash.text != "" ? int.parse(cash.text) : 0,
                                        allOver.text != "" ? int.parse(allOver.text) : 0,
                                        deposit.text != "" ? int.parse(deposit.text) : 0,
                                        paid.text != "" ? int.parse(paid.text) : 0,
                                        over.text != "" ? int.parse(over.text) : 0,
                                        wanted != "" ? int.parse(wanted) : 0,
                                        left.text != "" ? int.parse(left.text) : 0,
                                        months.text != "" ? int.parse(months.text) : 0,
                                        info.text,
                                        //voiceLink
                                        //AppConstants.playList.toString(),
                                        "[]",
                                        //photoLink
                                        //AppConstants.photoList.toString(),
                                        "[]",
                                        //Location
                                        [AppConstants.unitLocation.dx, AppConstants.unitLocation.dy].toString(),
                                        AppConstants().getcurrentUserData().SQLID,
                                        AppConstants().getcurrentUserData().Name,
                                        1));
                                    if (unitInserted1 > 0) {
                                      List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
                                      if (allDataUnits != null) {
                                        AppConstants().setAllDataFromLiteUnits(allDataUnits);
                                        List<List> allDataVillaStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 1", debugCode: "stage", exFor: 'stage');
                                        if (allDataVillaStages != null) {
                                          AppConstants().setAllDataFromLiteVillaStages(allDataVillaStages);
                                          int syncInsertOperation = await dataBaseProvider.syncInsertOperation(ServerSync.withNoID(AppConstants().currentUserData.SQLID, AppConstants().currentUserData.OwnerId, "allData", unitInserted1, 'Insert'));
                                          loading = false;
                                          //debugPrint("Villa Data Stored Thanks God");
                                          AppConstants.playList = [];
                                          AppConstants.photoList = [];
                                          Get.offAll(UserPage());
                                          Get.snackbar("تم ادخال الوحدة", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                                        }
                                      }
                                    }
                                  }
                                }
                                else if (unit == 2) {
                                  if (await dataBaseProvider.aDCheckUnitNumber(unit, stage[1], group.toString(), int.parse(unitNumber.text), level[1], unitSection)) {
                                    //debugPrint("App Found");
                                    Get.snackbar("لا يجوز ادخال وحدة مرتين", "راجع قائمةالوحدات ...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                                    setState(() {
                                      loading = false;
                                    });
                                  } else {
                                    //debugPrint("App Not Found");
                                    List<Map> appUnitNumber = await dataBaseProvider.aDCheckAppUnitNumber(unit, stage[1], group.toString(), int.parse(unitNumber.text));
                                    if(appUnitNumber == null || appUnitNumber != null)
                                      {
                                        if(appUnitNumber != null)
                                        {
                                          //debugPrint(jsonDecode(appUnitNumber[0]['mapLoc'])[0].toString());

                                          double xValue = jsonDecode(appUnitNumber[0]['mapLoc'])[0];
                                          double yValue = jsonDecode(appUnitNumber[0]['mapLoc'])[1];

                                          AppConstants.unitLocation =  Offset(xValue,yValue);
                                        }
                                        int nUFL = await dataBaseProvider.aDInsertUnit(AllData.withNoID(
                                            0,
                                            AppConstants().getcurrentUserData().OwnerId,
                                            AppConstants().getcurrentUserData().SQLID,
                                            AppConstants().getcurrentUserData().Name,
                                            "",
                                            name.text,
                                            phone1.text,
                                            phone2.text,
                                            work.text,
                                            unit,
                                            offerType,
                                            stage[1],
                                            group.toString(),
                                            0,
                                            unitNumber.text != "" ? int.parse(unitNumber.text) : 0,
                                            unitSection,
                                            level[1],
                                            unitType,
                                            unitArea.text != "" ? int.parse(unitArea.text) : 0,
                                            garden,
                                            gardenArea.text != "" ? int.parse(gardenArea.text) : 0,
                                            rooms.text != "" ? int.parse(rooms.text) : 0,
                                            bathRooms.text != "" ? int.parse(bathRooms.text) : 0,
                                            furnished,
                                            rent.text != "" ? int.parse(rent.text) : 0,
                                            cash.text != "" ? int.parse(cash.text) : 0,
                                            allOver.text != "" ? int.parse(allOver.text) : 0,
                                            deposit.text != "" ? int.parse(deposit.text) : 0,
                                            paid.text != "" ? int.parse(paid.text) : 0,
                                            over.text != "" ? int.parse(over.text) : 0,
                                            wanted != "" ? int.parse(wanted) : 0,
                                            left.text != "" ? int.parse(left.text) : 0,
                                            months.text != "" ? int.parse(months.text) : 0,
                                            info.text,
                                            //voiceLink
                                            //AppConstants.playList.toString(),
                                            "[]",
                                            //photoLink
                                            //AppConstants.photoList.toString(),
                                            "[]",
                                            //Location
                                            [AppConstants.unitLocation.dx, AppConstants.unitLocation.dy].toString(),
                                            AppConstants().getcurrentUserData().SQLID,
                                            AppConstants().getcurrentUserData().Name,
                                            1
                                          ));
                                        if (nUFL > 0) {
                                          List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
                                          if (allDataUnits != null) {
                                            AppConstants().setAllDataFromLiteUnits(allDataUnits);
                                            List<List> allDataAppStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 2", debugCode: "stage", exFor: 'stageApp');
                                            if (allDataAppStages != null) {
                                              AppConstants().setAllDataFromLiteAppStages(allDataAppStages);
                                              int syncInsertOperation = await dataBaseProvider.syncInsertOperation(ServerSync.withNoID(AppConstants().currentUserData.SQLID, AppConstants().currentUserData.OwnerId, "allData", nUFL, 'Insert'));
                                              loading = false;
                                              //debugPrint("App Data Stored Thanks God");
                                              AppConstants.playList = [];
                                              AppConstants.photoList = [];
                                              Get.offAll(UserPage());
                                              Get.snackbar("تم ادخال الوحدة", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                                            }
                                          }
                                        }
                                      }
                                  }
                                }
                              })
                          : SizedBox.shrink(),

                      loading == true
                          ? Container(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.orange),
                                //value: event == null ? 0 : (event.cumulativeBytesLoaded / event.expectedTotalBytes.).toDouble(),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  )
                ]),
              ),
            )));
  }

  int whatToSave() {
    if (name.text != "" && phone1.text != "" && AppConstants.unitLocation != Offset(1800.0, 640.0)) {
      //if (name.text != "" && phone1.text != "") {
      if (unit == 1) {
        if (villaStructure > 0 && stage[1] != 0 && group > 0 && unitNumber.text != "" && unitType != "") {
          if (offerType == 1) {
            if (cashOrInstall == 1 && cash.text != "") {
              ////debugPrint("Villa Sell and Cash Only");
              return 1;
            } else if (cashOrInstall == 2 && allOver.text != "" && deposit.text != "" && paid.text != "" && over.text != "" && months.text != "") {
              ////debugPrint("Villa Sell and Installments Only");
              return 2;
            }
          }
          if (offerType == 2) {
            if (rent.text != "") {
              ////debugPrint("Villa Rent Only");
              return 3;
            }
          } else if (offerType == 3) {
            if (rent.text != "") {
              if (cashOrInstall == 1 && cash.text != "") {
                ////debugPrint("Villa Cash Or Rent");
                return 4;
              } else if (cashOrInstall == 2 && allOver.text != "" && deposit.text != "" && paid.text != "" && over.text != "" && months.text != "") {
               // //debugPrint("Villa Install Or Rent");
                return 5;
              }
            }
          }
        }
      } else if (unit == 2) {
        if (stage[1] != 0 && group > 0 && unitNumber.text != "" && unitSection != "" && unitType != "") {
          if (offerType == 1) {
            if (cashOrInstall == 1 && cash.text != "") {
              ////debugPrint("App Sell and Cash Only");
              return 11;
            } else if (cashOrInstall == 2 && allOver.text != "" && deposit.text != "" && paid.text != "" && over.text != "" && months.text != "") {
              ////debugPrint("App Sell and Installments Only");
              return 12;
            }
          }
          if (offerType == 2) {
            if (rent.text != "") {
              ////debugPrint("App Rent Only");
              return 13;
            }
          } else if (offerType == 3) {
            if (rent.text != "") {
              if (cashOrInstall == 1 && cash.text != "") {
                //debugPrint("App Cash Or Rent");
                return 14;
              } else if (cashOrInstall == 2 && allOver.text != "" && deposit.text != "" && paid.text != "" && over.text != "" && months.text != "") {
                ////debugPrint("App Install Or Rent");
                return 15;
              }
            }
          }
        }
      }
    }
    return 0;
  }

  int getIntOnly(String number) {
    String integerValue = "";
    for (int i = 0; i < number.length; i++) {
      if (number[i] != ",") {
        integerValue = integerValue + number[i];
      }
    }
    ////debugPrint(integerValue);
    return int.parse(integerValue);
  }

  String intFormat(int number) {
    String integerValue = number.toString();
    String newInteger = "";
    int k = 0;
    for (int i = integerValue.length - 1; i >= 0; i--) {
      k++;
      if (k % 4 == 0 && i != integerValue.length - 1) {
        newInteger = "," + newInteger;
        k = 1;
      }
      newInteger = integerValue[i] + newInteger;
    }
    ////debugPrint("Int is : " + newInteger);
    return newInteger;
  }

  int wantedIs() {
    int wanted1 = 0;
    int paid1 = AppConstants().translateArabicNumToEng(paid.text) == "" ? 0 : getIntOnly(AppConstants().translateArabicNumToEng(paid.text));
    int over1 = AppConstants().translateArabicNumToEng(over.text) == "" ? 0 : getIntOnly(AppConstants().translateArabicNumToEng(over.text));

    wanted1 = paid1 + over1;
    return wanted1;
  }

  int leftIs() {
    left.text = "";
    int left1 = 0;
    int deposit1 = AppConstants().translateArabicNumToEng(deposit.text) == "" ? 0 : getIntOnly(AppConstants().translateArabicNumToEng(deposit.text));
    int paid1 = AppConstants().translateArabicNumToEng(paid.text) == "" ? 0 : getIntOnly(AppConstants().translateArabicNumToEng(paid.text));
    int allOver1 = AppConstants().translateArabicNumToEng(allOver.text) == "" ? 0 : getIntOnly(AppConstants().translateArabicNumToEng(allOver.text));

    left1 = (allOver1 + deposit1) - (paid1);
    return left1;
  }

  bool checkIfUnitGroupIs() {
    for (int i = 0; i < MadinatyStages.VG2V10.length; i++) {
      if (unitNumber.text == MadinatyStages.VG2V10[i].toString()) {
        return true;
      }
    }
    return false;
  }

  bool checkIfUnitGroupIsVG1() {
    for (int i = 0; i < MadinatyStages.VG1V8.length; i++) {
      if (unitNumber.text == MadinatyStages.VG1V8[i].toString()) {
        return true;
      }
    }
    return false;
  }

  DropdownButton returnVillaStage() {
    setState(() {
      if (unit == 1 && stage[0] == "") {
        stage = ["VG1", 1];
      } else if (unit == 1 && stage[0][0] != "V") {
        stage = ["VG1", 1];
      }
    });
    return DropdownButton<String>(
      value: stage[0],
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          stage[0] = newValue;
          switch (stage[0]) {
            case "VG1":
              stage[1] = 1;
              villaStructure = 1;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              break;
            case "VG2":
              stage[1] = 2;
              villaStructure = 1;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              break;
            case "VG3":
              stage[1] = 3;
              villaStructure = 1;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              break;
            case "VG4":
              stage[1] = 4;
              villaStructure = 1;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              break;
            case "VG5":
              stage[1] = 5;
              villaStructure = 1;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              break;
            default:
              break;
          }
          //debugPrint("Name: " + stage[0] + ", with a value: " + stage[1].toString());
        });
      },

      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: <List<dynamic>>[MadinatyStages.VG1, MadinatyStages.VG2, MadinatyStages.VG3, MadinatyStages.VG4, MadinatyStages.VG5].map<DropdownMenuItem<String>>((List<dynamic> value) {
        return DropdownMenuItem<String>(
          value: value[0],
          child: Text(
            value[0],
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnAppStage() {
    setState(() {
      if (unit == 2 && stage[0] == "") {
        stage = ["B1", 1];
      } else if (unit == 2 && stage[0][0] != "B") {
        stage = ["B1", 1];
      }
    });
    return DropdownButton<String>(
      value: stage[0],
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          stage[0] = newValue;
          switch (stage[0]) {
            case "B1":
              stage[1] = 1;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "100";
              areaTo = "111";
              break;
            case "B2":
              stage[1] = 2;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "177";
              areaTo = "211";
              break;
            case "B3":
              stage[1] = 3;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "177";
              areaTo = "211";
              break;
            case "B6":
              stage[1] = 6;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "78";
              areaTo = "146";
              break;
            case "B7":
              stage[1] = 7;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "42";
              areaTo = "69";
              break;
            case "B8":
              stage[1] = 8;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "-";
              areaTo = "-";
              break;
            case "B10":
              stage[1] = 10;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "42";
              areaTo = "69";
              break;
            case "B11":
              stage[1] = 11;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "46";
              areaTo = "82";
              break;
            case "B12":
              stage[1] = 12;
              villaStructure = 0;
              unitNumber.text = "";
              unitSection = "";
              unitType = "";
              areaFrom = "56";
              areaTo = "78";
              break;
            default:
              break;
          }
          //debugPrint("Name: " + stage[0] + ", with a value: " + stage[1].toString());
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: <List<dynamic>>[MadinatyStages.B1, MadinatyStages.B2, MadinatyStages.B3, MadinatyStages.B6, MadinatyStages.B7, MadinatyStages.B8, MadinatyStages.B10, MadinatyStages.B11, MadinatyStages.B12]
          .map<DropdownMenuItem<String>>((List<dynamic> value) {
        return DropdownMenuItem<String>(
          value: value[0],
          child: Text(
            value[0],
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnGroupVilla() {
    List<int> menu = [];
    bool found = false;
    if (unit == 1) {
      switch (stage[1]) {
        case 1:
          menu = [1, 2, 3, 4, 5, 6, 7, 8, 9];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 1;
          }
          break;
        case 2:
          menu = [10, 11, 12, 13];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 10;
          }
          break;
        case 3:
          menu = [23, 24];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 23;
          }
          break;
        case 4:
          menu = [14, 15, 16, 17];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 14;
          }
          break;
        case 5:
          menu = [18, 19, 20, 21, 22];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 18;
          }
          break;
        default:
          break;
      }
    }
    return DropdownButton<String>(
      value: group.toString(),
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          group = int.parse(newValue);
        });
      },
      items: menu.map<DropdownMenuItem<String>>((int value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(
            value.toString(),
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnGroupApp() {
    List<int> menu = [];
    bool found = false;
    //123678 10 11
    if (unit == 2) {
      switch (stage[1]) {
        case 1:
          menu = [11, 12, 13, 14, 15, 16, 17, 18];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 11;
          }
          break;
        case 2:
          menu = [21, 22, 23, 24, 25, 26];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 21;
          }
          break;
        case 3:
          menu = [31, 32, 33, 34];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 31;
          }
          break;
        case 6:
          menu = [61, 62, 63, 64, 65, 66, 67, 68, 69, 70];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 61;
          }
          break;
        case 7:
          menu = [71, 72, 73, 74];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 71;
          }
          break;
        case 8:
          menu = [81, 82, 83, 84, 85, 86, 87, 88, 89];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 81;
          }
          break;
        case 10:
          menu = [101, 102, 103, 104];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 101;
          }
          break;
        case 11:
          menu = [111, 112, 113, 114];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 111;
          }
          break;
        case 12:
          menu = [121, 122, 123, 124, 125];
          for (int i = 0; i < menu.length; i++) {
            if (group == menu[i]) {
              found = true;
            }
          }
          if (found == false) {
            group = 121;
          }
          break;
        default:
          break;
      }
    }
    returnAreaValue();
    return DropdownButton<String>(
      value: group.toString(),
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          group = int.parse(newValue);
        });
      },
      items: menu.map<DropdownMenuItem<String>>((int value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(
            value.toString(),
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnUnitSectionVilla() {
    bool found = false;
    if (unit == 1 && stage[1] == 2) {
      found = false;
      if (unitNumber.text == "173") {
        unitVillaSection = ['1', '2', '3']; //ABC
      } else {
        unitVillaSection = ['1', '2']; //AB
      }
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
    } else if (unit == 1 && villaStructure == 2 && stage[1] == 4) {
      found = false;
      unitVillaSection = ['1', '2']; //AB
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
      //(unit == 1 && stage[1] == 1 && group == 8 && checkIfUnitGroupIsVG1())
    } else if (unit == 1 && villaStructure == 2 && stage[1] == 1 && group == 8) {
      found = false;
      unitVillaSection = ['1', '2']; //AB
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
    } else if (unit == 1 && villaStructure == 2 && (stage[1] == 3 || stage[1] == 5)) {
      found = false;
      unitVillaSection = ['1', '2'];
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
    } else if (unit == 1 && villaStructure == 3 && (stage[1] == 3 || stage[1] == 5)) {
      found = false;
      unitVillaSection = ['1', '2', '3', '4'];
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
    } else if (unit == 1 && villaStructure == 2 && stage[1] == 4) {
      found = false;
      unitVillaSection = ['1', '2']; //AB
      for (int i = 0; i < unitVillaSection.length; i++) {
        if (unitSection == unitVillaSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1'; //A
      }
    }
    return DropdownButton<String>(
      value: unitSection,
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          unitSection = newValue;
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: unitVillaSection.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnUnitSectionApp() {
    bool found = false;
    if (unit == 2) {
      found = false;
      if (stage[0] == "B1") {
        if (group == 11) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 12) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 13) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 14) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 15) {
          unitAppSection = ['1', '2'];
        } else if (group == 16) {
          unitAppSection = ['1', '2'];
        } else if (group == 17) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 18) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B2") {
        if (group == 21) {
          unitAppSection = ['1', '2'];
        } else if (group == 22) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 23) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 24) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 25) {
          unitAppSection = ['1', '2'];
        } else if (group == 26) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B3") {
        if (group == 31) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 32) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 33) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 34) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B6") {
        if (group == 61) {
          unitAppSection = ['1', '2'];
        } else if (group == 62) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 63) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 64) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 65) {
          unitAppSection = ['1', '2'];
        } else if (group == 66) {
          unitAppSection = ['1', '2'];
        } else if (group == 67) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 68) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 69) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 70) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B7") {
        if (group == 71) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 72) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 73) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 74) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B8") {
        if (group == 81) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 82) {
          unitAppSection = ['1', '2'];
        } else if (group == 83) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 84) {
          unitAppSection = ['1', '2'];
        } else if (group == 85) {
          unitAppSection = ['1', '2'];
        } else if (group == 86) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 87) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 88) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 89) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B10") {
        if (group == 101) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 102) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 103) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 104) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B11") {
        if (group == 111) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 112) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 113) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 114) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      } else if (stage[0] == "B12") {
        if (group == 121) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 122) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 123) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 124) {
          unitAppSection = ['1', '2', '3', '4'];
        } else if (group == 125) {
          unitAppSection = ['1', '2', '3', '4'];
        }
      }
      for (int i = 0; i < unitAppSection.length; i++) {
        if (unitSection == unitAppSection[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitSection = '1';
      }
    }
    return DropdownButton<String>(
      value: unitSection,
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          unitSection = newValue;
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: unitAppSection.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnAppLevel() {
    List<dynamic> levelsArray = [MadinatyStages.Ground, MadinatyStages.First, MadinatyStages.Second, MadinatyStages.Third, MadinatyStages.Fourth, MadinatyStages.Fifth];
    if (stage[1] == 1 || stage[1] == 2 || stage[1] == 3) {
      levelsArray.add(MadinatyStages.Six);
    }
    if (stage[1] == 6 && (group == 61 || group == 65 || group == 66)) {
      levelsArray.add(MadinatyStages.Six);
    }
    if (unit == 2 && level[0] == "") {
      level = ["أرضي", 0];
    }
    return DropdownButton<String>(
      value: level[0],
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          level[0] = newValue;
          switch (level[0]) {
            case "أرضي":
              level[1] = 0;
              garden = 0;
              gardenArea.text = "";
              break;
            case "أول":
              level[1] = 1;
              garden = 0;
              gardenArea.text = "";
              break;
            case "ثاني":
              level[1] = 2;
              garden = 0;
              gardenArea.text = "";
              break;
            case "ثالث":
              level[1] = 3;
              garden = 0;
              gardenArea.text = "";
              break;
            case "رابع":
              level[1] = 4;
              garden = 0;
              gardenArea.text = "";
              break;
            case "خامس":
              level[1] = 5;
              garden = 0;
              gardenArea.text = "";
              break;
            case "سادس":
              level[1] = 6;
              garden = 0;
              gardenArea.text = "";
              break;
            default:
              break;
          }
          //debugPrint("Name: " + level[0] + ", with a value: " + level[1].toString());
        });
      },
      items: levelsArray.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value[0],
          child: Text(
            value[0],
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnVillaUnitType() {
    List<String> unitVillaType = [];
    bool found = false;
    if (stage[1] == 1) {
      if (villaStructure == 1) {
        unitVillaType = ["T", "U", "V", "W", "X"];
      }
      else if (villaStructure == 2) {
        unitVillaType = ["Z", "Y"];
      }
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        if (villaStructure == 1) {
          unitType = "T";
        } else if (villaStructure == 2) {
          unitType = "Z";
        }
      }
    }
    else if (stage[1] == 2) {
      if (villaStructure == 1) {
        unitVillaType = ["A", "B", "C", "D", "E", "F", "G"];
      } else if (villaStructure == 2) {
        unitVillaType = ["H"];
      }

      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        if (villaStructure == 1) {
          unitType = "A";
        } else if (villaStructure == 2) {
          unitType = "H";
        }
      }
    }
    else if (stage[1] == 3) {
      if (villaStructure == 1) {
        unitVillaType = ["A3", "B3", "C3", "D3"];
      }
      else if (villaStructure == 2) {
        unitVillaType = ["E3"];
      } else if (villaStructure == 3) {
        unitVillaType = ["F3"];
      }
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        if (villaStructure == 1) {
          unitType = "A3";
        } else if (villaStructure == 2) {
          unitType = "E3";
        } else if (villaStructure == 3) {
          unitType = "F3";
        }
      }
    }
    else if (stage[1] == 4) {
      if (villaStructure == 1) {
        unitVillaType = ["O", "N", "M", "L", "K"];
      } else if (villaStructure == 2) {
        unitVillaType = ["J"];
      }
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        if (villaStructure == 1) {
          unitType = "O";
        } else if (villaStructure == 2) {
          unitType = "J";
        }
      }
    }
    else if (stage[1] == 5) {
      if (villaStructure == 1) {
        unitVillaType = ["M^", "M", "L^", "L", "K^", "K"];
      } else if (villaStructure == 2) {
        unitVillaType = ["J^", "J"];
      } else if (villaStructure == 3) {
        unitVillaType = ["I^", "I", "II^", "II"];
      }

      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        if (villaStructure == 1) {
          unitType = "M^";
        } else if (villaStructure == 2) {
          unitType = "J^";
        } else if (villaStructure == 3) {
          unitType = "I^";
        }
      }
    }
    returnAreaValueVilla();
    return DropdownButton<String>(
      value: unitType,
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        setState(() {
          unitType = newValue;
          returnAreaValueVilla();
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: unitVillaType.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  DropdownButton returnAppUnitType() {
    List<String> unitAppType = [];

    bool found = false;
    if (stage[1] == 1) {
      //["100", "200", "300", "400", "500", "600", "700"];
      if (group == 11) {
        unitAppType = ["100", "200", "300", "400", "500"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      } else if (group == 12) {
        unitAppType = ["100", "200", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      } else if (group == 13) {
        unitAppType = ["100", "200", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      } else if (group == 14) {
        unitAppType = ["100", "200", "300", "400", "500", "600", "700"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      } else if (group == 15) {
        unitAppType = ["300", "400", "500", "600"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "300";
            areaFrom = "157";
            areaTo = "183";
          });
        }
      } else if (group == 16) {
        unitAppType = ["300", "400", "500", "700"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "300";
            areaFrom = "157";
            areaTo = "183";
          });
        }
      } else if (group == 17) {
        unitAppType = ["100", "200", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      } else if (group == 18) {
        unitAppType = ["100", "200", "300", "400", "500"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          setState(() {
            unitType = "100";
            areaFrom = "100";
            areaTo = "111";
          });
        }
      }
    }
    else if (stage[1] == 2) {
      if (group == 21) {
        unitAppType = ["400", "500", "600", "700"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "400";
          areaFrom = "177";
          areaTo = "211";
        }
      }
      if (group == 22) {
        unitAppType = ["100", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 23) {
        unitAppType = ["100", "200", "300", "400", "600"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 24) {
        unitAppType = ["200", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 25) {
        unitAppType = ["400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 26) {
        unitAppType = ["100", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
    }
    else if (stage[1] == 3) {
      if (group == 31) {
        unitAppType = ["100", "200", "300", "400", "600", "700"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "400";
          areaFrom = "177";
          areaTo = "211";
        }
      }
      if (group == 32) {
        unitAppType = ["100", "200", "300", "400", "500", "600", "700"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 33) {
        unitAppType = ["100", "200", "300", "400", "500", "600"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
      if (group == 34) {
        unitAppType = ["100", "200", "300", "400"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "100";
          areaFrom = "100";
          areaTo = "111";
        }
      }
    }
    else if (stage[1] == 6) {
      if (group == 61) {
        unitAppType = ["10", "20"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "10";
          areaFrom = "78";
          areaTo = "146";
        }
      } else if (group == 62) {
        unitAppType = ["30", "33", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 63) {
        unitAppType = ["30", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 64) {
        unitAppType = ["30", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 65) {
        unitAppType = ["11", "22"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "11";
          areaFrom = "78";
          areaTo = "146";
        }
      } else if (group == 66) {
        unitAppType = ["10", "20"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "10";
          areaFrom = "78";
          areaTo = "146";
        }
      } else if (group == 67) {
        unitAppType = ["30"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 68) {
        unitAppType = ["30", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 69) {
        unitAppType = ["30", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      } else if (group == 70) {
        unitAppType = ["30", "40"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "30";
          areaFrom = "58";
          areaTo = "104";
        }
      }
    }
    else if (stage[1] == 7) {
      if (group == 71) {
        unitAppType = ["50", "60", "70"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "50";
          areaFrom = "42";
          areaTo = "69";
        }
      } else if (group == 72) {
        unitAppType = ["50", "60", "70"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "50";
          areaFrom = "42";
          areaTo = "69";
        }
      } else if (group == 73) {
        unitAppType = ["60", "70"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "60";
          areaFrom = "46";
          areaTo = "82";
        }
      } else if (group == 74) {
        unitAppType = ["50", "60", "70"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "50";
          areaFrom = "42";
          areaTo = "69";
        }
      }
    }
    else if (stage[1] == 8) {
      if (group == 81) {
        unitAppType = ["105", "305", "405"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "105";
          areaFrom = "-";
          areaTo = "-";
        }
      } else if (group == 82) {
        unitAppType = ["305", "405"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "305";
          areaFrom = "-";
          areaTo = "-";
        }
      } else if (group == 83) {
        unitAppType = ["310", "320"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "310";
          areaFrom = "142";
          areaTo = "444";
        }
      } else if (group == 84) {
        unitAppType = ["340", "350", "351"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "340";
          areaFrom = "-";
          areaTo = "-";
        }
      } else if (group == 85) {
        unitAppType = ["750", "850"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "750";
          areaFrom = "199";
          areaTo = "245";
        }
      } else if (group == 86) {
        unitAppType = ["650", "660"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "650";
          areaFrom = "270";
          areaTo = "290";
        }
      } else if (group == 87) {
        unitAppType = ["310", "320"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "310";
          areaFrom = "142";
          areaTo = "444";
        }
      } else if (group == 88) {
        unitAppType = ["650", "660"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "650";
          areaFrom = "270";
          areaTo = "290";
        }
      } else if (group == 89) {
        unitAppType = ["450", "550"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "450";
          areaFrom = "-";
          areaTo = "-";
        }
      }
    }
    else if (stage[1] == 10) {
      if (group == 101) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 102) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 103) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 104) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      }
    }
    else if (stage[1] == 11) {
      if (group == 111) {
        unitAppType = ["60", "70", "80", "90"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "60";
          areaFrom = "46";
          areaTo = "82";
        }
      } else if (group == 112) {
        unitAppType = ["02", "05", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "02";
          areaFrom = "54";
          areaTo = "71";
        }
      } else if (group == 113) {
        unitAppType = ["50", "60", "70", "80"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "50";
          areaFrom = "42";
          areaTo = "69";
        }
      } else if (group == 114) {
        unitAppType = ["60", "70", "80", "90"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "60";
          areaFrom = "46";
          areaTo = "82";
        }
      }
    }
    else if (stage[1] == 12) {
      if (group == 121) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 122) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 123) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 124) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      } else if (group == 125) {
        unitAppType = ["01", "04", "06", "07", "08"];
        for (int i = 0; i < unitAppType.length; i++) {
          if (unitType == unitAppType[i]) {
            found = true;
          }
        }
        if (found == false) {
          unitType = "01";
          areaFrom = "56";
          areaTo = "78";
        }
      }
    }
    return DropdownButton<String>(
      value: unitType,
      icon: Icon(
        Icons.arrow_downward,
        color: AppConstants.orange,
      ),
      iconSize: 24,
      elevation: 16,
      dropdownColor: AppConstants.grey,
      style: TextStyle(color: AppConstants.orange),
      underline: Container(
        height: 2,
        color: AppConstants.orange,
      ),
      onChanged: (String newValue) {
        if (stage[1] == 1) {
          for (int iS1 = 0; iS1 < MadinatyStages.b123UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b123UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b123UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b123UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 2) {
          for (int iS1 = 0; iS1 < MadinatyStages.b123UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b123UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b123UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b123UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 3) {
          for (int iS1 = 0; iS1 < MadinatyStages.b123UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b123UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b123UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b123UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 6) {
          for (int iS1 = 0; iS1 < MadinatyStages.b6UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b6UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b6UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b6UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 7) {
          for (int iS1 = 0; iS1 < MadinatyStages.b7UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b7UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b7UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b7UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 8) {
          for (int iS1 = 0; iS1 < MadinatyStages.b8UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b8UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b8UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b8UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 10) {
          for (int iS1 = 0; iS1 < MadinatyStages.b10UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b10UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b10UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b10UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 11) {
          for (int iS1 = 0; iS1 < MadinatyStages.b11UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b11UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b11UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b11UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        else if (stage[1] == 12) {
          for (int iS1 = 0; iS1 < MadinatyStages.b12UnitTypes.length; iS1++) {
            if (newValue == MadinatyStages.b12UnitTypes[iS1][0].toString()) {
              areaFrom = MadinatyStages.b12UnitTypes[iS1][3][0].toString();
              areaTo = MadinatyStages.b12UnitTypes[iS1][3][1].toString();
              break;
            }
          }
        }
        setState(() {
          unitType = newValue;
          areaFrom = areaFrom;
          areaTo = areaTo;
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: unitAppType.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
          ),
        );
      }).toList(),
    );
  }

  returnAreaValue() async {
    if(mounted)
      {
        await new Future.delayed(const Duration(milliseconds: 50), () {
          if(mounted)
          {
          setState(() {
            if (unit == 1) {
              areaValues = "من " + areaFrom;
            }
            else {
              areaValues = "من " + areaFrom + " الي " + areaTo;
            }
          });
        }
        });
      }

  }
  returnAreaValueVilla() async {
    await new Future.delayed(const Duration(milliseconds: 50), () {
      //VG1
      if(unitType == "T")
      {
        areaFrom = "601";
      }
      else if(unitType == "U")
      {
        areaFrom = "441";
      }
      else if(unitType == "V")
      {
        areaFrom = "390";
      }
      else if(unitType == "Z")
      {
        areaFrom = "355";
      }
      else if(unitType == "W")
      {
        areaFrom = "347";
      }
      else if(unitType == "X")
      {
        areaFrom = "317";
      }
      else if(unitType == "Y")
      {
        areaFrom = "289";
      }

      //VG2
      if(unitType == "A")
      {
        areaFrom = "660";
      }
      else if(unitType == "B")
      {
        areaFrom = "629";
      }
      else if(unitType == "C")
      {
        areaFrom = "555";
      }
      else if(unitType == "D")
      {
        areaFrom = "478";
      }
      else if(unitType == "E")
      {
        areaFrom = "405";
      }
      else if(unitType == "F")
      {
        areaFrom = "360";
      }
      else if(unitType == "G")
      {
        areaFrom = "333";
      }
      else if(unitType == "H")
      {
        areaFrom = "275";
      }

      //VG3
      if(unitType == "F3")
      {
        areaFrom = "201";
      }
      else if(unitType == "E3")
      {
        areaFrom = "253";
      }
      else if(unitType == "D3")
      {
        areaFrom = "276";
      }
      else if(unitType == "C3")
      {
        areaFrom = "304";
      }
      else if(unitType == "B3")
      {
        areaFrom = "374";
      }
      else if(unitType == "A3")
      {
        areaFrom = "404";
      }

      //VG4
      if(unitType == "J")
      {
        areaFrom = "259";
      }
      else if(unitType == "K")
      {
        areaFrom = "312";
      }
      else if(unitType == "L")
      {
        areaFrom = "388";
      }
      else if(unitType == "M")
      {
        areaFrom = "437";
      }
      else if(unitType == "N")
      {
        areaFrom = "493";
      }
      else if(unitType == "O")
      {
        areaFrom = "557";
      }

      //VG5
      if(unitType == "II")
      {
        areaFrom = "180";
      }
      else if(unitType == "II^")
      {
        areaFrom = "191";
      }
      else if(unitType == "I")
      {
        areaFrom = "222";
      }
      else if(unitType == "I^")
      {
        areaFrom = "231";
      }
      else if(unitType == "J")
      {
        areaFrom = "259";
      }
      else if(unitType == "J^")
      {
        areaFrom = "267";
      }
      else if(unitType == "K")
      {
        areaFrom = "312";
      }
      else if(unitType == "K^")
      {
        areaFrom = "316";
      }
      else if(unitType == "L")
      {
        areaFrom = "388";
      }
      else if(unitType == "L^")
      {
        areaFrom = "397";
      }
      else if(unitType == "M")
      {
        areaFrom = "388";
      }
      else if(unitType == "M^")
      {
        areaFrom = "397";
      }
      if(mounted) {
        setState(() {
          areaValues = "مساحة " + areaFrom;
        });
      }
    });
  }
}
