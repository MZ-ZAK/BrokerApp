import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/ClientTable.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';
import 'package:madinaty_app/DataBase/workerTable.dart';
import 'package:madinaty_app/Screens/MyConnectivity.dart';
import 'package:madinaty_app/Screens/RequestPage.dart';
import 'package:madinaty_app/Screens/UserPage.dart';
import 'package:madinaty_app/Screens/WaitingPage.dart';

import 'package:http/http.dart' as http;

class Controller extends GetxController {}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;
  //TextEditingController dataDebug = TextEditingController();
  int lengthOfWorkerTable = 0;
  int activeUser = 0;
  bool logingButtonEnabled = true;

  double top = 0.0;
  double left = 0.0;

  bool loginClicked = false;

  void initState() {
    dataBaseProvider.wGetAllRowsByTableName().then((result1) {
      if (result1 != null) {
        debugPrint(result1.toString());
        debugPrint(result1.length.toString());
        lengthOfWorkerTable = result1.length;
      }
    });
    logingButtonEnabled = true;
    super.initState();
  }

  @override
  Widget build(context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Image.asset(AppConstants.SplashImagePath, height: MediaQuery.of(context).size.height * .65)),
                      SizedBox(height: MediaQuery.of(context).size.height * .05),
                      /*TextField(
                        showCursor: true,
                        maxLines: 8,
                        controller: dataDebug,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                      ),*/
                      GFButton(
                          size: GFSize.LARGE,
                          //color: Color.fromRGBO(248, 187, 22, 1.0),
                          color: AppConstants.grey,
                          child: Text("تسجيل الدخول", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light")),
                          onPressed: () async {
                            List<WorkerTable> activeValue = await dataBaseProvider.wGetAllRowsByTableName();
                            if (logingButtonEnabled) {
                              //debugPrint("Buttton Clicked");
                              //dataDebug.text = dataDebug.text + "\n" + "Buttton Clicked";
                              if (lengthOfWorkerTable == 0) {
                                await AppConstants().CheckInternet(context, () async {
                                  debugPrint("Came from checking internet");
                                  setState(() {
                                    logingButtonEnabled = false;
                                    loginClicked = true;
                                  });
                                  switch (await AppConstants().loginFunction()) {
                                    case 0:
                                      {
                                        setState(() {
                                          logingButtonEnabled = false;
                                          loginClicked = true;
                                        });
                                      }
                                      break;
                                    case 1:
                                      {
                                        AppConstants.playList = [];
                                        Get.off(UserPage());
                                      }
                                      break;
                                    case 2:
                                      {
                                        Get.off(WaitingPage());
                                      }
                                      break;
                                    case 3:
                                      {
                                        Get.off(RequestPage());
                                      }
                                      break;
                                    default:
                                      {}
                                      break;
                                  }
                                  setState(() {
                                    logingButtonEnabled = false;
                                    loginClicked = true;
                                  });
                                });
                              }
                              else if(activeValue[0].Active == 0)
                                {
                                  Get.off(WaitingPage());
                                }
                              else {
                                setState(() {
                                  logingButtonEnabled = false;
                                  loginClicked = true;
                                });
                                WorkerTable worktable = await dataBaseProvider.wGetRow(1);
                                if (worktable != null) {
                                  //All Data For Villas
                                  List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
                                  if (allDataUnits != null) {
                                    List<List> allDataVillaStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 1", debugCode: "stage", exFor: 'stage');
                                    if (allDataVillaStages != null) {
                                      List<ClientTable> clientTable = await dataBaseProvider.cGetAllRowsByTableNameLogin();
                                      if (clientTable != null) {
                                        //dataDebug.text = dataDebug.text + "\n" + "All Are Null";
                                        AppConstants().setAllDataFromLiteUnits(allDataUnits);
                                        AppConstants().setAllDataFromLiteVillaStages(allDataVillaStages);
                                        //AppConstants().setAllDataFromLiteGroups(allDataVillaGroups);
                                        //AppConstants().setAllDataFromLiteTypes(allDataVillaTypes);

                                        AppConstants().setcurrentUserContacts(clientTable);
                                        AppConstants().setcurrentUserData(worktable);
                                        setState(() {
                                          logingButtonEnabled = false;
                                          loginClicked = true;
                                        });
                                        Get.off(UserPage());
                                      } else {
                                        //dataDebug.text = dataDebug.text + "\n" + "Somthing not = null";
                                        setState(() {
                                          logingButtonEnabled = true;
                                        });
                                      }
                                    }
                                  } else {
                                    //dataDebug.text = dataDebug.text + "\n" + "Somthing not = null";
                                    setState(() {
                                      logingButtonEnabled = true;
                                    });
                                  }
                                } else {
                                  //dataDebug.text = dataDebug.text + "\n" + "Somthing not = null";
                                  setState(() {
                                    logingButtonEnabled = true;
                                  });
                                }

                                /*
                                List<List> allDataVillaGroups = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(
                                    ["unit","stage","unitGroup"], "unitGroup", groupedBy: "unitGroup",whereCode: "unit = 1",debugCode: "unitGroup");


                                List<List> allDataVillaTypes = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(
                                    ["unit","stage","unitGroup","unitType"], "stage", groupedBy: "unitType",whereCode: "unit = 1",debugCode: "unitType");
                                */
                              }
                            }
                          }),
                      loginClicked == true ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
                      loginClicked == true
                          ? CircularProgressIndicator(
                              backgroundColor: AppConstants.orange,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              /*Positioned(
                left: left,
                top: top,
                child: Draggable(
                  child: FloatingActionButton(
                    onPressed: () async {
                      //AppConstants().getSyncData();
                      ServerSync serverSync = await dataBaseProvider.syncGetFirstRows();
                      await dataBaseProvider.syncDelete("ID", serverSync.ID);
                    },
                    child: Text("Hello"),
                  ),
                  feedback: FloatingActionButton(
                    child: Text("Hello"),
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (dragDetails) {
                    setState(() {
                      left = dragDetails.offset.dx;
                      debugPrint(dragDetails.offset.dx.toString() + " And Y: " + dragDetails.offset.dy.toString());
                      // if applicable, don't forget offsets like app/status bar
                      top = dragDetails.offset.dy;
                    });
                  },
                ),
              ),*/
            ],
          ),
        ));
  }
}
