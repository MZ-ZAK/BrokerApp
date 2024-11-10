import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:getwidget/shape/gf_badge_shape.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/MadinatyStages.dart';
import 'package:madinaty_app/Screens/EditUnit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'UserPage.dart';

class AppOnMAp extends StatefulWidget {
  final double top;
  final double left;
  final String stage;

  AppOnMAp({Key key, this.top, this.left, this.stage}) : super(key: key);
  @override
  _AppOnMApState createState() => _AppOnMApState();
}

class _AppOnMApState extends State<AppOnMAp> {
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

  String currentLevel = "All";
  bool levelOrder = false;

  final ScrollController _controllerOne = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    top = widget.top;
    left = widget.left;
    stage = widget.stage;
    //allLocations = jsonDecode(AppConstants().getAllLocationsOfFirstAppType().toString());
    super.initState();
    //debugPrint("$left $top");
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
                                  //debugPrint("Scale: $scale");
                                },
                                child: Stack(
                                    fit: StackFit.expand,
                                    alignment: Alignment.center,
                                    children: [
                                  Image(
                                      image: Image.asset(
                                          stage,
                                          fit: BoxFit.fitWidth,
                                          //width: widthLength,
                                          //height: heightLength,
                                          alignment: Alignment.center
                                      ).image,
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
      //allLocations = jsonDecode(AppConstants().getAllLocationsOfFirstAppType().toString());
      //jsonDecode(allTypesOfFirstStage.toString())[0][1][0][1].toString());
      for (int i = 0; i < allLocations.length; i++) {
        Positioned pos = Positioned(
          top: allLocations[i][1][0][1],
          left: allLocations[i][1][0][0],
          child: SizedBox(
            width: 15.0.w,
            height: 8.0.h,
            /*
                GFBorder(
                  type: GFBorderType.circle,
                  color: Colors.black,
                  strokeWidth: 3.0,
                 */
            child: GFButton(
              borderShape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1.0.w), borderRadius: BorderRadius.all(Radius.circular(50))),
              color: Colors.red,
              shape: GFButtonShape.pills,
              text: allLocations[i][0].toString(),
              textStyle: TextStyle(color: Colors.black, fontSize: 14.0.sp, letterSpacing: .1),
              onPressed: () async {
                //debugPrint("unitNumber: " + allLocations[i][0].toString() + " // " + "mapLoc: " + allLocations[i][1].toString() + " // " + "ID: " + allLocations[i][2].toString());
                /*
                    AllData getData = await dataBaseProvider.aDGetRow(allLocations[i][2]);
                    if (getData != null) {
                      AppConstants().setSelectedUnitForEditing(getData);
                      Get.to(EditUnit());
                    }
                    */
                int idFromALlLocations = allLocations[i][2];
                int stageFromALlLocations = allLocations[i][3];
                int unitGroupFromALlLocations = allLocations[i][4];
                int unitNumberFromALlLocations = allLocations[i][0];
                int levelFromALlLocations = allLocations[i][1][1];

                debugPrint(idFromALlLocations.toString());
                debugPrint(stageFromALlLocations.toString());
                debugPrint(unitGroupFromALlLocations.toString());
                debugPrint(unitNumberFromALlLocations.toString());
                debugPrint(levelFromALlLocations.toString());

                int av = available ? 1 : 0;
                if (available == true) {
                  if (currentLevel != "All") {
                    //ID,unitNumber,level,unitSection
                    List allAppsOfUnit = await dataBaseProvider.aDGetAllAppOfUnit(
                        columnsNames: ['ID', 'stage', 'unitGroup', 'unitNumber', 'unitSection', 'level'],
                        whereCode: "stage = $stageFromALlLocations AND available = $av AND unitGroup = '$unitGroupFromALlLocations' AND unitNumber = $unitNumberFromALlLocations AND level = $levelFromALlLocations");
                    if (allAppsOfUnit != null) {
                      debugPrint(allAppsOfUnit.toString());
                      whichApp(allAppsOfUnit);
                    }
                  } else {
                    //ID,unitNumber,level,unitSection
                    List allAppsOfUnit = await dataBaseProvider.aDGetAllAppOfUnit(
                        columnsNames: ['ID', 'stage', 'unitGroup', 'unitNumber', 'unitSection', 'level'],
                        whereCode: "stage = $stageFromALlLocations AND available = $av AND unitGroup = '$unitGroupFromALlLocations' AND unitNumber = $unitNumberFromALlLocations");
                    if (allAppsOfUnit != null) {
                      debugPrint(allAppsOfUnit.toString());
                      whichApp(allAppsOfUnit);
                    }
                  }
                } else {
                  if (currentLevel != "All") {
                    //ID,unitNumber,level,unitSection
                    List allAppsOfUnit = await dataBaseProvider.aDGetAllAppOfUnit(
                        columnsNames: ['ID', 'stage', 'unitGroup', 'unitNumber', 'unitSection', 'level'],
                        whereCode: "stage = $stageFromALlLocations AND unitGroup = '$unitGroupFromALlLocations' AND unitNumber = $unitNumberFromALlLocations AND level = $levelFromALlLocations");
                    if (allAppsOfUnit != null) {
                      debugPrint(allAppsOfUnit.toString());
                      whichApp(allAppsOfUnit);
                    }
                  } else {
                    //ID,unitNumber,level,unitSection
                    List allAppsOfUnit = await dataBaseProvider.aDGetAllAppOfUnit(
                        columnsNames: ['ID', 'stage', 'unitGroup', 'unitNumber', 'unitSection', 'level'], whereCode: "stage = $stageFromALlLocations AND unitGroup = '$unitGroupFromALlLocations' AND unitNumber = $unitNumberFromALlLocations");
                    if (allAppsOfUnit != null) {
                      debugPrint(allAppsOfUnit.toString());
                      whichApp(allAppsOfUnit);
                    }
                  }
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
      return returnedWidgets;
    }
    return [SizedBox.shrink()];
  }

  List getLevel(int levelNumber) {
    List returnData = [];
    switch (levelNumber) {
      case 0:
        returnData = ["الأرضي", 0];
        break;
      case 1:
        returnData = ["الأول", 1];
        break;
      case 2:
        returnData = ["الثاني", 2];
        break;
      case 3:
        returnData = ["الثالث", 3];
        break;
      case 4:
        returnData = ["الرابع", 4];
        break;
      case 5:
        returnData = ["الخامس", 5];
        break;
      case 6:
        returnData = ["السادس", 6];
        break;
      default:
        break;
    }
    return returnData;
  }

  whichApp(List allAppsOfUnit) {
    List<Row> widgetsList = List<Row>();
    for (int q = 0; q < allAppsOfUnit.length; q++) {
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 60.0.w,
          height: 8.0.h,
          child: GFButton(
              color: AppConstants.orange,
              constraints: BoxConstraints.expand(width: 50),
              shape: GFButtonShape.pills,
              //ID,unitNumber,level,unitSection
              text: "الدور " + getLevel(allAppsOfUnit[q][2])[0].toString() + " شقة: " + allAppsOfUnit[q][3].toString(),
              textStyle: TextStyle(color: AppConstants.grey, fontSize: 20.0.sp, letterSpacing: .1),
              onPressed: () async {
                debugPrint("Done Thanks God");
                AllData getData = await dataBaseProvider.aDGetRow(allAppsOfUnit[q][0]);
                if (getData != null) {
                  AppConstants().setSelectedUnitForEditing(getData);
                  Get.back();
                  int unitIDForSyncServerSearch = allAppsOfUnit[q][0];
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
                  //Get.to(EditUnit());
                }
              }),
        ),
      ]));
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [SizedBox(height: 2.0.h)]));
      if (q == allAppsOfUnit.length - 1) {
        Get.defaultDialog(
          cancel: GFButton(
              size: GFSize.LARGE,
              color: AppConstants.orange,
              text: "إلغاء",
              textStyle: TextStyle(color: AppConstants.grey, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"),
              onPressed: () {
                Get.back();
              }),
          backgroundColor: AppConstants.grey,
          barrierDismissible: false,
          title: "إختار الوحدة",
          titleStyle: TextStyle(color: AppConstants.orange, fontSize: 30, fontFamily: "Bell Gothic Light"),
          content: Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                height: 300,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _controllerOne,
                  child: SingleChildScrollView(
                    controller: _controllerOne,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(10),
                    physics: AlwaysScrollableScrollPhysics(),
                    //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widgetsList,
                    ),
                  ),
                ),
              )),
        );
      }
    }
  }

  updateAppConstantType() async {
    if (currentType != "") {
      int av = available ? 1 : 0;
      poses = "";
      String firstType = currentType;
      int currentStageNumber = int.parse(currentStage.substring(1));
      debugPrint("currentStageNumber " + currentStageNumber.toString());
      if (av == 1) {
        if (currentLevel == "All") {
          if (sellOnly == true && rentOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND stage = $currentStageNumber AND unitType = '$currentType'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND stage = '$currentStageNumber' AND unitType = '$currentType'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (sellOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND offerType = 1 AND stage = $currentStageNumber AND unitType = '$currentType'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND offerType = 1 AND stage = '$currentStageNumber' AND unitType = '$currentType'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (rentOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND offerType = 2 AND stage = $currentStageNumber AND unitType = '$currentType'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND offerType = 2 AND stage = '$currentStageNumber' AND unitType = '$currentType'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (sellOnly == false && rentOnly == false) {
            setState(() {
              AppConstants().setAllLocationsOfFirstAppTypeList([]);
              allLocations = jsonDecode("[]");
            });
          }
        }
        else if (levelOrder == false) {
          if (sellOnly == true && rentOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND stage = $currentStageNumber AND unitType = '$currentType' AND level = '$currentLevel'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (sellOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND offerType = 1 AND stage = $currentStageNumber AND unitType = '$currentType' AND level = '$currentLevel'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND offerType = 1 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (rentOnly == true) {
            List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available", "offerType"], "level",
                groupedBy: 'level', whereCode: "unit = 2 AND available = $av AND offerType = 2 AND stage = $currentStageNumber AND unitType = '$currentType' AND level = '$currentLevel'", exFor: 'allLevels');
            if (allLevelsForThisType != null) {
              allLevelsForThisType.insert(0, "All");
              AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
              List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available", "offerType"], "unitType",
                  whereCode: "unit = 2 AND available = $av AND offerType = 2 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
              if (test != null) {
                setState(() {
                  AppConstants().setAllLocationsOfFirstAppTypeList(test);
                  allLocations = jsonDecode(test.toString());
                  debugPrint(allLocations.toString());
                });
              }
            }
          }
          else if (sellOnly == false && rentOnly == false) {
            setState(() {
              AppConstants().setAllLocationsOfFirstAppTypeList([]);
              allLocations = jsonDecode("[]");
            });
          }
        }
        else if (levelOrder == true) {
          if (sellOnly == true && rentOnly == true) {
            List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available","offerType"], "unitType",
                whereCode: "unit = 2 AND available = $av AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
            if (test != null) {
              setState(() {
                AppConstants().setAllLocationsOfFirstAppTypeList(test);
                allLocations = jsonDecode(test.toString());
                debugPrint(allLocations.toString());
              });
            }
          }
          else if (sellOnly == true) {
            List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available","offerType"], "unitType",
                whereCode: "unit = 2 AND available = $av AND offerType = 1 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
            if (test != null) {
              setState(() {
                AppConstants().setAllLocationsOfFirstAppTypeList(test);
                allLocations = jsonDecode(test.toString());
                debugPrint(allLocations.toString());
              });
            }
          }
          else if (rentOnly == true) {
            List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available","offerType"], "unitType",
                whereCode: "unit = 2 AND available = $av AND offerType = 2 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
            if (test != null) {
              setState(() {
                AppConstants().setAllLocationsOfFirstAppTypeList(test);
                allLocations = jsonDecode(test.toString());
                debugPrint(allLocations.toString());
              });
            }
          }
          else if (sellOnly == false && rentOnly == false) {
            setState(() {
              AppConstants().setAllLocationsOfFirstAppTypeList([]);
              allLocations = jsonDecode("[]");
            });
          }

          levelOrder = false;
        }
      } else {
        if (currentLevel == "All") {
          List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup"], "level",
              groupedBy: 'level', whereCode: "unit = 2 AND available = 0 AND stage = $currentStageNumber AND unitType = '$currentType'", exFor: 'allLevels');
          if (allLevelsForThisType != null) {
            allLevelsForThisType.insert(0, "All");
            AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
            List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available"], "unitType",
                whereCode: "unit = 2 AND available = 0 AND stage = '$currentStageNumber' AND unitType = '$currentType'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
            if (test != null) {
              setState(() {
                AppConstants().setAllLocationsOfFirstAppTypeList(test);
                allLocations = jsonDecode(test.toString());
                debugPrint(allLocations.toString());
              });
            }
          }
        }
        else if (levelOrder == false) {
          List allLevelsForThisType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available"], "level",
              groupedBy: 'level', whereCode: "unit = 2 AND available = 0 AND stage = $currentStageNumber AND unitType = '$currentType' AND level = '$currentLevel'", exFor: 'allLevels');
          if (allLevelsForThisType != null) {
            allLevelsForThisType.insert(0, "All");
            AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForThisType);
            List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available"], "unitType",
                whereCode: "unit = 2 AND available = 0 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
            if (test != null) {
              setState(() {
                AppConstants().setAllLocationsOfFirstAppTypeList(test);
                allLocations = jsonDecode(test.toString());
                debugPrint(allLocations.toString());
              });
            }
          }
        }
        else if (levelOrder == true) {
          List test = await dataBaseProvider.aDGetAllDistinctValuesOfUnitNumberLocations(["unit", "unitType", "stage", "mapLoc", 'level', "unitNumber", "ID", "unitGroup", "available"], "unitType",
              whereCode: "unit = 2 AND available = 0 AND stage = '$currentStageNumber' AND unitType = '$firstType' AND level = '$currentLevel'", exFor: 'DistinctUnitNumberLocations', groupedBy: 'unitNumber');
          if (test != null) {
            setState(() {
              AppConstants().setAllLocationsOfFirstAppTypeList(test);
              allLocations = jsonDecode(test.toString());
              debugPrint(allLocations.toString());
            });
          }
          levelOrder = false;
        }
      }
    }
  }

  List<Row> createButtonsForUnits() {
    var widgetsList = List<Row>();
    if (AppConstants().getAllDataFromLiteAppStages().length > 0) {
      widgetsList.add(
        Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
          returnAppStageDropDown(),
          SizedBox(width: 5.0.w),
          Text(
            "المرحلة",
            style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          SizedBox(width: 20.0.w),
          returnAppTypesDropDown(),
          SizedBox(width: 5.0.w),
          Text(
            "النموذج",
            style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ]),
      );
    }
    widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          "المساحة من: " + getAreaFromTo(currentType)[0].toString() + " الي: " + getAreaFromTo(currentType)[1].toString(),
          style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 5.0.w),
        returnAppLevelsDropDown(),
        SizedBox(width: 8.0.w),
        Text(
          "الدور",
          style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
      ]),
    ]));
    widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Spacer(),
      SizedBox(
        width: 33.0.w,
        child: GFButton(
          color: AppConstants.orange,
          shape: GFButtonShape.pills,
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
      Spacer(),
      GFCheckbox(
          size: GFSize.SMALL,
          activeBgColor: AppConstants.orange,
          onChanged: (value) {
            setState(() {
              rentOnly = value;
              updateAppConstantType();
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
      SizedBox(width: 5.0.w),
      GFCheckbox(
          size: GFSize.SMALL,
          activeBgColor: AppConstants.orange,
          onChanged: (value) {
            setState(() {
              sellOnly = value;
              updateAppConstantType();
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
    ]));
    if (AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1) {
      widgetsList.add(Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        GFCheckbox(
            size: GFSize.SMALL,
            activeBgColor: AppConstants.orange,
            onChanged: (value) {
              setState(() {
                available = value;
                updateAppConstantType();
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
    return widgetsList;
  }

  List getAreaFromTo(String type) {
    List fromTo = ["-", "-"];
    for (int i = 0; i < MadinatyStages.allAppTypes.length; i++) {
      if (type == MadinatyStages.allAppTypes[i][0]) {
        fromTo[0] = MadinatyStages.allAppTypes[i][3][0];
        fromTo[1] = MadinatyStages.allAppTypes[i][3][1];
        return fromTo;
      }
    }
    return fromTo;
  }

  DropdownButton returnAppStageDropDown() {
    List<List<dynamic>> stages = AppConstants().getAllDataFromLiteAppStages();
    //debugPrint(stages.toString());
    if (currentStage == "") {
      currentStage = stages[0][1];
    }
    //debugPrint("currentStage: " + currentStage);
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
            currentLevel = "All";
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
    for (int i = 0; i < AppConstants().getAllDataFromLiteAppStages().length; i++) {
      if (AppConstants().getAllDataFromLiteAppStages()[i][1] == currentStage) {
        return i;
      }
    }
    return null;
  }

  DropdownButton returnAppTypesDropDown() {
    if (currentIndex != getIndex()) {
      currentType = "";
    }
    List<String> allTypesForThisIndex = List();
    for (int y = 0; y < AppConstants().getAllDataFromLiteAppTypes()[getIndex()].length; y++) {
      allTypesForThisIndex.add(AppConstants().getAllDataFromLiteAppTypes()[getIndex()][y][2]);
      if (y == AppConstants().getAllDataFromLiteAppTypes()[getIndex()].length - 1) {
        if (currentType == "") {
          currentType = allTypesForThisIndex[0];
          currentIndex = getIndex();
          updateAppConstantType();
        }
        /*
    if (currentType == "") {
      //currentType = AppConstants().getAllDataFromLiteAppTypes()[getIndex()][0][2];
      currentType = allTypesForThisIndex[0]
      currentIndex = getIndex();
      updateAppConstantType();
    }
    if (currentIndex != getIndex()) {
      //currentType = AppConstants().getAllDataFromLiteAppTypes()[getIndex()][0][2];
      currentType = AppConstants().getAllDataFromLiteAppTypes()[getIndex()][0][2];
      currentIndex = getIndex();
      updateAppConstantType();
    }
     */
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
              currentLevel = "All";
              updateAppConstantType();
              poses = "";
            });
          },
          //List<List<dynamic>> stage = [['VG1',1]] ;
          //items: AppConstants().getAllDataFromLiteAppTypes()[getIndex()][0].map<DropdownMenuItem<String>>((List<List<dynamic>> value) {
          items: allTypesForThisIndex.map<DropdownMenuItem<String>>((String value) {
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
  }

  DropdownButton returnAppLevelsDropDown() {
    levelOrder = true;
    return DropdownButton<String>(
      value: currentLevel,
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
          currentLevel = newValue;
          updateAppConstantType();
          poses = "";
        });
      },
      //List<List<dynamic>> stage = [['VG1',1]] ;
      items: AppConstants().getAllLevelsOfFirstAppType().map<DropdownMenuItem<String>>((dynamic value) {
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
}
