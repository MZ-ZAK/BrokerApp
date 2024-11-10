import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:madinaty_app/DataBase/workerTable.dart';
import 'package:madinaty_app/Screens/ExitPage.dart';
import 'package:madinaty_app/Screens/OthersPage.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import 'package:basic_utils/basic_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:http/http.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/Constants/UserContactsItem.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/ClientTable.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';
import 'package:madinaty_app/Screens/AddNewUser.dart';
import 'package:madinaty_app/Screens/RequestData/AddNewUnit.dart';
import 'package:madinaty_app/Screens/VillaOnMap.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'AppOnMap.dart';
import 'ContactListItemTap.dart';
import 'LoginPage.dart';

class Controller extends GetxController {}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;
  List<List> allDataFromLiteUnits;
  String units = "";

  TabController tabController;
  TextEditingController _newContactName = TextEditingController();
  TextEditingController _newContactMobile = TextEditingController();
  TextEditingController _newContactWork = TextEditingController();
  TextEditingController _newContactCar = TextEditingController();

  ScrollController singleScrollTest;

  bool isChecked = true;

  int _selectedIndex = 0;

  //For Admin Page
  List<WorkerTable> workersData;
  bool loadWorkers = false;
  bool savingWorkerSettingIndicator = false;

  //For Reminder Page
  bool loadClients = false;
  List<Map> clientsData;

  TextDirection textDirectionLang = TextDirection.ltr;

  List<ClientTable> widgetsListProvider;

  //Map Stuff
  List<dynamic> stage = ['', 0];

  //Check Active and Admin
  int oldAdminValue = AppConstants().getcurrentUserData().Admin;
  int oldActiveValue = AppConstants().getcurrentUserData().Active;

  @override
  void initState() {
    //dataBaseProvider.cDelete("ID", 1);
    //dataBaseProvider.cDelete("ID", 2);
    super.initState();

    if (AppConstants.timer == null) {
      AppConstants.timer = Timer.periodic(Duration(seconds: 5), (Timer t) => showSync());
    } else if (AppConstants.timer.isActive == false) {
      AppConstants.timer = Timer.periodic(Duration(seconds: 5), (Timer t) => showSync());
    }
    debugPrint("Owner or not" + AppConstants().getcurrentUserData().Owner.toString());
    //tabController = TabController(length: AppConstants().getcurrentUserData().Owner == 1 ? 7 : 2, vsync: this);
    if (AppConstants.firstRun == true) {
      AppConstants.firstRun = false;
      AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 3 : AppConstants.tabControllerIndex = 2;
    }
    widgetsListProvider = AppConstants().getcurrentUserContacts();
    allDataFromLiteUnits = AppConstants().getAllDataFromLiteUnits();

    oldAdminValue = AppConstants().getcurrentUserData().Admin;
    oldActiveValue = AppConstants().getcurrentUserData().Active;
    //allDataFromLiteStagesTypes = AppConstants().getAllDataFromLiteTypes();
  }

  showSync() async {
    //initState()
    if (AppConstants.updateUserPage) {
      if (this.mounted) {
        setState(() {
          AppConstants.updateUserPage = false;
          widgetsListProvider = AppConstants().getcurrentUserContacts();
          allDataFromLiteUnits = AppConstants().getAllDataFromLiteUnits();
        });
      }
    }
    List<ServerSync> s = await dataBaseProvider.syncGetAllRowsByTableName();
    if (s.length > 0) {
      if (this.mounted) {
        setState(() {
          AppConstants.showCircle = true;
          widgetsListProvider = AppConstants().getcurrentUserContacts();
        });
      }
      debugPrint("Show Circle is: " + AppConstants.showCircle.toString());
    } else {
      if (this.mounted) {
        setState(() {
          AppConstants.showCircle = false;
          widgetsListProvider = AppConstants().getcurrentUserContacts();
        });
      }
      debugPrint("Show Circle is: " + AppConstants.showCircle.toString());
    }
    if (oldAdminValue != AppConstants().getcurrentUserData().Admin) {
      debugPrint("APP SHOULD BE RECREATED");
      setState(() {
        AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 3 : AppConstants.tabControllerIndex = 2;
        oldAdminValue = AppConstants().getcurrentUserData().Admin;
      });
    }
    if (oldActiveValue != AppConstants().getcurrentUserData().Active) {
      debugPrint("APP SHOULD Go To Login page");
      setState(() {
        oldActiveValue = AppConstants().getcurrentUserData().Active;
        if (oldActiveValue == 0) {
          Get.offAll(LoginPage());
        }
      });
    }
    if (AppConstants().getcurrentUserData().Active == 0) {
      Get.offAll(LoginPage());
    }
  }

  @override
  void dispose() {
    AppConstants.timer?.cancel();
    AppConstants.timer = null;
    //tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    /*
    if(AppConstants.timer == null)
    {
      AppConstants.timer = Timer.periodic(Duration(seconds: 5), (Timer t) => showSync());
    }
    else if(AppConstants.timer.isActive == false)
    {
      AppConstants.timer = Timer.periodic(Duration(seconds: 5), (Timer t) => showSync());
    }*/
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? ownerTabs() : userTabs());
  }

  GFTabs userTabs() {
    debugPrint(AppConstants.tabControllerIndex.toString());
    return GFTabs(
      tabBarHeight: 12.0.h,
      //controller: tabController,
      indicatorColor: AppConstants.orange,
      tabBarColor: AppConstants.grey,
      labelStyle: TextStyle(color: Colors.white, fontSize: 17.0.sp, fontFamily: AppConstants.MarkaziText, fontWeight: FontWeight.w700),
      initialIndex: AppConstants.tabControllerIndex,
      length: 3,
      tabs: <Widget>[
        Tab(
          child: Align(
            alignment: Alignment.bottomCenter,
              child: Text("مذكرة",textAlign: TextAlign.center)),
        ),
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("بيانات",textAlign: TextAlign.center)),
        ),
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("العملاء",textAlign: TextAlign.center)),
        ),
      ],
      tabBarView: GFTabBarView(
        children: <Widget>[
          //Reminder
          Scaffold(
              backgroundColor: AppConstants.grey,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    loadClients == true
                        ? SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: widgetsListProvider != null ? createTableForReminder(widgetsListProvider) : SizedBox.shrink(),
                          )
                        : SizedBox.shrink(),
                    Container(
                      color: AppConstants.grey,
                      height: 20.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GFBorder(
                              type: GFBorderType.rRect,
                              strokeWidth: 2,
                              dashedLine: [2, 0],
                              color: AppConstants.orange,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Text("عملاء لديهم طلبات لم تنفذ", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"))],
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height * .01),
                          GFButton(
                            size: GFSize.LARGE,
                            color: AppConstants.orange,
                            text: "إعادة إظهار العملاء",
                            textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                            onPressed: () async {
                              clientsData = await dataBaseProvider.cGetColumnsWhere(columnsNames: ['ID', 'CONTACTNAME', 'CONTACTMOBILE'], whereCode: "ACTIVEUSER = 1");
                              if (clientsData != null) {
                                if (clientsData.length > 0) {
                                  debugPrint("clients COUNT IS: " + clientsData.length.toString());
                                  setState(() {
                                    loadClients = true;
                                  });
                                } else {
                                  setState(() {
                                    loadClients = false;
                                  });
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "لا يوجد",
                                      content: Text("لا يوجد عميل لة طلبات", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                      cancel: GFButton(
                                          size: GFSize.LARGE,
                                          color: AppConstants.orange,
                                          text: "الغاء",
                                          textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                          onPressed: () {
                                            Get.back();
                                          }));
                                }
                              } else {
                                setState(() {
                                  loadClients = false;
                                });
                                Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "لا يوجد",
                                    content: Text("لا يوجد عميل لة طلبات", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                    cancel: GFButton(
                                        size: GFSize.LARGE,
                                        color: AppConstants.orange,
                                        text: "الغاء",
                                        textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                        onPressed: () {
                                          Get.back();
                                        }));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          //DATA
          Scaffold(
              backgroundColor: AppConstants.grey,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GFBorder(
                            type: GFBorderType.rRect,
                            strokeWidth: 2,
                            dashedLine: [2, 0],
                            color: AppConstants.orange,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //CheckBox
                                GFButton(
                                  size: GFSize.LARGE,
                                  color: AppConstants.orange,
                                  text: "إضافة",
                                  textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                  onPressed: () {
                                    AppConstants.unitLocation = Offset(2500.0, 1250.0);
                                    AppConstants.playList = [];
                                    AppConstants.newVoiceLink = [];
                                    AppConstants.photoList = [];
                                    AppConstants.timer?.cancel();
                                    AppConstants.timer = null;
                                    AppConstants.tabControllerIndex = 1;
                                    Get.offAll(AddNewUnit());
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.height * .1),
                                Text("إضافة وحدة", textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white70, fontSize: 20, fontFamily: "Bell Gothic Light"))
                              ],
                            )),
                        allDataFromLiteUnits != []
                            ? createButtonsForUnits(allDataFromLiteUnits)
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "قاعدة البيانات خالية....",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: AppConstants.orange, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                ),
                              ),
                        //Second
                      ],
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          //Contacts Section
          Scaffold(
              backgroundColor: Colors.white,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: widgetsListProvider != null
                          ? createTable(widgetsListProvider)
                          : Container(
                              child: Text(""),
                            ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(0),
                      //constraints: BoxConstraints.expand(height: 50,width: 1000),
                      margin: EdgeInsets.all(0),
                      color: Colors.white,
                      child: GFBorder(
                          type: GFBorderType.rRect,
                          strokeWidth: 2,
                          dashedLine: [2, 0],
                          color: AppConstants.orange,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFButton(
                                size: GFSize.LARGE,
                                color: AppConstants.grey,
                                text: "إضافة",
                                textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                onPressed: () {
                                  //AppConstants.timer?.cancel();
                                  //AppConstants.timer = null;
                                  AppConstants().setcanRun(true);
                                  //Get.to(AddNewUser());
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "إضافة عميل جديد",
                                    content: Flexible(
                                        fit: FlexFit.loose,
                                        child: SingleChildScrollView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactName,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الأسم',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    //alignment: Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactMobile,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.ltr,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الهاتف',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactWork,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الوظيفة',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    //alignment: Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactCar,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل نوع العربية',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GFButton(
                                                      size: GFSize.LARGE,
                                                      color: AppConstants.grey,
                                                      text: "إلغاء",
                                                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                                      onPressed: () {
                                                        Get.back();
                                                      }),
                                                  SizedBox(width: MediaQuery.of(context).size.height * .1),
                                                  GFButton(
                                                      size: GFSize.LARGE,
                                                      color: AppConstants.grey,
                                                      text: "إضافة",
                                                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                                      onPressed: AppConstants().getcanRun() == true ? () => addClient() : () {})
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                              SizedBox(width: MediaQuery.of(context).size.height * .1),
                              Text("إضافة عميل", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"))
                            ],
                          )),
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void addClient() async {
    AppConstants.tabControllerIndex = 1;
    AppConstants().setcanRun(true);
    if (_newContactName.text != "") {
      if (_newContactMobile.text != "") {
        if (_newContactMobile.text.length == 11) {
          String name = _newContactName.text;
          String translatedNumbers = "";
          String work = _newContactWork.text;
          String car = _newContactCar.text;
          if (AppConstants().translateArabicNumToEng(_newContactMobile.text) != "Wrong Data") {
            translatedNumbers = AppConstants().translateArabicNumToEng(_newContactMobile.text);
            if (await AppConstants().checkMobileExistOrNotLocal(translatedNumbers) == true) {
              List<dynamic> nCFL = await AppConstants().newContactFunctionLocal(name, translatedNumbers, work, car, "", "[]");
              if (nCFL[0] == true) {
                AppConstants().setcanRun(true);
                widgetsListProvider = AppConstants().getcurrentUserContacts();
                print(widgetsListProvider);
                int syncInsertOperation = await dataBaseProvider.syncInsertOperation(ServerSync.withNoID(AppConstants().currentUserData.SQLID, AppConstants().currentUserData.OwnerId, "clients", nCFL[1], 'Insert'));
                widgetsListProvider = AppConstants().getcurrentUserContacts();
              } else {
                AppConstants().setcanRun(true);
              }
            } else {
              AppConstants().setcanRun(true);
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

  Column createButtonsForUnits(List<List> data) {
    //All Data For Villas
    var widgetsList = List<Widget>();
    bool villa = false;
    bool app = false;
    if (data != null) {
      if (data.length > 0) {
        if (data.length == 1) {
          data[0][1] == 1 ? villa = true : app = true;
        } else {
          villa = true;
          app = true;
        }
      }
    }

    widgetsList.add(SizedBox(height: 10.0.h));

    if (villa == true && AppConstants().getcurrentUserData().VILLA == 1) {
      Row villaRow = Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        /*GFButton(
            size: GFSize.LARGE,
            color: AppConstants.orange,
            child: Text("Test", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light")),
            onPressed: () async {
              debugPrint(AppConstants().getplatformVersion().toString());
        }),*/
        GFButton(
            size: GFSize.LARGE,
            color: AppConstants.orange,
            child: Text("بحث عن الفيلات علي الخريطة", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light")),
            onPressed: () async {
              List<List> allDataVillaStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage", "available"], "stage", groupedBy: "stage", whereCode: "unit = 1", debugCode: "stage", exFor: 'stage');
              if (allDataVillaStages != null) {
                List allVillaTypes = List();
                int currentStage;
                AppConstants().setAllDataFromLiteVillaStages(allDataVillaStages);
                for (int i = 0; i < allDataVillaStages.length; i++) {
                  currentStage = allDataVillaStages[i][0];
                  allVillaTypes
                      .add(await dataBaseProvider.aDGetAllDistinctValuesOfTypes(["unit", "stage", "unitType", "available"], "stage", groupedBy: "unitType", whereCode: "unit = 1 AND stage = $currentStage", debugCode: "unitType", exFor: 'type'));
                }
                AppConstants().setAllDataFromLiteVillaTypes(allVillaTypes);
                debugPrint("All Villa Types: " + AppConstants().getAllDataFromLiteVillaTypes().toString());
                debugPrint("Hello Villa");
                if (allVillaTypes != null) {
                  String firstType = allVillaTypes[0][0];
                  List allTypesOfFirstStage =
                      await dataBaseProvider.aDGetAllDistinctValuesOfTypesLocNumber(["unit", "unitType", "mapLoc", "unitNumber", "ID", "available","offerType"], "unitType", whereCode: "unit = 1 AND unitType = '$firstType'", exFor: 'everyType');
                  AppConstants().setAllLocationsOfFirstVillaTypeList(allTypesOfFirstStage);
                  debugPrint("Every Villa Types: " + AppConstants().getAllLocationsOfFirstVillaType().toString());
                  if (allVillaTypes != null && allTypesOfFirstStage != null) {
                    AppConstants.timer?.cancel();
                    AppConstants.timer = null;
                    AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 2 : AppConstants.tabControllerIndex = 1;
                    Get.offAll(VillaOnMAp(stage: AppConstants.getStageImage(allDataVillaStages[0][1], true), left: AppConstants.unitLocation.dx, top: AppConstants.unitLocation.dy));
                  }
                }
              }
            })
      ]);
      widgetsList.add(villaRow);
    }
    if (app == true && AppConstants().getcurrentUserData().APP == 1) {
      Row appRow = Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        GFButton(
            size: GFSize.LARGE,
            color: AppConstants.orange,
            child: Text("بحث عن الشقق علي الخريطة", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light")),
            onPressed: () async {
              //Stages of the App
              List<List> allDataAppStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 2", debugCode: "stage", exFor: 'stageApp');
              if (allDataAppStages != null) {
                List allAppTypes = List();
                int currentStage;
                //Stages of the App
                AppConstants().setAllDataFromLiteAppStages(allDataAppStages);
                for (int i = 0; i < allDataAppStages.length; i++) {
                  currentStage = allDataAppStages[i][0];
                  debugPrint("currentStage " + currentStage.toString());
                  allAppTypes
                      .add(await dataBaseProvider.aDGetAllDistinctValuesOfTypesApp(["unit", "stage", "unitGroup", "unitType"], "stage", groupedBy: "unitType", whereCode: "unit = 2 AND stage = $currentStage", debugCode: "unitType", exFor: 'type'));
                  debugPrint("allAppTypes " + allAppTypes.toString());
                  //allAppTypes [[[3, 31, 700]]]
                }
                currentStage = allDataAppStages[0][0];
                //All Types of the App at 1st found stage
                AppConstants().setAllDataFromLiteAppTypes(allAppTypes);
                debugPrint("All App Types: " + AppConstants().getAllDataFromLiteAppTypes().toString());
                debugPrint("Hello App");
                if (allAppTypes != null) {
                  //allAppTypes [[[3, 31, 700]]] --> allAppTypes[0][0][2]
                  String firstType = allAppTypes[0][0][2];
                  //String firstType = allAppTypes[0];
                  debugPrint("firstType" + firstType.toString());
                  List allTypesOfFirstStage = await dataBaseProvider
                      .aDGetAllDistinctValuesOfTypesLocNumber(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "available","offerType"], "unitType", whereCode: "unit = 2 AND stage = $currentStage AND unitType = '$firstType'", exFor: 'everyType');
                  AppConstants().setAllLocationsOfFirstAppTypeList(allTypesOfFirstStage);
                  debugPrint("allTypesOfFirstStage: " + AppConstants().getAllLocationsOfFirstAppType().toString());
                  List allLevelsForFirstType = await dataBaseProvider.aDGetAllDistinctValuesOfLevelsForEachType(["unit", "unitType", "mapLoc", "level", "unitNumber", "ID", "unitGroup", "available","offerType"], "level",
                      groupedBy: 'level', whereCode: "unit = 2 AND stage = $currentStage AND unitType = '$firstType'", exFor: 'allLevels');
                  if (allLevelsForFirstType != null) {
                    allLevelsForFirstType.insert(0, "All");
                    AppConstants().setAllLevelsOfFirstAppTypeList(allLevelsForFirstType);
                    debugPrint("Every Level of First Type: " + AppConstants().getAllLevelsOfFirstAppType().toString());
                    if (allAppTypes != null && allTypesOfFirstStage != null && allLevelsForFirstType != null) {
                      AppConstants.timer?.cancel();
                      AppConstants.timer = null;
                      AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 2 : AppConstants.tabControllerIndex = 1;
                      Get.offAll(AppOnMAp(stage: AppConstants.getStageImage(allDataAppStages[0][1], true), left: AppConstants.unitLocation.dx, top: AppConstants.unitLocation.dy));
                    }
                  }
                }
              }
            })
      ]);
      widgetsList.add(SizedBox(height: 1.0.h));
      widgetsList.add(appRow);
    }
    widgetsList.add(SizedBox(height: 10.0.h));
    Row othersRow = Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      GFButton(
          size: GFSize.LARGE,
          color: AppConstants.orange,
          child: Text("بحث عند الغير", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light")),
          onPressed: () async {
            AppConstants.timer?.cancel();
            AppConstants.timer = null;
            AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 2 : AppConstants.tabControllerIndex = 1;
            Get.offAll(OthersPage());
          })
    ]);
    widgetsList.add(othersRow);
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: widgetsList);
  }

  Column createTable(List<ClientTable> data) {
    data = AppConstants().getcurrentUserContacts();
    debugPrint("START WIDGET");
    var widgetsList = List<Widget>();
    widgetsList.add(SizedBox(height: 70));
    String englishLettersList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String currentLetter = "";
    bool EnglishContinue = false;
    for (int i = 0; i < data.length; i++) {
      EnglishContinue = false;
      for (int iE = 0; iE < englishLettersList.length; iE++) {
        if (data[i].CONTACTNAME.toString()[0].capitalize == englishLettersList[iE]) {
          EnglishContinue = true;
          break;
        } else {
          EnglishContinue = false;
        }
      }
      if (EnglishContinue == false) {
        continue;
      }
      if (data[i].CONTACTNAME.toString()[0].capitalize != currentLetter) {
        currentLetter = data[i].CONTACTNAME.toString()[0].capitalize;
        widgetsList.add(Container(
          height: 40,
          child: Center(child: Text(currentLetter, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"))),
        ));
      }
      widgetsList.add(GFListTile(
        onLongPress: () async {
          FlutterPhoneDirectCaller.callNumber(data[i].CONTACTMOBILE.toString());
        },
        onTap: () async {
          AppConstants().setselectedContact(data[i]);
          AppConstants.timer?.cancel();
          AppConstants.timer = null;
          bool aTemp;
          await dataBaseProvider.syncGetAllValuesWhere(columnsNames: ["dataBaseName", "dataID"], whereCode: "dataBaseName = 'clients' AND dataID = " + AppConstants().getselectedContact().SQLID.toString() + "").then((value) {
            debugPrint("Client ID is updating: " + value.toString());
            if (value.length > 0) {
              AppConstants.idClientIsUpdating = true;
              aTemp = true;
            } else {
              AppConstants.idClientIsUpdating = false;
              aTemp = false;
            }
          });
          AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 3 : AppConstants.tabControllerIndex = 2;
          if (aTemp == false) {
            Get.offAll(ContactListItemTap());
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
        },
        textColor: i % 2 == 0 ? AppConstants.grey : Colors.white,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        titleText: data[i].CONTACTNAME.toString(),
        subtitleText: data[i].CONTACTMOBILE.toString(),
        icon: Icon(
          Icons.edit,
          color: i % 2 == 0 ? AppConstants.grey : Colors.white,
        ),
        description: Text("الوظيفة: " + data[i].CONTACTWORK.toString() + "   نوع السيارة:" + data[i].CONTACTCAR.toString(),
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: i % 2 == 0 ? AppConstants.grey : Colors.white,
            )),
        margin: EdgeInsets.all(3),
        color: i % 2 == 0 ? AppConstants.orange : AppConstants.grey,
      ));
    }
    // ARABIC SECTION
    EnglishContinue = true;
    currentLetter = "";

    for (int i1 = 0; i1 < data.length; i1++) {
      EnglishContinue = true;
      for (int iE1 = 0; iE1 < englishLettersList.length; iE1++) {
        if (data[i1].CONTACTNAME.toString()[0].capitalize == englishLettersList[iE1]) {
          EnglishContinue = false;
          break;
        }
      }
      if (EnglishContinue == false) {
        continue;
      }
      if (data[i1].CONTACTNAME.toString()[0] != currentLetter) {
        currentLetter = data[i1].CONTACTNAME.toString()[0];
        if (currentLetter != "ا") {
          widgetsList.add(Container(
            height: 80,
            child: Center(child: Text(currentLetter, style: TextStyle(color: AppConstants.grey, fontSize: 50, fontFamily: "Bell Gothic Light"))),
          ));
        }
      }
      widgetsList.add(GFListTile(
        onLongPress: () async {
          FlutterPhoneDirectCaller.callNumber(data[i1].CONTACTMOBILE.toString());
        },
        onTap: () async {
          AppConstants().setselectedContact(data[i1]);
          AppConstants.timer?.cancel();
          AppConstants.timer = null;
          bool aTemp;
          await dataBaseProvider.syncGetAllValuesWhere(columnsNames: ["dataBaseName", "dataID"], whereCode: "dataBaseName = 'clients' AND dataID = " + AppConstants().getselectedContact().SQLID.toString() + "").then((value) {
            debugPrint("Client ID is updating: " + value.toString());
            if (value.length > 0) {
              AppConstants.idClientIsUpdating = true;
              aTemp = true;
            } else {
              AppConstants.idClientIsUpdating = false;
              aTemp = false;
            }
          });
          AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 3 : AppConstants.tabControllerIndex = 2;
          if (aTemp == false) {
            Get.offAll(ContactListItemTap());
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
        },
        textColor: i1 % 2 == 0 ? AppConstants.grey : Colors.white,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        titleText: data[i1].CONTACTNAME.toString(),
        subtitleText: data[i1].CONTACTMOBILE.toString(),
        icon: Icon(
          Icons.edit,
          color: i1 % 2 == 0 ? AppConstants.grey : Colors.white,
        ),
        description: Text("الوظيفة:   " + data[i1].CONTACTWORK.toString() + "   نوع السيارة:   " + data[i1].CONTACTCAR.toString(),
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: i1 % 2 == 0 ? AppConstants.grey : Colors.white,
            )),
        margin: EdgeInsets.all(3),
        color: i1 % 2 == 0 ? AppConstants.orange : AppConstants.grey,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgetsList,
    );
  }

  Column createTableForReminder(List<ClientTable> data) {
    data = AppConstants().getcurrentUserContacts();
    debugPrint("START WIDGET");
    var widgetsList = List<Widget>();
    widgetsList.add(SizedBox(height: 18.0.h));
    String englishLettersList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String currentLetter = "";
    bool EnglishContinue = false;
    for (int i = 0; i < data.length; i++) {
      EnglishContinue = false;
      for (int iE = 0; iE < englishLettersList.length; iE++) {
        if (data[i].CONTACTNAME.toString()[0].capitalize == englishLettersList[iE]) {
          EnglishContinue = true;
          break;
        } else {
          EnglishContinue = false;
        }
      }
      if (EnglishContinue == false) {
        continue;
      }
      if (data[i].ACTIVEUSER == 1) {
        if (data[i].CONTACTNAME.toString()[0].capitalize != currentLetter) {
          currentLetter = data[i].CONTACTNAME.toString()[0].capitalize;
          widgetsList.add(Container(
            height: 40,
            child: Center(child: Text(currentLetter, style: TextStyle(color: AppConstants.orange, fontSize: 20, fontFamily: "Bell Gothic Light"))),
          ));
        }
        widgetsList.add(GFListTile(
          onLongPress: () async {
            FlutterPhoneDirectCaller.callNumber(data[i].CONTACTMOBILE.toString());
          },
          onTap: () async {
            AppConstants().setselectedContact(data[i]);
            AppConstants.timer?.cancel();
            AppConstants.timer = null;
            AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 1 : AppConstants.tabControllerIndex = 0;
            Get.offAll(ContactListItemTap());
          },
          //textColor: i % 2 == 0 ? AppConstants.grey : Colors.white,
          textColor: AppConstants.grey,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          titleText: data[i].CONTACTNAME.toString(),
          subtitleText: data[i].CONTACTMOBILE.toString(),
          icon: Icon(
            Icons.edit,
            //color: i % 2 == 0 ? AppConstants.grey : Colors.white,
            color: AppConstants.grey,
          ),
          description: Text("الوظيفة: " + data[i].CONTACTWORK.toString() + "   نوع السيارة:" + data[i].CONTACTCAR.toString(),
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: AppConstants.grey,
              )),
          margin: EdgeInsets.all(3),
          color: i % 2 == 0 ? AppConstants.orange : Colors.white,
        ));
      }
    }
    // ARABIC SECTION
    EnglishContinue = true;
    currentLetter = "";

    for (int i1 = 0; i1 < data.length; i1++) {
      EnglishContinue = true;
      for (int iE1 = 0; iE1 < englishLettersList.length; iE1++) {
        if (data[i1].CONTACTNAME.toString()[0].capitalize == englishLettersList[iE1] && data[i1].ACTIVEUSER == 1) {
          EnglishContinue = false;
          break;
        }
      }
      if (EnglishContinue == false) {
        continue;
      }
      if (data[i1].ACTIVEUSER == 1) {
        if (data[i1].CONTACTNAME.toString()[0] != currentLetter) {
          currentLetter = data[i1].CONTACTNAME.toString()[0];
          if (currentLetter != "ا") {
            widgetsList.add(Container(
              height: 80,
              child: Center(child: Text(currentLetter, style: TextStyle(color: AppConstants.orange, fontSize: 50, fontFamily: "Bell Gothic Light"))),
            ));
          }
        }
        widgetsList.add(GFListTile(
          onLongPress: () async {
            FlutterPhoneDirectCaller.callNumber(data[i1].CONTACTMOBILE.toString());
          },
          onTap: () async {
            AppConstants().setselectedContact(data[i1]);
            AppConstants.timer?.cancel();
            AppConstants.timer = null;
            AppConstants.tabControllerIndex = AppConstants().getcurrentUserData().Owner == 1 || AppConstants().getcurrentUserData().Admin == 1 ? AppConstants.tabControllerIndex = 1 : AppConstants.tabControllerIndex = 0;
            Get.offAll(ContactListItemTap());
          },
          textColor: AppConstants.grey,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          titleText: data[i1].CONTACTNAME.toString(),
          subtitleText: data[i1].CONTACTMOBILE.toString(),
          icon: Icon(
            Icons.edit,
            color: AppConstants.grey,
          ),
          description: Text("الوظيفة:   " + data[i1].CONTACTWORK.toString() + "   نوع السيارة:   " + data[i1].CONTACTCAR.toString(),
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: AppConstants.grey,
              )),
          margin: EdgeInsets.all(3),
          color: i1 % 2 == 0 ? AppConstants.orange : Colors.white,
        ));
      }
    }

    debugPrint("widgetsList.length: " + widgetsList.length.toString());
    if (widgetsList.length == 1) {
      widgetsList.add(SizedBox(height: 2.0.h));
      widgetsList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("لا يوجد عميل لدية طلبات", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.orange, fontSize: 25.0.sp, fontFamily: "Bell Gothic Light")),
        ],
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgetsList,
    );
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  //Admin workers
  Column workersTable(List<WorkerTable> data) {
    debugPrint("START WIDGET");
    var widgetsList = List<Widget>();
    widgetsList.add(SizedBox(height: 20.0.h));
    for (int y = 0; y < data.length; y++) {
      GFAccordion gfAccordion = GFAccordion(
          contentBackgroundColor: AppConstants.grey,
          contentBorder: Border.all(color: AppConstants.orange),
          titleChild: Text(data[y].Name, textAlign: TextAlign.right, textDirection: TextDirection.rtl, style: TextStyle(color: Colors.black, fontSize: 18.0.sp, fontFamily: AppConstants.BellGothisLight)),
          contentChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Name of the worker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text(data[y].Name, textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"))],
              ),
              //Phone of the worker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text(data[y].Mobile, textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"))],
              ),
              //Active , Admin Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("الحالة", textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white70, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text("مفعل", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                  SizedBox(width: 2.0.w),
                  GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: AppConstants.orange,
                      onChanged: (value) {
                        setState(() {
                          data[y].Active = value == true ? 1 : 0;
                        });
                      },
                      value: data[y].Active == 1 ? true : false),
                  //SizedBox(width: 2.0.w),
                  SizedBox(width: 15.0.w),
                  GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: AppConstants.orange,
                      onChanged: (value) {
                        setState(() {
                          data[y].Admin = value == true ? 1 : 0;
                        });
                      },
                      value: data[y].Admin == 1 ? true : false),
                  SizedBox(width: 2.0.w),
                  Text("مدير", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                  Spacer()
                ],
              ),
              //Villa , App , Shop Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("النشاط", textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white70, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text("محلات", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                  SizedBox(width: 2.0.w),
                  GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: AppConstants.orange,
                      onChanged: (value) {
                        setState(() {
                          data[y].SHOP = value == true ? 1 : 0;
                        });
                      },
                      value: data[y].SHOP == 1 ? true : false),
                  Spacer(),
                  Text("عمارات", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                  SizedBox(width: 2.0.w),
                  GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: AppConstants.orange,
                      onChanged: (value) {
                        setState(() {
                          data[y].APP = value == true ? 1 : 0;
                        });
                      },
                      value: data[y].APP == 1 ? true : false),
                  Spacer(),
                  Text("فيلات", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light")),
                  SizedBox(width: 2.0.w),
                  GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: AppConstants.orange,
                      onChanged: (value) {
                        setState(() {
                          data[y].VILLA = value == true ? 1 : 0;
                        });
                      },
                      value: data[y].VILLA == 1 ? true : false),
                  Spacer(),
                ],
              ),
              SizedBox(height: 5.0.w),
              //Save button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GFButton(
                      size: GFSize.MEDIUM,
                      color: AppConstants.orange,
                      text: "حفظ",
                      textStyle: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                      onPressed: () async {
                        setState(() {
                          savingWorkerSettingIndicator = true;
                        });
                        //Check Internet First
                        if (await AppConstants().checkRealInternet() == 1) {
                          int changeWorkerSettingReturnValue = await AppConstants().changeWorkersSetting(
                              workerSQLID: data[y].SQLID,
                              ownerID: AppConstants().getcurrentUserData().OwnerId,
                              editedByID: AppConstants().getcurrentUserData().SQLID,
                              editedByName: AppConstants().getcurrentUserData().Name,
                              admin: data[y].Admin,
                              active: data[y].Active,
                              villa: data[y].VILLA,
                              app: data[y].APP,
                              shop: data[y].SHOP);
                          //Return Data is null
                          if (changeWorkerSettingReturnValue == 0) {
                            setState(() {
                              loadWorkers = false;
                              savingWorkerSettingIndicator = false;
                            });
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "لا يوجد اتصال بالشبكة",
                                content: Text("حاول مرة اخري...", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                cancel: GFButton(
                                    size: GFSize.LARGE,
                                    color: AppConstants.orange,
                                    text: "الغاء",
                                    textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                    onPressed: () {
                                      Get.back();
                                    }));
                          }
                          //PHP Query was not set
                          else if (changeWorkerSettingReturnValue == 2) {
                            setState(() {
                              loadWorkers = false;
                              savingWorkerSettingIndicator = false;
                            });
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "يوجد خطأ في الأتصال بالخادم",
                                content: Text("حاول مرة اخري...", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                cancel: GFButton(
                                    size: GFSize.LARGE,
                                    color: AppConstants.orange,
                                    text: "الغاء",
                                    textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                    onPressed: () {
                                      Get.back();
                                    }));
                          }
                          //Setting Saved successfully
                          else if (changeWorkerSettingReturnValue == 1) {
                            setState(() {
                              savingWorkerSettingIndicator = false;
                            });
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "تم التعديل",
                                content: Text("تم تعديل بيانات الموظف\n" + data[y].Name, textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                cancel: GFButton(
                                    size: GFSize.LARGE,
                                    color: AppConstants.orange,
                                    text: "إغلاق",
                                    textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                    onPressed: () {
                                      Get.back();
                                    }));
                          }
                        }
                        //If no Internet Found
                        else {
                          setState(() {
                            loadWorkers = false;
                            savingWorkerSettingIndicator = false;
                          });
                          Get.defaultDialog(
                              barrierDismissible: false,
                              title: "لا يوجد اتصال بالشبكة",
                              content: Text("حاول مرة اخري...", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                              cancel: GFButton(
                                  size: GFSize.LARGE,
                                  color: AppConstants.orange,
                                  text: "الغاء",
                                  textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                  onPressed: () {
                                    Get.back();
                                  }));
                        }
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  savingWorkerSettingIndicator == true
                      ? CircularProgressIndicator(
                          backgroundColor: AppConstants.orange,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ));
      widgetsList.add(gfAccordion);
      widgetsList.add(SizedBox(height: 2.0.h));
      if (y == data.length - 1) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgetsList,
        );
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgetsList,
    );
  }

  GFTabs ownerTabs() {
    return GFTabs(
      tabBarHeight: 12.0.h,
      //isScrollable: true,
      indicatorColor: AppConstants.orange,
      tabBarColor: AppConstants.grey,
      labelStyle: TextStyle(color: Colors.white, fontSize: 17.0.sp, fontFamily: AppConstants.MarkaziText, fontWeight: FontWeight.w700),
      initialIndex: AppConstants.tabControllerIndex,
      //initialIndex: 6,
      length: 4,

      tabs: <Widget>[
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("الأدارة",textAlign: TextAlign.center)),
        ),
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("مذكرة",textAlign: TextAlign.center)),
        ),
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("بيانات",textAlign: TextAlign.center)),
        ),
        Tab(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("العملاء",textAlign: TextAlign.center)),
        ),
      ],
      tabBarView: GFTabBarView(
        //controller: tabController,
        children: <Widget>[
          //Admin
          Scaffold(
              backgroundColor: AppConstants.grey,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    loadWorkers == true ? SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(), child: workersTable(workersData)) : SizedBox.shrink(),
                    Container(
                      color: AppConstants.grey,
                      height: 20.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GFBorder(
                              type: GFBorderType.rRect,
                              strokeWidth: 2,
                              dashedLine: [2, 0],
                              color: AppConstants.orange,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Text("إدارة أفراد الشركة", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"))],
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height * .01),
                          GFButton(
                            size: GFSize.LARGE,
                            color: AppConstants.orange,
                            text: "إظهار بيانات الشركة",
                            textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                            onPressed: () async {
                              if (await AppConstants().checkRealInternet() == 1) {
                                workersData = await AppConstants().getWorkers();
                                if (workersData != null) {
                                  if (workersData.length > 0) {
                                    debugPrint("WORKERS COUNT IS: " + workersData.length.toString());
                                    setState(() {
                                      loadWorkers = true;
                                    });
                                  } else {
                                    setState(() {
                                      loadWorkers = false;
                                    });
                                    Get.defaultDialog(
                                        barrierDismissible: false,
                                        title: "لا يوجد",
                                        content: Text("لا يوجد أفراد سوي صاحب الشركة فقط", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                        cancel: GFButton(
                                            size: GFSize.LARGE,
                                            color: AppConstants.orange,
                                            text: "الغاء",
                                            textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                            onPressed: () {
                                              Get.back();
                                            }));
                                  }
                                } else {
                                  setState(() {
                                    loadWorkers = false;
                                  });
                                  debugPrint("MAY BE ERROR ON SERVER");
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "لا يوجد",
                                      content: Text("لا يوجد أفراد سوي صاحب الشركة فقط", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                      cancel: GFButton(
                                          size: GFSize.LARGE,
                                          color: AppConstants.orange,
                                          text: "الغاء",
                                          textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                          onPressed: () {
                                            Get.back();
                                          }));
                                }
                                /*
                              _deleteCacheDir();
                              _deleteAppDir();
                              AppConstants.timer?.cancel();
                              AppConstants.timer = null;
                              AppConstants.onExitVar = false;
                              Get.offAll(ExitPage());
                              */
                              } else {
                                setState(() {
                                  loadWorkers = false;
                                });
                                Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "لا يوجد اتصال بالشبكة",
                                    content: Text("حاول مرة اخري...", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                    cancel: GFButton(
                                        size: GFSize.LARGE,
                                        color: AppConstants.orange,
                                        text: "الغاء",
                                        textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                        onPressed: () {
                                          Get.back();
                                        }));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          //Reminder
          Scaffold(
              backgroundColor: AppConstants.grey,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    loadClients == true
                        ? SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: widgetsListProvider != null ? createTableForReminder(widgetsListProvider) : SizedBox.shrink(),
                          )
                        : SizedBox.shrink(),
                    Container(
                      color: AppConstants.grey,
                      height: 20.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GFBorder(
                              type: GFBorderType.rRect,
                              strokeWidth: 2,
                              dashedLine: [2, 0],
                              color: AppConstants.orange,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Text("عملاء لديهم طلبات لم تنفذ", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.orange, fontSize: 20.0.sp, fontFamily: "Bell Gothic Light"))],
                              )),
                          SizedBox(height: MediaQuery.of(context).size.height * .01),
                          GFButton(
                            size: GFSize.LARGE,
                            color: AppConstants.orange,
                            text: "إعادة إظهار العملاء",
                            textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                            onPressed: () {
                              setState(() {
                                loadClients = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          //DATA
          Scaffold(
              backgroundColor: AppConstants.grey,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GFBorder(
                            type: GFBorderType.rRect,
                            strokeWidth: 2,
                            dashedLine: [2, 0],
                            color: AppConstants.orange,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //CheckBox
                                GFButton(
                                  size: GFSize.LARGE,
                                  color: AppConstants.orange,
                                  text: "إضافة",
                                  textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                  onPressed: () {
                                    AppConstants.unitLocation = Offset(2500.0, 1250.0);
                                    AppConstants.playList = [];
                                    AppConstants.newVoiceLink = [];
                                    AppConstants.photoList = [];
                                    AppConstants.timer?.cancel();
                                    AppConstants.timer = null;
                                    AppConstants.tabControllerIndex = 2;
                                    Get.offAll(AddNewUnit());
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.height * .1),
                                Text("إضافة وحدة", textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white70, fontSize: 20, fontFamily: "Bell Gothic Light"))
                              ],
                            )),
                        allDataFromLiteUnits != []
                            ? createButtonsForUnits(allDataFromLiteUnits)
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "قاعدة البيانات خالية....",
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: AppConstants.orange, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                ),
                              ),
                        //Second
                      ],
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
          //Contacts Section
          Scaffold(
              backgroundColor: Colors.white,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: widgetsListProvider != null ? createTable(widgetsListProvider) : SizedBox.shrink(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(0),
                      //constraints: BoxConstraints.expand(height: 50,width: 1000),
                      margin: EdgeInsets.all(0),
                      color: Colors.white,
                      child: GFBorder(
                          type: GFBorderType.rRect,
                          strokeWidth: 2,
                          dashedLine: [2, 0],
                          color: AppConstants.orange,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //CheckBox
                              GFButton(
                                size: GFSize.LARGE,
                                color: AppConstants.grey,
                                text: "إضافة",
                                textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                onPressed: () {
                                  //AppConstants.timer?.cancel();
                                  //AppConstants.timer = null;
                                  AppConstants().setcanRun(true);
                                  //Get.to(AddNewUser());
                                  Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "إضافة عميل جديد",
                                    content: Flexible(
                                        fit: FlexFit.loose,
                                        child: SingleChildScrollView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactName,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الأسم',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    //alignment: Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactMobile,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.ltr,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الهاتف',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactWork,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل الوظيفة',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Center(
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    //alignment: Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: AppConstants.grey,
                                                    ),
                                                    //height: 50.0,
                                                    child: TextField(
                                                      controller: _newContactCar,
                                                      textAlign: TextAlign.right,
                                                      keyboardType: TextInputType.text,
                                                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: AppConstants.BellGothisLight),
                                                      textDirection: TextDirection.rtl,
                                                      decoration: InputDecoration(
                                                        alignLabelWithHint: true,
                                                        border: InputBorder.none,
                                                        hintText: 'أدخل نوع العربية',
                                                        hintStyle: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                          fontFamily: "Bell Gothic Light",
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * .01),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GFButton(
                                                      size: GFSize.LARGE,
                                                      color: AppConstants.grey,
                                                      text: "إلغاء",
                                                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                                      onPressed: () {
                                                        Get.back();
                                                      }),
                                                  SizedBox(width: MediaQuery.of(context).size.height * .1),
                                                  GFButton(
                                                      size: GFSize.LARGE,
                                                      color: AppConstants.grey,
                                                      text: "إضافة",
                                                      textStyle: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                                      onPressed: AppConstants().getcanRun() == true ? () => addClient() : () {})
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                              SizedBox(width: MediaQuery.of(context).size.height * .1),
                              Text("إضافة عميل", textDirection: TextDirection.rtl, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"))
                            ],
                          )),
                    ),
                    AppConstants.showCircle == true
                        ? Positioned(
                            left: 3.0.w,
                            top: 2.0.h,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 40,
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
