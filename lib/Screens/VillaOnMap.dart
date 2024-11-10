import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';
import 'package:madinaty_app/Screens/EditUnit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'UserPage.dart';

class VillaOnMAp extends StatefulWidget {
  final double top;
  final double left;
  final String stage;

  VillaOnMAp({Key key, this.top, this.left, this.stage}) : super(key: key);
  @override
  _VillaOnMApState createState() => _VillaOnMApState();
}

class _VillaOnMApState extends State<VillaOnMAp> {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;

  bool showButtons = true;
  bool available = true;
  bool sellOnly = true;
  bool rentOnly = true;
  String showButtonsText = "إخفاء الوحدات";

  GlobalKey _key = GlobalKey();
  double top, left;
  double xOff, yOff;
  Offset position = Offset(0.0, 0.0);
  double scale = 1;
  double widthLength = 5000;
  double heightLength = 5000;

  String stage;

  bool firstTime = false;

  String currentStage = "";
  String currentType = "";
  int currentIndex = 0;
  String poses = "";
  List allLocations;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    top = widget.top;
    left = widget.left;
    stage = widget.stage;
    allLocations = jsonDecode(AppConstants().getAllLocationsOfFirstVillaType().toString());
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
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10.0.h,
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
                  Icon(Icons.arrow_back, size: 25.0.sp, color: AppConstants.grey),
                  Spacer(),
                  Text(
                    "الرجوع للصفحة السابقة",
                    style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: AppConstants.grey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: AppConstants.grey,
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: Center(
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
                                          image: Image.asset(
                                            stage, fit: BoxFit.fill,
                                            //width: widthLength,
                                            //height: heightLength,
                                            alignment: Alignment.center).image,
                                        alignment: Alignment.center,
                                        fit: BoxFit.fill,
                                      ),
                                  Stack(
                                    children: showButtons ? createPositionedButtonsForUnits() : [SizedBox.shrink()],
                                  ),
                                ]))),
                      ),
                    ],
                  ),
                ] +
                createButtonsForUnits(),
          ),
        ));
  }

  List<Widget> createPositionedButtonsForUnits() {
    if (poses == "" && currentType != "") {
      //poses = currentType;
      List<Widget> returnedWidgets = List();
      allLocations = jsonDecode(AppConstants().getAllLocationsOfFirstVillaType().toString());
      //jsonDecode(allTypesOfFirstStage.toString())[0][1][0][1].toString());
      debugPrint("All Locations : " + allLocations.toString());
      for (int i = 0; i < allLocations.length; i++) {
        if (available == true) {
          if (allLocations[i][3] == 1) {
            debugPrint("Rent Or Sell" + allLocations[i][4].toString());
            if(allLocations[i][4] == 1 && sellOnly == true) {
              Positioned pos = Positioned(
                top: allLocations[i][1][0][1],
                left: allLocations[i][1][0][0],
                child: SizedBox(
                  width: 15.0.w,
                  height: 8.0.h,
                  child: GFButton(
                    borderShape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1.0.w), borderRadius: BorderRadius.all(Radius.circular(50))),
                    color: Colors.red,
                    shape: GFButtonShape.pills,
                    text: allLocations[i][0].toString(),
                    textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
                    onPressed: () async {
                      debugPrint("unitNumber: " + allLocations[i][0].toString() + " // " + "mapLoc: " + allLocations[i][1].toString() + " // " + "ID: " + allLocations[i][2].toString());
                      AllData getData = await dataBaseProvider.aDGetRow(allLocations[i][2]);
                      if (getData != null) {
                        AppConstants().setSelectedUnitForEditing(getData);
                        int unitIDForSyncServerSearch = allLocations[i][2];
                        await dataBaseProvider.syncGetAllValuesWhere(columnsNames: ["dataBaseName", "dataID"], whereCode: "dataBaseName = 'allData' AND dataID = $unitIDForSyncServerSearch").then((value) {
                          debugPrint("Unit Is : " + value.toString());
                          if (value.length == 0) {
                            Get.to(EditUnit());
                          } else {
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "قيد التحديث",
                                content: GFButton(
                                    onPressed: () {
                                      if (Get.isDialogOpen) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    text: "حاول مرة أخري"));
                          }
                        });
                      }
                    },
                  ),

                  /*FloatingActionButton(
              onPressed: () {
                debugPrint("Hello");
              },
              child: Text(allLocations[i][0].toString(), style: TextStyle(fontSize: 18.0.sp, letterSpacing: .1)),
            )*/
                ),
              );
              returnedWidgets.add(pos);
            }
            if(allLocations[i][4] == 2 && rentOnly == true) {
              Positioned pos = Positioned(
                top: allLocations[i][1][0][1],
                left: allLocations[i][1][0][0],
                child: SizedBox(
                  width: 15.0.w,
                  height: 8.0.h,
                  child: GFButton(
                    borderShape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1.0.w), borderRadius: BorderRadius.all(Radius.circular(50))),
                    color: Colors.red,
                    shape: GFButtonShape.pills,
                    text: allLocations[i][0].toString(),
                    textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
                    onPressed: () async {
                      debugPrint("unitNumber: " + allLocations[i][0].toString() + " // " + "mapLoc: " + allLocations[i][1].toString() + " // " + "ID: " + allLocations[i][2].toString());
                      AllData getData = await dataBaseProvider.aDGetRow(allLocations[i][2]);
                      if (getData != null) {
                        AppConstants().setSelectedUnitForEditing(getData);
                        int unitIDForSyncServerSearch = allLocations[i][2];
                        await dataBaseProvider.syncGetAllValuesWhere(columnsNames: ["dataBaseName", "dataID"], whereCode: "dataBaseName = 'allData' AND dataID = $unitIDForSyncServerSearch").then((value) {
                          debugPrint("Unit Is : " + value.toString());
                          if (value.length == 0) {
                            Get.to(EditUnit());
                          } else {
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "قيد التحديث",
                                content: GFButton(
                                    onPressed: () {
                                      if (Get.isDialogOpen) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    text: "حاول مرة أخري"));
                          }
                        });
                      }
                    },
                  ),

                  /*FloatingActionButton(
              onPressed: () {
                debugPrint("Hello");
              },
              child: Text(allLocations[i][0].toString(), style: TextStyle(fontSize: 18.0.sp, letterSpacing: .1)),
            )*/
                ),
              );
              returnedWidgets.add(pos);
            }
          }
        }
        else {
          if (allLocations[i][3] == 0) {
            Positioned pos = Positioned(
              top: allLocations[i][1][0][1],
              left: allLocations[i][1][0][0],
              child: SizedBox(
                width: 15.0.w,
                height: 8.0.h,
                child: GFButton(
                  borderShape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1.0.w), borderRadius: BorderRadius.all(Radius.circular(50))),
                  color: Colors.red,
                  shape: GFButtonShape.pills,
                  text: allLocations[i][0].toString(),
                  textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
                  onPressed: () async {
                    debugPrint("unitNumber: " + allLocations[i][0].toString() + " // " + "mapLoc: " + allLocations[i][1].toString() + " // " + "ID: " + allLocations[i][2].toString());
                    AllData getData = await dataBaseProvider.aDGetRow(allLocations[i][2]);
                    if (getData != null) {
                      AppConstants().setSelectedUnitForEditing(getData);
                      Get.to(EditUnit());
                    }
                  },
                ),

                /*FloatingActionButton(
              onPressed: () {
                debugPrint("Hello");
              },
              child: Text(allLocations[i][0].toString(), style: TextStyle(fontSize: 18.0.sp, letterSpacing: .1)),
            )*/
              ),
            );
            returnedWidgets.add(pos);
          }
        }
      }
      return returnedWidgets;
    }
    return [SizedBox.shrink()];
  }

  updateAppConstantType() async {
    if (currentType != "") {
      poses = "";
      String firstType = currentType;
      List test = await dataBaseProvider.aDGetAllDistinctValuesOfTypesLocNumber(["unit", "unitType", "mapLoc", "unitNumber", "ID", "available","offerType"], "unitType", whereCode: "unit = 1 AND unitType = '$firstType'", exFor: 'everyType');
      if (test != null) {
        setState(() {
          AppConstants().setAllLocationsOfFirstVillaTypeList(test);
          allLocations = jsonDecode(test.toString());
        });
      }
    }
  }

  List<Row> createButtonsForUnits() {
    var widgetsList = List<Row>();
    if (AppConstants().getAllDataFromLiteVillaStages().length > 0) {
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
        returnVillaStageDropDown(),
        SizedBox(width: 5.0.w),
        Text(
          "المرحلة",
          style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 20.0.w),
        returnVillaTypesDropDown(),
        SizedBox(width: 5.0.w),
        Text(
          "النموذج",
          style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 5.0.w),
      ]));
      //Sell or Rent
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Spacer(),
        GFCheckbox(
            size: GFSize.SMALL,
            activeBgColor: AppConstants.orange,
            onChanged: (value) {
              setState(() {
                rentOnly= value;
              });
            },
            value: rentOnly),
        SizedBox(width: 4.0.w),
        Text(
          "إيجار:",
          style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        Spacer(),
        GFCheckbox(
            size: GFSize.SMALL,
            activeBgColor: AppConstants.orange,
            onChanged: (value) {
              setState(() {
                sellOnly= value;
              });
            },
            value: sellOnly),
        SizedBox(width: 4.0.w),
        Text(
          "بيع:",
          style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        Spacer(),
      ]));
      //Show Hide
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 33.0.w,
          child: GFButton(
            color: AppConstants.orange,
            shape: GFButtonShape.standard,
            text: showButtonsText,
            textStyle: TextStyle(color: AppConstants.grey, fontSize: 16.0.sp, letterSpacing: .1),
            onPressed: () {
              setState(() {
                if (showButtons == true) {
                  showButtons = !showButtons;
                  showButtonsText = "إظهار الوحدات";
                } else {
                  showButtons = !showButtons;
                  showButtonsText = "إخفاء الوحدات";
                }
              });
            },
          ),
        ),
      ]));
      if (AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1) {
        widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          GFCheckbox(
              size: GFSize.SMALL,
              activeBgColor: AppConstants.orange,
              onChanged: (value) {
                setState(() {
                  available = value;
                });
              },
              value: available),
          SizedBox(width: 4.0.w),
          Text(
            "مدرجة في البحث:",
            style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ]));
      }
    }
    //widgetsList.add(SizedBox(height: 40));

    return widgetsList;
  }

  DropdownButton returnVillaStageDropDown() {
    List<List<dynamic>> stages = AppConstants().getAllDataFromLiteVillaStages();
    debugPrint(stages.toString());
    if (currentStage == "") {
      currentStage = stages[0][1];
    }
    debugPrint("currentStage: " + currentStage);
    if (stages.length > 0) {
      return DropdownButton<String>(
        value: currentStage,
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
            currentStage = newValue;
            stage = AppConstants.getStageImage(currentStage, true);
            updateAppConstantType();
          });
        },
        //List<List<dynamic>> stage = [['VG1',1]] ;
        items: stages.map<DropdownMenuItem<String>>((List<dynamic> value) {
          return DropdownMenuItem<String>(
            value: value[1],
            child: Text(
              value[1],
              style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 14.0.sp),
            ),
          );
        }).toList(),
      );
    } else {
      return null;
    }
  }

  int getIndex() {
    for (int i = 0; i < AppConstants().getAllDataFromLiteVillaStages().length; i++) {
      if (AppConstants().getAllDataFromLiteVillaStages()[i][1] == currentStage) {
        return i;
      }
    }
  }

  DropdownButton returnVillaTypesDropDown() {
    if (currentType == "") {
      currentType = AppConstants().getAllDataFromLiteVillaTypes()[getIndex()][0];
      currentIndex = getIndex();
      updateAppConstantType();
    }
    if (currentIndex != getIndex()) {
      currentType = AppConstants().getAllDataFromLiteVillaTypes()[getIndex()][0];
      currentIndex = getIndex();
      updateAppConstantType();
    }

    return DropdownButton<String>(
      value: currentType,
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
          currentType = newValue;
          updateAppConstantType();
          poses = "";
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: AppConstants().getAllDataFromLiteVillaTypes()[getIndex()].map<DropdownMenuItem<String>>((dynamic value) {
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
}
