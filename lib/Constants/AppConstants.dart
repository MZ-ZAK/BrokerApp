import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:get_mac/get_mac.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/ClientTable.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';
import 'package:madinaty_app/DataBase/workerTable.dart';
import 'package:madinaty_app/Screens/LoginPage.dart';
import 'package:madinaty_app/Screens/MyConnectivity.dart';
import 'package:madinaty_app/Screens/RequestPage.dart';
import 'package:madinaty_app/Screens/UserPage.dart';
import 'package:madinaty_app/Screens/WaitingPage.dart';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AppConstants {
  // DataBase instance
  DataBaseProvider dataBaseProvider = DataBaseProvider.db;

  static AppConstants _instance;
  factory AppConstants() => _instance ??= AppConstants._();
  AppConstants._();

  //current contact selected in the user page contact list
  ClientTable selectedContact; //False Go To Waiting Page
  ClientTable getselectedContact() {
    return selectedContact;
  }

  setselectedContact(ClientTable value) {
    selectedContact = value;
  }

  //current Unit selected on the Map for Editing
  AllData selectedUnitForEditing; //False Go To Waiting Page
  AllData getSelectedUnitForEditing() {
    return selectedUnitForEditing;
  }

  setSelectedUnitForEditing(AllData value) {
    selectedUnitForEditing = value;
  }

  //Access types
  bool ServerIDFFound = false; //False Go To Waiting Page
  bool getServerIDFFound() {
    return ServerIDFFound;
  }

  setServerIDFFound(bool value) {
    ServerIDFFound = value;
  }

  bool ServerIDWaiting = false; //False Go To User Page
  bool getServerIDWaiting() {
    return ServerIDWaiting;
  }

  setServerIDWaiting(bool value) {
    ServerIDWaiting = value;
  }

  //Mac Address
  String platformVersion = 'Unknown';
  String getplatformVersion() {
    return platformVersion;
  }

  setplatformVersion(String value) {
    platformVersion = value;
  }

  initPlatformState() async {
    String platformVersionResult;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      //934d7fb319d2bfcc
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        platformVersionResult = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        platformVersionResult = androidDeviceInfo.androidId; // unique ID on Android
      }
      debugPrint(platformVersionResult.toString());
      //platformVersionResult = await GetMac.macAddress;
    } on PlatformException {
      platformVersionResult = 'Failed to get Device MAC Address.';
    }
    setplatformVersion(platformVersionResult);

    if (onExitVar) {
      syncDataToServer();
    }
  }

  //Stops Any New Inputs
  bool canRun = true;
  bool getcanRun() {
    return canRun;
  }

  setcanRun(bool value) {
    canRun = value;
  }

  //phone owner current database row
  WorkerTable currentUserData;
  WorkerTable getcurrentUserData() {
    return currentUserData;
  }

  setcurrentUserData(WorkerTable value) {
    currentUserData = value;
  }

  //phone owner current Contacts
  dynamic currentUserContacts;
  dynamic getcurrentUserContacts() {
    return currentUserContacts;
  }

  setcurrentUserContacts(dynamic value) {
    currentUserContacts = value;
  }

  //All Data for Maps
  //Units
  List<List> allDataFromLiteUnits;
  List<List> getAllDataFromLiteUnits() {
    return allDataFromLiteUnits;
  }

  setAllDataFromLiteUnits(List<List> value) {
    allDataFromLiteUnits = value;
  }

  //Stages Villa
  List<List> allDataFromLiteVillaStages;
  List<List> getAllDataFromLiteVillaStages() {
    return allDataFromLiteVillaStages;
  }

  setAllDataFromLiteVillaStages(List<List> value) {
    allDataFromLiteVillaStages = value;
  }

  //App Villa
  List<List> allDataFromLiteAppStages;
  List<List> getAllDataFromLiteAppStages() {
    return allDataFromLiteAppStages;
  }

  setAllDataFromLiteAppStages(List<List> value) {
    allDataFromLiteAppStages = value;
  }

  //Villa Groups
  List<List> allDataFromLiteVillaGroups;
  List<List> getAllDataFromLiteVillaGroups() {
    return allDataFromLiteVillaGroups;
  }

  setAllDataFromLiteVillaGroups(List<List> value) {
    allDataFromLiteVillaGroups = value;
  }

  //Villa Types
  List allDataFromLiteVillaTypes;
  List getAllDataFromLiteVillaTypes() {
    return allDataFromLiteVillaTypes;
  }

  setAllDataFromLiteVillaTypes(List value) {
    allDataFromLiteVillaTypes = value;
  }

  //App Types
  List allDataFromLiteAppTypes;
  List getAllDataFromLiteAppTypes() {
    return allDataFromLiteAppTypes;
  }

  setAllDataFromLiteAppTypes(List value) {
    allDataFromLiteAppTypes = value;
  }

  //All Locations of First Villa Types
  List allLocationsOfFirstVillaType;
  List getAllLocationsOfFirstVillaType() {
    return allLocationsOfFirstVillaType;
  }

  setAllLocationsOfFirstVillaTypeList(value) {
    allLocationsOfFirstVillaType = value;
  }

  //All Locations of First App Types
  List allLocationsOfFirstAppType;
  List getAllLocationsOfFirstAppType() {
    return allLocationsOfFirstAppType;
  }

  setAllLocationsOfFirstAppTypeList(value) {
    allLocationsOfFirstAppType = value;
  }

  //All Levels for First App type at this stage
  List allLevelsOfFirstAppType;
  List getAllLevelsOfFirstAppType() {
    return allLevelsOfFirstAppType;
  }

  setAllLevelsOfFirstAppTypeList(value) {
    allLevelsOfFirstAppType = value;
  }
  //////////////////////////////////////////////

  //return length of string
  dynamic getMeDynamic(String respond) {
    var message = jsonDecode(respond);
    return message.length;
  }

  dynamic getMeDynamicIndex(String respond, int index) {
    String part1 = "";
    String part2 = "[";
    bool firstPart1 = false;
    bool firstPart2 = false;
    for (String letter in respond.characters) {
      if (firstPart1 == false) {
        if (letter != "}") {
          part1 = part1 + letter;
        } else {
          part1 = part1 + letter + "]";
          firstPart1 = true;
        }
      } else {
        if (firstPart2 == true) {
          part2 = part2 + letter;
        }
        firstPart2 = true;
      }
    }
    debugPrint(part2);
    var message;
    if (index == 0) {
      message = jsonDecode(part1);
    } else {
      if (part2 == "[[]]") {
        message = null;
      } else {
        message = jsonDecode(part2);
      }
    }
    return message;
  }

  //Get the workers
  Future<List<WorkerTable>> getWorkers() async {
    var url = websiteURL + "getWorkers.php";
    var data = new Map<String, dynamic>();
    data['ID'] = getcurrentUserData().OwnerId;
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
    } catch (err) {
      print('response Caught error: $err');
      return null;
    }
    if (response != null) {
      if (response.statusCode == 200) {
        debugPrint(jsonDecode(response.body).toString());
        List<WorkerTable> as = List();
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
          dynamic worker = jsonDecode(response.body)[i];
          as.add(WorkerTable.withNoID(
              int.parse(worker[0]), worker[1], worker[2], worker[3], int.parse(worker[4]), int.parse(worker[5]), int.parse(worker[6]), int.parse(worker[7]), worker[8], worker[9], int.parse(worker[10]), worker[11], worker[12], int.parse(worker[13]),
            int.parse(worker[14]),int.parse(worker[15]),int.parse(worker[16])));
        }
        return as;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //Change Workers Setting OWNER/ADMIN ONLY
  Future<int> changeWorkersSetting({int workerSQLID, int ownerID, int editedByID, String editedByName, int active, int admin, int villa, int app, int shop}) async {
    var url = websiteURL + "changeWorkersSetting.php";
    var data = new Map<String, dynamic>();
    data['workerSQLID'] = workerSQLID;
    data['OWNERID'] = ownerID;
    data['EditedByID'] = editedByID;
    data['EditedByName'] = editedByName;
    data['ACTIVE'] = active;
    data['ADMIN'] = admin;
    data['VILLA'] = villa;
    data['APP'] = app;
    data['SHOP'] = shop;
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
    } catch (err) {
      print('response Caught error: $err');
      return null;
    }
    if (response != null) {
      if (response.statusCode == 200) {
        debugPrint(jsonDecode(response.body).toString());
        return int.parse(jsonDecode(response.body).toString());
      }
    } else {
      return 0;
    }
    return 0;
  }

  //Check REAL INTERNET not connection
  Future<int> checkRealInternet() async {
    var url = websiteURL + "check.php";
    http.Response response;
    try {
      response = await http.post(url).timeout(Duration(seconds: 2), onTimeout: () {
        return null;
      });
    } catch (err) {
      print('response Caught error: $err');
      return 0;
      Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    if (response != null) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("Internet check and its THERE!!!!");
        return 1;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  //Login Function
  Future<int> loginFunction() async {
    String mac = getplatformVersion();
    //String mac = "acfce6a3007f2944"; //Kareem
    //String mac = "dcd23e8c81dcf1b6";  //Adel
    //String mac = DateTime.now().millisecondsSinceEpoch.toString();
    var url = websiteURL + "login.php";
    var data = new Map<String, dynamic>();
    data['mac'] = mac;
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
    } catch (err) {
      print('response Caught error: $err');
      return 0;
    }
    if (response.statusCode == 200) {
      print(response.body.toString());
      var jsonResponse = jsonDecode(response.body);
      print("jsonResponse  part: " + jsonResponse.toString());

      if (jsonResponse.toString() == "[0]") {
        return 3;
      } else if (jsonResponse.toString() == "[100]") {
        return 2;
      } else {
        if (jsonResponse[2].length > 0) {
          //print("Clients  part: " + jsonResponse[1].toString());
          List<AllData> allUnits = listToAllData(jsonResponse[2]);
          for (int i = 0; i < allUnits.length; i++) {
            await dataBaseProvider.aDInsertUnit(allUnits[i]);
            if (i == allUnits.length - 1) {
              List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
              if (allDataUnits != null) {
                AppConstants().setAllDataFromLiteUnits(allDataUnits);
              }
            }
          }
        }

        if (jsonResponse[1].length > 0) {
          //print("Clients  part: " + jsonResponse[1].toString());
          List<ClientTable> a = listToClients(jsonResponse[1]);
          setcurrentUserContacts(a);
          for (int i = 0; i < a.length; i++) {
            await dataBaseProvider.cInsertContact(a[i]);
            if (i == a.length - 1) {
              List<ClientTable> clientTable = await dataBaseProvider.cGetAllRowsByTableName();
              setcurrentUserContacts(clientTable);
            }
          }
        } else {
          setcurrentUserContacts(null);
        }

        if (jsonResponse[0] != null) {
          //print("Worker  part: " + jsonResponse[0].toString());
          //setcurrentUserData(jsonResponse[0]);
          if (jsonResponse[0]['ACTIVE'] == "1") {
            int value = await dataBaseProvider.wInsertContact(WorkerTable.withNoID(
                int.parse(jsonResponse[0]['ID']),
                jsonResponse[0]['NAME'],
                jsonResponse[0]['MOBILE'],
                jsonResponse[0]['MAC'],
                int.parse(jsonResponse[0]['ACTIVE']),
                int.parse(jsonResponse[0]['ADMIN']),
                int.parse(jsonResponse[0]['OWNER']),
                int.parse(jsonResponse[0]['OWNERID']),
                jsonResponse[0]['COMPANYNAME'],
                jsonResponse[0]['COMPANYMOBILE'],
                int.parse(jsonResponse[0]['WORKERSCOUNT']),
                jsonResponse[0]['STARTDATE'],
                jsonResponse[0]['ENDDATE'],
                int.parse(jsonResponse[0]['LASTUPDATEID']),
                int.parse(jsonResponse[0]['VILLA']),
                int.parse(jsonResponse[0]['APP']),
                int.parse(jsonResponse[0]['SHOP'])));

            /*
            WorkerTable workerTable = WorkerTable.withNoID(jsonResponse[0].ID, jsonResponse[0].NAME, jsonResponse[0].MOBILE,
                jsonResponse[0].MAC, jsonResponse[0].ACTIVE, jsonResponse[0].ADMIN, jsonResponse[0].OWNER,
                jsonResponse[0].OWNERID, jsonResponse[0].COMPANYNAME, jsonResponse[0].STARTDATE, jsonResponse[0].ENDDATE);
            setcurrentUserData(workerTable);
            */
            setcurrentUserData(await dataBaseProvider.wGetRow(1));

            if (value > 0) {
              return 1;
            }
          } else if (jsonResponse[0]['ACTIVE'] == "0") {
            return 2;
          }
        }
      }
    }
  }

  List<ClientTable> listToClients(List listData) {
    List<ClientTable> listOfMap = [];
    for (int i = 0; i < listData.length; i++) {
      ClientTable returnData = ClientTable.withNoIDAll(int.parse(listData[i][0]), int.parse(listData[i][1]), int.parse(listData[i][2]), int.parse(listData[i][3]), int.parse(listData[i][4]), listData[i][5], listData[i][6], listData[i][7],
          listData[i][8], listData[i][9], listData[i][10], listData[i][11]);
      listOfMap.add(returnData);
    }
    return listOfMap;
  }

  List<AllData> listToAllData(List listData) {
    List<AllData> listOfMap = [];
    for (int i = 0; i < listData.length; i++) {
      AllData returnData = AllData.withNoID(
        int.parse(listData[i][0]),
        int.parse(listData[i][1]),
        int.parse(listData[i][2]),
        listData[i][3],
        listData[i][4],
        listData[i][5],
        listData[i][6],
        listData[i][7],
        listData[i][8],
        int.parse(listData[i][9]),
        int.parse(listData[i][10]),
        int.parse(listData[i][11]),
        listData[i][12],
        int.parse(listData[i][13]),
        int.parse(listData[i][14]),
        listData[i][15],
        int.parse(listData[i][16]),
        listData[i][17],
        int.parse(listData[i][18]),
        int.parse(listData[i][19]),
        int.parse(listData[i][20]),
        int.parse(listData[i][21]),
        int.parse(listData[i][22]),
        int.parse(listData[i][23]),
        int.parse(listData[i][24]),
        int.parse(listData[i][25]),
        int.parse(listData[i][26]),
        int.parse(listData[i][27]),
        int.parse(listData[i][28]),
        int.parse(listData[i][29]),
        int.parse(listData[i][30]),
        int.parse(listData[i][31]),
        int.parse(listData[i][32]),
        listData[i][33],
        listData[i][34],
        listData[i][35],
        listData[i][36],
        int.parse(listData[i][37]),
        listData[i][38],
        int.parse(listData[i][39])
      );
      listOfMap.add(returnData);
    }
    return listOfMap;
  }

  //Translate Arabic Numbers To English
  String translateArabicNumToEng(String num) {
    String translatedNum = "";
    for (String s in num.characters) {
      //for (int s = 0; s < num.length - 1; s++) {
      switch (s) {
        case ",": // Enter this block if mark == 0
          translatedNum = translatedNum + ",";
          break;
        case "٠": // Enter this block if mark == 0
          translatedNum = translatedNum + "0";
          break;
        case "١": // Enter this block if mark == 0
          translatedNum = translatedNum + "1";
          break;
        case "٢": // Enter this block if mark == 0
          translatedNum = translatedNum + "2";
          break;
        case "٣": // Enter this block if mark == 0
          translatedNum = translatedNum + "3";
          break;
        case "٤": // Enter this block if mark == 0
          translatedNum = translatedNum + "4";
          break;
        case "٥": // Enter this block if mark == 0
          translatedNum = translatedNum + "5";
          break;
        case "٦": // Enter this block if mark == 0
          translatedNum = translatedNum + "6";
          break;
        case "٧": // Enter this block if mark == 0
          translatedNum = translatedNum + "7";
          break;
        case "٨": // Enter this block if mark == 0
          translatedNum = translatedNum + "8";
          break;
        case "٩": // Enter this block if mark == 0
          translatedNum = translatedNum + "9";
          break;
        case "0": // Enter this block if mark == 0
          translatedNum = translatedNum + "0";
          break;
        case "1": // Enter this block if mark == 0
          translatedNum = translatedNum + "1";
          break;
        case "2": // Enter this block if mark == 0
          translatedNum = translatedNum + "2";
          break;
        case "3": // Enter this block if mark == 0
          translatedNum = translatedNum + "3";
          break;
        case "4": // Enter this block if mark == 0
          translatedNum = translatedNum + "4";
          break;
        case "5": // Enter this block if mark == 0
          translatedNum = translatedNum + "5";
          break;
        case "6": // Enter this block if mark == 0
          translatedNum = translatedNum + "6";
          break;
        case "7": // Enter this block if mark == 0
          translatedNum = translatedNum + "7";
          break;
        case "8": // Enter this block if mark == 0
          translatedNum = translatedNum + "8";
          break;
        case "9": // Enter this block if mark == 0
          translatedNum = translatedNum + "9";
          break;
      }
    }
    if (translatedNum.length == num.length) {
      return translatedNum;
    } else {
      Get.defaultDialog(barrierDismissible: true, title: "كود غير صحيح", content: Text("حاول مرة أخري...."));
      return "Wrong Data";
    }
  }

  String translateArabicNumToEngWithNoMark(String num) {
    String translatedNum = "";
    for (String s in num.characters) {
      //for (int s = 0; s < num.length - 1; s++) {
      switch (s) {
        case ",": // Enter this block if mark == 0
          break;
        case "٠": // Enter this block if mark == 0
          translatedNum = translatedNum + "0";
          break;
        case "١": // Enter this block if mark == 0
          translatedNum = translatedNum + "1";
          break;
        case "٢": // Enter this block if mark == 0
          translatedNum = translatedNum + "2";
          break;
        case "٣": // Enter this block if mark == 0
          translatedNum = translatedNum + "3";
          break;
        case "٤": // Enter this block if mark == 0
          translatedNum = translatedNum + "4";
          break;
        case "٥": // Enter this block if mark == 0
          translatedNum = translatedNum + "5";
          break;
        case "٦": // Enter this block if mark == 0
          translatedNum = translatedNum + "6";
          break;
        case "٧": // Enter this block if mark == 0
          translatedNum = translatedNum + "7";
          break;
        case "٨": // Enter this block if mark == 0
          translatedNum = translatedNum + "8";
          break;
        case "٩": // Enter this block if mark == 0
          translatedNum = translatedNum + "9";
          break;
        case "0": // Enter this block if mark == 0
          translatedNum = translatedNum + "0";
          break;
        case "1": // Enter this block if mark == 0
          translatedNum = translatedNum + "1";
          break;
        case "2": // Enter this block if mark == 0
          translatedNum = translatedNum + "2";
          break;
        case "3": // Enter this block if mark == 0
          translatedNum = translatedNum + "3";
          break;
        case "4": // Enter this block if mark == 0
          translatedNum = translatedNum + "4";
          break;
        case "5": // Enter this block if mark == 0
          translatedNum = translatedNum + "5";
          break;
        case "6": // Enter this block if mark == 0
          translatedNum = translatedNum + "6";
          break;
        case "7": // Enter this block if mark == 0
          translatedNum = translatedNum + "7";
          break;
        case "8": // Enter this block if mark == 0
          translatedNum = translatedNum + "8";
          break;
        case "9": // Enter this block if mark == 0
          translatedNum = translatedNum + "9";
          break;
      }
    }
    return translatedNum;
  }

  //Request Function
  Future<bool> requestFunction(String requestCode, String userName, String userPhone) async {
    debugPrint(requestCode);
    debugPrint(userName);
    debugPrint(userPhone);
    String mac = getplatformVersion();
    var url = websiteURL + "request.php";
    var data = {'mac': mac, 'requestCode': requestCode, 'userName': userName, 'userPhone': userPhone};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
      print('response Done...');
      print(response.body);
    } catch (err) {

      print('response Caught error: $err');
      return false;
      Get.off(LoginPage());
    }
    var message = jsonDecode(response.body);
    debugPrint(message.toString());
    if (message == "Connected...1") {
      debugPrint(message.toString());
      return false;
    }
    else if (message.toString() == mac) {
      debugPrint(message.toString());
      return false;
    }
    else if (message == "Connected...2") {
      debugPrint(message.toString());
      return false;
    }
    else if (message == "Connected...3") {
      debugPrint(message.toString());
      return false;
    }
    else {
      debugPrint(message.toString());
      return true;
    }
  }

  //Add New Contact
  Future<bool> newContactFunction(String name, String mobile, String work, String car) async {
    int id = getcurrentUserData().ID;
    int ownerID = getcurrentUserData().OwnerId;
    var url = websiteURL + "newcontact.php";
    var data = {'id': id, 'ownerID': ownerID, 'name': name, 'mobile': mobile, 'work': work, 'car': car};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));

      var message = jsonDecode(response.body);
      if (message == "Connected...") {
        Get.back();
        Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return false;
      } else {
        Get.back();
        Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        if (await updateData()) {
          return true;
        }
      }
    } catch (err) {
      print('response Caught error: $err');
      Get.back();
      Get.snackbar("خطأ بالاتصال بالخادم", "راجع الشركة...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
      //Get.off(LoginPage());
    }
  }

  //Add New Contact
  Future<List<dynamic>> newContactFunctionLocal(String name, String mobile, String work, String car, String info, String audioUrls) async {
    int inserted = await dataBaseProvider.cInsertContact(ClientTable.withNoID(0, getcurrentUserData().SQLID, getcurrentUserData().SQLID, getcurrentUserData().OwnerId, 0, name, mobile, work, car, info, audioUrls, ""));
    if (inserted > 0) {
      Get.back();
      Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      if (await updateDataLocal()) {
        return [true, inserted];
      }
    } else {
      Get.back();
      Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return [false, 0];
    }
    return [false, 0];
  }

  //Edit Contact
  Future<bool> editContactFunction(int ID, String name, String mobile, String work, String car) async {
    var url = websiteURL + "editcontact.php";
    var data = {'id': ID, 'name': name, 'mobile': mobile, 'work': work, 'car': car};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
      //print('response Done...');
      //print(response.body);
    } catch (err) {
      print('response Caught error: $err');
      Get.back();
      Get.snackbar("خطأ بالاتصال بالخادم", "راجع الشركة...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      //setcanRun(true);
      return false;
      //Get.off(LoginPage());
    }
    var message = jsonDecode(response.body);
    if (message == "Connected...") {
      //debugPrint(response.body);
      Get.back();
      Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      //setcanRun(true);
      return false;
    } else {
      if (await updateData()) {
        //Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        Get.to(UserPage());
        //setcanRun(true);
        return true;
      }
    }
  }

  //Edit Contact LOCAL
  Future<bool> editContactFunctionLocal(int ID, int active, String name, String mobile, String work, String car, String info, String audioUrls) async {
    int a = await dataBaseProvider.cUpdate(
        ClientTable.withNoID(
          getselectedContact().SQLID,
          getselectedContact().WORKERID,
          getselectedContact().gotBy,
          getselectedContact().OWNERID,
          active,
          name,
          mobile,
          work,
          car,
          info,
          audioUrls,
          getselectedContact().DATEADDED,
        ),
        "ID",
        ID);
    if (a > 0) {
      int syncInsertOperation = await dataBaseProvider.syncInsertOperation(ServerSync.withNoID(getselectedContact().SQLID, getselectedContact().OWNERID, "clients", ID, 'Update'));
      if (syncInsertOperation > 0) {
        if (await updateDataLocal()) {
          //Get.back();
          //setselectedContact(null);
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  //Check Phone Number
  Future<bool> checkMobileExistOrNot(String mobile) async {
    int id = getcurrentUserData().SQLID;
    var url = websiteURL + "checkphone.php";
    var data = {'id': id, 'mobile': mobile};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
      //print('response Done...');
      //print(response.body);
    } catch (err) {
      print('response Caught error: $err');
      Get.snackbar("خطأ بالاتصال بالخادم", "راجع الشركة...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      //Get.off(LoginPage());
    }
    var message = jsonDecode(response.body);
    //debugPrint(message);
    if (message == "Found") {
      debugPrint("Found");
      //debugPrint(response.body);
      Get.snackbar("لا يجوز ادخال عميل مرتين", "راجع قائمة العملاء..", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    } else {
      debugPrint("NOT Found");
      return true;
    }
  }

  //CheckLocal Phone Number
  Future<bool> checkMobileExistOrNotLocal(String mobile) async {
    bool foundOrNot = await dataBaseProvider.cCheckMobile(mobile);
    debugPrint("Checked the phone and we found it: " + foundOrNot.toString());
    if (foundOrNot) {
      debugPrint("Found");
      //debugPrint(response.body);
      Get.snackbar("لا يجوز ادخال عميل مرتين", "راجع قائمة العملاء..", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    } else {
      debugPrint("NOT Found");
      return true;
    }
  }

  //Clear Phone Number
  Future<bool> clearPhoneNumber() async {
    String id = AppConstants().getselectedContact().SQLID.toString();
    var url = websiteURL + "clearphone.php";
    var data = {'id': id};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
      //print('response Done...');
      //print(response.body);
    } catch (err) {
      print('response Caught error: $err');
      Get.snackbar("خطأ بالاتصال بالخادم", "راجع الشركة...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      //Get.off(LoginPage());
    }
    var message = jsonDecode(response.body);
    //debugPrint(message);
    if (message == "Not Done") {
      Get.snackbar("لا يجوز ادخال عميل مرتين", "راجع قائمة العملاء..", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> updateData() async {
    String mac = getplatformVersion();
    var url = websiteURL + "login.php";
    var data = {'mac': mac};

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));
    } catch (err) {
      print('response Caught error: $err');
    }
    var message1 = getMeDynamicIndex(response.body.toString(), 0)[0];
    setcurrentUserData(message1);

    var message2;
    message2 = getMeDynamicIndex(response.body.toString(), 1);

    if (message2 != null) {
      message2 = getMeDynamicIndex(response.body.toString(), 1)[0];
      setcurrentUserContacts(message2);
      return true;
    } else {
      setcurrentUserContacts(null);
      return true;
    }
  }

  Future<bool> updateDataLocal() async {
    List<ClientTable> clients = await dataBaseProvider.cGetAllRowsByTableName();
    if (clients != null) {
      setcurrentUserContacts(clients);
      return true;
    } else {
      return false;
    }
  }

  //Create New empty Contact Request
  Future<bool> createNewContactRequest(
    int requestNumber,
    int requestUnitValue,
    int requestType,
  ) async {
    String contactID = AppConstants().getselectedContact().SQLID.toString();
    var url = websiteURL + "newcontactrequest.php";
    var data = {
      'contactID': contactID,
      'unitType': requestUnitValue,
      'requestType': requestType,
    };

    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data));

      var message = jsonDecode(response.body);
      if (message == "1") {
        //Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return true;
      } else if (message == "0") {
        //Get.snackbar("تم ادخال العميل", "تمت الأضافة", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
        return false;
      }
    } catch (err) {
      print('response Caught error: $err');
      //Get.snackbar("خطأ بالاتصال بالخادم", "راجع الشركة...", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
      //Get.off(LoginPage());
    }
  }

  static String capitalizeAndTrim(String s, {bool allWords = false}) {
    s = s.trim();
    //var spaceLetter = utf8.encode(" ");
    String sOut = "";
    //String s1Out = "";
    int foundSpace = 0;

    for (int i = 0; i < s.length; i++) {
      if (s[i] == " ") {
        foundSpace++;
        if (foundSpace > 1) {
          continue;
        }
      } else {
        foundSpace = 0;
      }
      sOut = sOut + s[i];
    }

    if (allWords) {
      var words = sOut.split(' ');
      var capitalized = [];
      for (var w in words) {
        capitalized.add(w.capitalize);
      }
      return capitalized.join(' ');
    } else {
      return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
    }
  }

  static String getStageImage(String stageName, bool colored) {
    switch (stageName) {
      case "VG1":
        {
          return colored == true ? "assets/Villa/VG1.jpg" : "assets/Villa/VG1BW.jpg";
        }
        break;
      case "VG2":
        {
          return colored == true ? "assets/Villa/VG2.jpg" : "assets/Villa/VG2BW.jpg";
        }
        break;
      case "VG3":
        {
          return colored == true ? "assets/Villa/VG3.jpg" : "assets/Villa/VG3BW.jpg";
        }
        break;
      case "VG4":
        {
          return colored == true ? "assets/Villa/VG4.jpg" : "assets/Villa/VG4BW.jpg";
        }
        break;
      case "VG5":
        {
          return colored == true ? "assets/Villa/VG5.jpg" : "assets/Villa/VG5BW.jpg";
        }
        break;
      //Apps
      case "B1":
        {
          return colored == true ? "assets/App/B1.jpg" : "assets/Villa/B1BW.jpg";
        }
        break;
      case "B2":
        {
          return colored == true ? "assets/App/B2.jpg" : "assets/Villa/B2BW.jpg";
        }
        break;
      case "B3":
        {
          return colored == true ? "assets/App/B3.jpg" : "assets/Villa/B3BW.jpg";
        }
        break;
      case "B6":
        {
          return colored == true ? "assets/App/B6.jpg" : "assets/Villa/B6BW.jpg";
        }
        break;
      case "B7":
        {
          return colored == true ? "assets/App/B7.jpg" : "assets/Villa/B7BW.jpg";
        }
        break;
      case "B8":
        {
          return colored == true ? "assets/App/B8.jpg" : "assets/Villa/B8BW.jpg";
        }
        break;
      case "B10":
        {
          return colored == true ? "assets/App/B10.jpg" : "assets/Villa/B10BW.jpg";
        }
        break;
      case "B11":
        {
          return colored == true ? "assets/App/B11.jpg" : "assets/Villa/B11BW.jpg";
        }
        break;
      case "B12":
        {
          return colored == true ? "assets/App/B12.jpg" : "assets/Villa/B12BW.jpg";
        }
        break;
      default:
        {}
        break;
    }
  }

  //Colors
  static const Color orange = Color.fromRGBO(248, 187, 22, 1.0);
  static const Color grey = Color.fromRGBO(68, 69, 69, 1.0);
  static const Color white = Color.fromRGBO(256, 256, 256, 1.0);
  static const String websiteURL = "http://192.168.1.100/MadinatyPHP/";
  //Images
  static const String SplashImagePath = "assets/Splash/BackSplash.png";

  //First Run
  static bool firstRun = true;
  static bool showCircle = false;
  //Location
  static String location = "";
  static Offset unitLocation = Offset(1800.0, 640.0);
  static List<String> playList = [];
  static List<dynamic> newVoiceLink = [];
  static List<String> photoList = [];
  static List<dynamic> newPhotoLink = [];

  static bool onExitVar = true;
  static Timer timer;
  //Fonts
  static const String BellGothisLight = "Bell Gothic Light";
  static const String MarkaziText = "Markazi Text";

  //TabControllerIndex
  static int tabControllerIndex = 1;

  //update userpage
  static bool updateUserPage = false;

  //Client is Updating Or Not
  static bool idClientIsUpdating = false;

  //RecorderPlayer
  static bool isRecord = false;

  //Internet Section
  Map _source = {ConnectivityResult.none: false};
  Map getSource() {
    _connectivity.myStream.listen((source) {
      _source = source;
    });
    return _source;
  }

  setSource(Map value) {
    _source = value;
  }

  MyConnectivity _connectivity = MyConnectivity.instance;
  MyConnectivity get_connectivity() {
    return _connectivity;
  }

  setget_connectivity(MyConnectivity value) {
    _connectivity = value;
  }

  void init() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setSource(source);
    });
  }

  Map listenToConnectivity() {
    _connectivity.myStream.listen((source) {
      setSource(source);
    });
    return getSource();
  }

  Future<void> CheckInternet(BuildContext context, Function function) async {
    if (listenToConnectivity().keys.toList()[0] == ConnectivityResult.none) {
      //Get.isPopGestureEnable(false);
      Get.defaultDialog(
          barrierDismissible: false,
          title: "يوجد خطأ بالأتصال بشبكة الأنترنت",
          content: GFButton(
              onPressed: () {
                if (Get.isDialogOpen) {
                  Navigator.of(context).pop();
                  CheckInternet(context, function);
                }
              },
              text: "حاول مرة أخري"));
    } else {
      debugPrint("Started checking internet");
      function.call();
    }
  }

  //SYNC TO SERVER
  syncDataToServer() async {
    if (listenToConnectivity().keys.toList()[0] == ConnectivityResult.none) {
      debugPrint(listenToConnectivity().keys.toList()[0].toString());
      //Run Loop Again
      await new Future.delayed(const Duration(seconds: 10), () {
        debugPrint("No Internet");
        if (onExitVar) {
          syncDataToServer();
        }
      });
    } else {
      getSyncData();
    }
  }

  getSyncData() async {
    debugPrint("Internet found and step: 1 , Sync");
    ServerSync serverSync = await dataBaseProvider.syncGetFirstRows();
    if (getcurrentUserData() != null) {
      if (await checkServerSync() > 0) {
        debugPrint("Expecting data from server");
        List dataFromServer = await getServerSync();
        if (dataFromServer != null) {
          for (int i = 0; i < dataFromServer.length; i++) {
            if (dataFromServer[i][1] == "worker") {
              //0:Worker ID in worker Database
              //1:DataBase Name --> worker
              //2:operation --> Update
              //3:the updated row in worker database of this worker
              //4:ID of the serverSync database
              debugPrint("INCOMING WORKER DATA");
              if (int.parse(dataFromServer[i][0]) == getcurrentUserData().SQLID) {
                debugPrint("My Data Should Be Edited");
                //EDIT ADMIN
                if (int.parse(dataFromServer[i][3]['ADMIN']) != getcurrentUserData().Admin) {
                  debugPrint("ADMIN Should Be Edited");
                  int a1 = await dataBaseProvider.wUpdateLastUpdate('ADMIN', int.parse(dataFromServer[i][3]['ADMIN']));
                  if (a1 > 0) {
                    debugPrint("ADMIN updated");
                  }
                }
                //EDIT ACTIVE
                if (int.parse(dataFromServer[i][3]['ACTIVE']) != getcurrentUserData().Active) {
                  debugPrint("ACTIVE Should Be Edited");
                  int a2 = await dataBaseProvider.wUpdateLastUpdate('ACTIVE', int.parse(dataFromServer[i][3]['ACTIVE']));
                  if (a2 > 0) {
                    debugPrint("ACTIVE updated");
                  }
                }
                //EDIT Villa
                if (int.parse(dataFromServer[i][3]['VILLA']) != getcurrentUserData().VILLA) {
                  debugPrint("VILLA Should Be Edited");
                  int a6 = await dataBaseProvider.wUpdateLastUpdate('VILLA', int.parse(dataFromServer[i][3]['VILLA']));
                  if (a6 > 0) {
                    debugPrint("VILLA updated");
                  }
                }
                //EDIT APP
                if (int.parse(dataFromServer[i][3]['APP']) != getcurrentUserData().APP) {
                  debugPrint("APP Should Be Edited");
                  int a6 = await dataBaseProvider.wUpdateLastUpdate('APP', int.parse(dataFromServer[i][3]['APP']));
                  if (a6 > 0) {
                    debugPrint("APP updated");
                  }
                }
                //EDIT SHOP
                if (int.parse(dataFromServer[i][3]['SHOP']) != getcurrentUserData().SHOP) {
                  debugPrint("SHOP Should Be Edited");
                  int a6 = await dataBaseProvider.wUpdateLastUpdate('SHOP', int.parse(dataFromServer[i][3]['SHOP']));
                  if (a6 > 0) {
                    debugPrint("SHOP updated");
                  }
                }
                //update worker data
                int a3 = await dataBaseProvider.wUpdateLastUpdate('LASTUPDATEID', int.parse(dataFromServer[i][4]));
                if (a3 > 0) {
                  debugPrint("LastUpdate updated");
                  WorkerTable worktable = await dataBaseProvider.wGetRow(1);
                  if(worktable != null)
                    {
                      AppConstants().setcurrentUserData(worktable);
                    }
                }
              } else {
                //update worker data to bypass this unwanted update
                int a4 = await dataBaseProvider.wUpdateLastUpdate('LASTUPDATEID', int.parse(dataFromServer[i][4]));
                if (a4 > 0) {
                  debugPrint("LastUpdate updated");
                }
              }
            }
            if (dataFromServer[i][1] == "alldata") {
              //debugPrint("ID found will not Update 0");
              //DATAID/DataBaseName/Operation/AllData Table
              if (await dataBaseProvider.aDCheckSQLID(int.parse(dataFromServer[i][0]))) {
                int unitIsApp = int.parse(dataFromServer[i][3]['unit']);
                int sqlIDValue = int.parse(dataFromServer[i][3]['ID']);

                int stageForEdit = int.parse(dataFromServer[i][3]['stage']);
                String groupForEdit = dataFromServer[i][3]['unitGroup'];
                int unitNumberForEdit = int.parse(dataFromServer[i][3]['unitNumber']);

                String locationString = dataFromServer[i][3]['mapLoc'].toString();

                debugPrint("WE ARE HERE!!!!!");
                int c;
                for (int hh = 0; hh < 2; hh++)
                {
                  if (hh == 0) {
                    await dataBaseProvider.aDGetColumnsWhere(columnsNames: ['mapLoc'], whereCode: "sqlID = $sqlIDValue").then((value) async {
                      String currentLocationString = value[0]['mapLoc'].toString();
                      if (unitIsApp == 2 && (locationString != currentLocationString)) {
                        debugPrint("New Location: " + locationString + "Old Location: " + currentLocationString);
                        debugPrint("Locaton has been Changed");
                        await dataBaseProvider.aDGetAllValuesWhere(
                            columnsNames: ['ID', 'sqlID', 'mapLoc', 'stage', 'unitGroup', 'unitNumber'], whereCode: "unit = 2 AND stage = $stageForEdit AND unitGroup = '$groupForEdit' AND unitNumber = $unitNumberForEdit").then((value) async {
                          for (int k = 0; k < value.length; k++) {
                            String sqlIdFound = value[k].sqlID.toString();
                            debugPrint("Found unit at sqlID: " + value[k].sqlID.toString());
                            int asd = await dataBaseProvider.aDUpdateWhere('mapLoc', locationString, value[k].ID);
                            if (asd > 0) {
                              debugPrint("unit Location at SQLID: " + sqlIdFound + " updated");
                            }
                          }
                        });
                      } else {
                        debugPrint("New Location: " + locationString + "Old Location: " + currentLocationString);
                        debugPrint("Locaton is the same");
                      }

                      //update worker data
                      //debugPrint(int.parse(dataFromServer[i][0]).toString());
                      c = await dataBaseProvider.aDUpdate(
                          AllData.withNoID(
                              int.parse(dataFromServer[i][3]['ID']),
                              int.parse(dataFromServer[i][3]['ownerID']),
                              int.parse(dataFromServer[i][3]['addedByID']),
                              dataFromServer[i][3]['addedBy'],
                              dataFromServer[i][3]['date'],
                              dataFromServer[i][3]['name'],
                              dataFromServer[i][3]['phone1'],
                              dataFromServer[i][3]['phone2'],
                              dataFromServer[i][3]['work'],
                              int.parse(dataFromServer[i][3]['unit']),
                              int.parse(dataFromServer[i][3]['offerType']),
                              int.parse(dataFromServer[i][3]['stage']),
                              dataFromServer[i][3]['unitGroup'],
                              int.parse(dataFromServer[i][3]['unitStructure']),
                              int.parse(dataFromServer[i][3]['unitNumber']),
                              dataFromServer[i][3]['unitSection'],
                              int.parse(dataFromServer[i][3]['level']),
                              dataFromServer[i][3]['unitType'],
                              int.parse(dataFromServer[i][3]['unitArea']),
                              int.parse(dataFromServer[i][3]['garden']),
                              int.parse(dataFromServer[i][3]['gardenArea']),
                              int.parse(dataFromServer[i][3]['rooms']),
                              int.parse(dataFromServer[i][3]['bathRooms']),
                              int.parse(dataFromServer[i][3]['furnished']),
                              int.parse(dataFromServer[i][3]['rent']),
                              int.parse(dataFromServer[i][3]['cash']),
                              int.parse(dataFromServer[i][3]['allOver']),
                              int.parse(dataFromServer[i][3]['deposit']),
                              int.parse(dataFromServer[i][3]['paid']),
                              int.parse(dataFromServer[i][3]['overAmount']),
                              int.parse(dataFromServer[i][3]['wanted']),
                              int.parse(dataFromServer[i][3]['leftAmount']),
                              int.parse(dataFromServer[i][3]['months']),
                              dataFromServer[i][3]['info'],
                              dataFromServer[i][3]['voiceLink'],
                              dataFromServer[i][3]['photoLink'],
                              dataFromServer[i][3]['mapLoc'],
                              int.parse(dataFromServer[i][3]['lastEditedByID']),
                              dataFromServer[i][3]['lastEditedByName'],
                              int.parse(dataFromServer[i][3]['available'])
                          ),
                          "sqlID",
                          int.parse(dataFromServer[i][0]));
                    });
                  }
                  if (hh == 1){
                    if (c > 0) {
                      debugPrint("DATA IS:::::" + dataFromServer[i][4].toString());
                      int a = await dataBaseProvider.wUpdateLastUpdate('LASTUPDATEID', int.parse(dataFromServer[i][4]));
                      debugPrint("Last Update ID : " + int.parse(dataFromServer[i][4]).toString());
                      if (a > 0) {
                        debugPrint("Server Update Not Inserted, but LastUpdate updated");
                      }
                    }
                  }
                }
              } else {
                //not found Insert Data
                debugPrint("DATA TO BE INSERTED: " + dataFromServer[i][3].toString());
                int b = await dataBaseProvider.aDInsertUnit(AllData.withNoID(
                  int.parse(dataFromServer[i][3]['ID']),
                  int.parse(dataFromServer[i][3]['ownerID']),
                  int.parse(dataFromServer[i][3]['addedByID']),
                  dataFromServer[i][3]['addedBy'],
                  dataFromServer[i][3]['date'],
                  dataFromServer[i][3]['name'],
                  dataFromServer[i][3]['phone1'],
                  dataFromServer[i][3]['phone2'],
                  dataFromServer[i][3]['work'],
                  int.parse(dataFromServer[i][3]['unit']),
                  int.parse(dataFromServer[i][3]['offerType']),
                  int.parse(dataFromServer[i][3]['stage']),
                  dataFromServer[i][3]['unitGroup'],
                  int.parse(dataFromServer[i][3]['unitStructure']),
                  int.parse(dataFromServer[i][3]['unitNumber']),
                  dataFromServer[i][3]['unitSection'],
                  int.parse(dataFromServer[i][3]['level']),
                  dataFromServer[i][3]['unitType'],
                  int.parse(dataFromServer[i][3]['unitArea']),
                  int.parse(dataFromServer[i][3]['garden']),
                  int.parse(dataFromServer[i][3]['gardenArea']),
                  int.parse(dataFromServer[i][3]['rooms']),
                  int.parse(dataFromServer[i][3]['bathRooms']),
                  int.parse(dataFromServer[i][3]['furnished']),
                  int.parse(dataFromServer[i][3]['rent']),
                  int.parse(dataFromServer[i][3]['cash']),
                  int.parse(dataFromServer[i][3]['allOver']),
                  int.parse(dataFromServer[i][3]['deposit']),
                  int.parse(dataFromServer[i][3]['paid']),
                  int.parse(dataFromServer[i][3]['overAmount']),
                  int.parse(dataFromServer[i][3]['wanted']),
                  int.parse(dataFromServer[i][3]['leftAmount']),
                  int.parse(dataFromServer[i][3]['months']),
                  dataFromServer[i][3]['info'],
                  dataFromServer[i][3]['voiceLink'],
                  dataFromServer[i][3]['photoLink'],
                  dataFromServer[i][3]['mapLoc'],
                  int.parse(dataFromServer[i][3]['lastEditedByID']),
                  dataFromServer[i][3]['lastEditedByName'],
                  int.parse(dataFromServer[i][3]['available']),
                ));
                if (b > 0) {
                  debugPrint("Server Update Inserted");
                  //update worker data
                  int a = await dataBaseProvider.wUpdateLastUpdate('LASTUPDATEID', int.parse(dataFromServer[i][4]));
                  if (a > 0) {
                    debugPrint("LastUpdate updated");
                  }
                }
              }
            }
            if (i == dataFromServer.length - 1) {
              List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
              if (allDataUnits != null) {
                setAllDataFromLiteUnits(allDataUnits);
                for (int y = 0; y < 2; y++) {
                  if (y == 0) {
                    List<List> allDataVillaStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 1", debugCode: "stage", exFor: 'stage');
                    if (allDataVillaStages != null) {
                      setAllDataFromLiteVillaStages(allDataVillaStages);
                    }
                  }
                  if (y == 1) {
                    List<List> allDataAppStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 2", debugCode: "stage", exFor: 'stageApp');
                    if (allDataAppStages != null) {
                      AppConstants().setAllDataFromLiteAppStages(allDataAppStages);
                    }
                  }
                }
              }
              setcurrentUserData(await dataBaseProvider.wGetRow(1));
              updateUserPage = true;
              //Run Loop Again //each 5 mins
              await new Future.delayed(const Duration(seconds: 10), () {
                debugPrint("Hello Internet");
                if (onExitVar) {
                  Get.snackbar("تم تحديث البيانات من الخادم", "تم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange);
                  syncDataToServer();
                }
              });
            }
          }
        } else {
          //Run Loop Again //each 5 mins
          await new Future.delayed(const Duration(seconds: 10), () {
            debugPrint("Hello Internet");
            if (onExitVar) {
              syncDataToServer();
            }
          });
        }
      }
      else if (serverSync != null) {
        debugPrint("NO SERVER DATA EXPECTED, NOW updating server with SQLLite Data");
        if (await checkRealInternet() == 1) {
          if (serverSync.dataBaseName == 'clients') {
            if (serverSync.operation == 'Insert') {
              ClientTable dataToBeSent = await dataBaseProvider.cGetRow(serverSync.dataID);
              if (dataToBeSent != null) {
                List<dynamic> returnData = await clientToServerInsert(dataToBeSent);
                if (returnData != null) {
                  int updateSync1 = await dataBaseProvider.cUpdateColumn('SQLID', returnData[0].toString(), serverSync.dataID);
                  if (updateSync1 > 0) {
                    int updateSync2 = await dataBaseProvider.cUpdateColumn('DATEADDED', returnData[1].toString(), serverSync.dataID);
                    if (updateSync2 > 0) {
                      int updateSync3 = await dataBaseProvider.syncDelete('ID', serverSync.ID);
                      if (updateSync3 > 0) {
                        if (await updateDataLocal()) {
                          //widgetsListProvider = getcurrentUserContacts();
                          debugPrint("Hello Internet");
                          if (onExitVar) {
                            syncDataToServer();
                          }
                          Get.snackbar("تم تحديث بيانات العميل", "تم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                          //Run Loop Again
                          //await new Future.delayed(const Duration(seconds: 1));
                        } else {
                          Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                          //Run Loop Again
                          await new Future.delayed(const Duration(seconds: 10), () {
                            debugPrint("Hello Internet");
                            if (onExitVar) {
                              syncDataToServer();
                            }
                          });
                        }
                      } else {
                        Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                        //Run Loop Again
                        await new Future.delayed(const Duration(seconds: 10), () {
                          debugPrint("Hello Internet");
                          if (onExitVar) {
                            syncDataToServer();
                          }
                        });
                      }
                    } else {
                      Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                      //Run Loop Again
                      await new Future.delayed(const Duration(seconds: 10), () {
                        debugPrint("Hello Internet");
                        if (onExitVar) {
                          syncDataToServer();
                        }
                      });
                    }
                  } else {
                    Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                    //Run Loop Again
                    await new Future.delayed(const Duration(seconds: 10), () {
                      debugPrint("Hello Internet");
                      if (onExitVar) {
                        syncDataToServer();
                      }
                    });
                  }
                } else {
                  Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                  //Run Loop Again
                  await new Future.delayed(const Duration(seconds: 10), () {
                    debugPrint("Hello Internet");
                    if (onExitVar) {
                      syncDataToServer();
                    }
                  });
                }
              } else {
                //Run Loop Again
                await new Future.delayed(const Duration(seconds: 10), () {
                  debugPrint("Hello Internet");
                  if (onExitVar) {
                    syncDataToServer();
                  }
                });
              }
            }
            //Update
            else if (serverSync.operation == 'Update') {
              debugPrint("Update found");
              ClientTable dataToBeSent = await dataBaseProvider.cGetRow(serverSync.dataID);
              if (dataToBeSent != null) {
                final Map responses = await clientToServerUpdate(dataToBeSent);
                if (responses != null) {
                  debugPrint("returnData is : " + responses.toString());
                  debugPrint("Return DATEADDED : " + responses['DATEADDED'].toString());
                  debugPrint("Return VOICELINK : " + responses['VOICELINK'].toString());
                  List<dynamic> audioList = jsonDecode(responses['VOICELINK']);

                  int updateDate = await dataBaseProvider.cUpdateColumn('DATEADDED', responses['DATEADDED'].toString(), serverSync.dataID);
                  if (updateDate > 0) {
                    int updateDate1 = await dataBaseProvider.cUpdateColumn('VOICELINK', responses['VOICELINK'].toString(), serverSync.dataID);
                    if (updateDate1 > 0) {
                      int updateSync3 = await dataBaseProvider.syncDelete('ID', serverSync.ID);
                      if (updateSync3 > 0) {
                        if (await updateDataLocal()) {
                          //timer?.cancel();
                          //timer = null;
                          //widgetsListProvider = getcurrentUserContacts();
                          debugPrint("Hello Internet");
                          if (onExitVar) {
                            syncDataToServer();
                          }
                          //Run Loop Again
                          //await new Future.delayed(const Duration(seconds: 1));

                          Directory directory = await getApplicationSupportDirectory();
                          final checkPathExistence = await Directory(directory.path + "/FTPAudioContact/").exists();
                          if (checkPathExistence) {
                            try {
                              List audioFiles = new List();
                              audioFiles = Directory(directory.path + "/FTPAudioContact/").listSync();
                              for (int i = 0; i < audioFiles.length; i++) {
                                File f = File(audioFiles[i].toString());
                                String fileName = p.basename(f.path).toString().substring(0, p.basename(f.path).toString().length - 1);
                                debugPrint("File Name : " + fileName);
                                for (int ir = 0; ir < audioList.length; ir++) {
                                  String fileTempName = audioList[ir].toString() + ".aac";
                                  debugPrint("audioList Name : " + audioList[ir].toString() + ".aac");
                                  if (fileName == fileTempName) {
                                    await audioFiles[i].delete();
                                    break;
                                  }
                                }
                              }
                            } catch (e) {
                              debugPrint("No Folder");
                            }
                          }

                          Get.snackbar("تم تحديث بيانات العميل", "تم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                        } else {
                          Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                          //Run Loop Again
                          await new Future.delayed(const Duration(seconds: 10), () {
                            debugPrint("Hello Internet");
                            if (onExitVar) {
                              syncDataToServer();
                            }
                          });
                        }
                      } else {
                        Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                        //Run Loop Again
                        await new Future.delayed(const Duration(seconds: 10), () {
                          debugPrint("Hello Internet");
                          if (onExitVar) {
                            syncDataToServer();
                          }
                        });
                      }
                    } else {
                      Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                      //Run Loop Again
                      await new Future.delayed(const Duration(seconds: 10), () {
                        debugPrint("Hello Internet");
                        if (onExitVar) {
                          syncDataToServer();
                        }
                      });
                    }
                  } else {
                    Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                    //Run Loop Again
                    await new Future.delayed(const Duration(seconds: 10), () {
                      debugPrint("Hello Internet");
                      if (onExitVar) {
                        syncDataToServer();
                      }
                    });
                  }
                } else {
                  debugPrint("returnData is : " + responses.toString());
                  Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                  //Run Loop Again
                  await new Future.delayed(const Duration(seconds: 10), () {
                    debugPrint("Hello Internet");
                    if (onExitVar) {
                      syncDataToServer();
                    }
                  });
                }
              } else {
                Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                //Run Loop Again
                await new Future.delayed(const Duration(seconds: 10), () {
                  debugPrint("Hello Internet");
                  if (onExitVar) {
                    syncDataToServer();
                  }
                });
              }
            }
            //If not Insert or Update
            else {
              //Run Loop Again
              await new Future.delayed(const Duration(seconds: 10), () {
                debugPrint("Hello Internet");
                if (onExitVar) {
                  syncDataToServer();
                }
              });
            }
          }
          else if (serverSync.dataBaseName == 'allData') {
            if (serverSync.operation == 'Insert') {
              AllData dataToBeSent = await dataBaseProvider.aDGetRow(serverSync.dataID);
              if (dataToBeSent != null) {
                AllData returnData = await clientToServerInsertUnit(dataToBeSent);
                if (returnData != null) {
                  int updateSync1 = await dataBaseProvider.aDUpdate(returnData, "ID", serverSync.dataID);
                  if (updateSync1 > 0) {
                    int updateSync3 = await dataBaseProvider.syncDelete('ID', serverSync.ID);
                    if (updateSync3 > 0) {
                      debugPrint("DATA ID DELETED FROM SYNCSERVER");
                      debugPrint("DATA UPDATEDDDDDDDDDD");
                      debugPrint("Hello Internet");
                      if (onExitVar) {
                        syncDataToServer();
                      }
                      Get.snackbar("تم تحديث بيانات العميل", "تم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                    } else {
                      Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                      //Run Loop Again
                      await new Future.delayed(const Duration(seconds: 10), () {
                        debugPrint("Hello Internet");
                        if (onExitVar) {
                          syncDataToServer();
                        }
                      });
                    }
                  } else {
                    Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                    //Run Loop Again
                    await new Future.delayed(const Duration(seconds: 10), () {
                      debugPrint("Hello Internet");
                      if (onExitVar) {
                        syncDataToServer();
                      }
                    });
                  }
                } else {
                  Get.snackbar("لم يتم تحديث بيانات العميل", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                  //Run Loop Again
                  await new Future.delayed(const Duration(seconds: 10), () {
                    debugPrint("Hello Internet");
                    if (onExitVar) {
                      syncDataToServer();
                    }
                  });
                }
              } else {
                //Run Loop Again
                await new Future.delayed(const Duration(seconds: 10), () {
                  debugPrint("Hello Internet");
                  if (onExitVar) {
                    syncDataToServer();
                  }
                });
              }
            }
            else if (serverSync.operation == 'Update') {
              debugPrint("Update found");
              AllData dataToBeSent = await dataBaseProvider.aDGetRow(serverSync.dataID);
              if (dataToBeSent != null) {
                final Map responses = await clientToServerUpdateUnit(dataToBeSent);
                if (responses != null) {
                  debugPrint("returnData is : " + responses.toString());
                  debugPrint("Return voiceLink : " + responses['voiceLink'].toString());
                  debugPrint("Return photoLink : " + responses['photoLink'].toString());
                  List<dynamic> audioList = jsonDecode(responses['voiceLink']);
                  List<dynamic> photoList = jsonDecode(responses['photoLink']);
                  int updateDate2 = await dataBaseProvider.aDUpdateColumn('photoLink', responses['photoLink'].toString(), serverSync.dataID);
                  if (updateDate2 > 0) {
                    int updateDate1 = await dataBaseProvider.aDUpdateColumn('voiceLink', responses['voiceLink'].toString(), serverSync.dataID);
                    if (updateDate1 > 0) {
                      int updateSync3 = await dataBaseProvider.syncDelete('ID', serverSync.ID);
                      if (updateSync3 > 0) {
                        debugPrint("DATA ID DELETED FROM SYNCSERVER");
                        List<List> allDataUnits = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit"], "unit", debugCode: "unit");
                        if (allDataUnits != null) {
                          setAllDataFromLiteUnits(allDataUnits);
                          Directory directory = await getApplicationSupportDirectory();
                          for (int y = 0; y < 5; y++) {
                            if (y == 0) {
                              List<List> allDataVillaStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 1", debugCode: "stage", exFor: 'stage');
                              if (allDataVillaStages != null) {
                                setAllDataFromLiteVillaStages(allDataVillaStages);
                              }
                            }
                            if (y == 1) {
                              List<List> allDataAppStages = await dataBaseProvider.aDGetAllDistinctValuesOfColumn(["unit", "stage"], "stage", groupedBy: "stage", whereCode: "unit = 2", debugCode: "stage", exFor: 'stageApp');
                              if (allDataAppStages != null) {
                                AppConstants().setAllDataFromLiteAppStages(allDataAppStages);
                              }
                            }
                            if (y == 2) {
                              //IMAGE FILES
                              final checkPathExistencePhoto = await Directory(directory.path + "/FTPPhotoUnit/").exists();
                              if (checkPathExistencePhoto) {
                                try {
                                  List imageFiles = new List();
                                  imageFiles = Directory(directory.path + "/FTPPhotoUnit/").listSync();
                                  for (int ip = 0; ip < imageFiles.length; ip++) {
                                    File fPhoto = File(imageFiles[ip].toString());
                                    String fileNamePhoto = FileUtils.basename(fPhoto.path).substring(0, FileUtils.basename(fPhoto.path).length - 1);
                                    debugPrint("File Name : " + fileNamePhoto);
                                    for (int ir1 = 0; ir1 < photoList.length; ir1++) {
                                      String fileTempName = photoList[ir1].toString();
                                      debugPrint("photoList Name : " + photoList[ir1].toString());
                                      if (fileNamePhoto == fileTempName) {
                                        await imageFiles[ip].delete();
                                        break;
                                      }
                                    }
                                  }
                                } catch (e) {
                                  debugPrint("No Folder");
                                }
                              }
                            }
                            if (y == 3) {
                              //AUDIO FILES
                              final checkPathExistence = await Directory(directory.path + "/FTPAudioUnit/").exists();
                              if (checkPathExistence) {
                                try {
                                  List audioFiles = new List();
                                  audioFiles = Directory(directory.path + "/FTPAudioUnit/").listSync();
                                  for (int i = 0; i < audioFiles.length; i++) {
                                    File f = File(audioFiles[i].toString());
                                    String fileName = p.basename(f.path).toString().substring(0, p.basename(f.path).toString().length - 1);
                                    debugPrint("File Name : " + fileName);
                                    for (int ir = 0; ir < audioList.length; ir++) {
                                      String fileTempName = audioList[ir].toString() + ".aac";
                                      debugPrint("audioList Name : " + audioList[ir].toString() + ".aac");
                                      if (fileName == fileTempName) {
                                        await audioFiles[i].delete();
                                        break;
                                      }
                                    }
                                  }
                                } catch (e) {
                                  debugPrint("No Folder");
                                }
                              }
                            }
                            if (y == 4) {
                              if (onExitVar) {
                                debugPrint("LAUNCH SHOULD BE NOWWWWWWWWWW");
                                debugPrint("Hello Internet");
                                syncDataToServer();
                                Get.snackbar("تم تحديث بيانات الوحدة", "تم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                              }
                            }
                          }
                        } else {
                          Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                          //Run Loop Again
                          await new Future.delayed(const Duration(seconds: 10), () {
                            debugPrint("Hello Internet");
                            if (onExitVar) {
                              syncDataToServer();
                            }
                          });
                        }
                      } else {
                        Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                        //Run Loop Again
                        await new Future.delayed(const Duration(seconds: 10), () {
                          debugPrint("Hello Internet");
                          if (onExitVar) {
                            syncDataToServer();
                          }
                        });
                      }
                    } else {
                      Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                      //Run Loop Again
                      await new Future.delayed(const Duration(seconds: 10), () {
                        debugPrint("Hello Internet");
                        if (onExitVar) {
                          syncDataToServer();
                        }
                      });
                    }
                  } else {
                    Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                    //Run Loop Again
                    await new Future.delayed(const Duration(seconds: 10), () {
                      debugPrint("Hello Internet");
                      if (onExitVar) {
                        syncDataToServer();
                      }
                    });
                  }
                } else {
                  debugPrint("returnData is : " + responses.toString());
                  Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                  //Run Loop Again
                  await new Future.delayed(const Duration(seconds: 10), () {
                    debugPrint("Hello Internet");
                    if (onExitVar) {
                      syncDataToServer();
                    }
                  });
                }
              } else {
                Get.snackbar("لم يتم تحديث بيانات الوحدة", "لم يتم تحديث البيانات", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                //Run Loop Again
                await new Future.delayed(const Duration(seconds: 10), () {
                  debugPrint("Hello Internet");
                  if (onExitVar) {
                    syncDataToServer();
                  }
                });
              }
            } else {
              //Run Loop Again
              await new Future.delayed(const Duration(seconds: 10), () {
                debugPrint("Hello Internet");
                if (onExitVar) {
                  syncDataToServer();
                }
              });
            }
          }
          else {
            //Run Loop Again
            await new Future.delayed(const Duration(seconds: 10), () {
              debugPrint("Hello Internet");
              if (onExitVar) {
                syncDataToServer();
              }
            });
          }
        } else {
          //Run Loop Again //each 5 mins
          await new Future.delayed(const Duration(seconds: 10), () {
            debugPrint("Hello Internet");
            if (onExitVar) {
              syncDataToServer();
            }
          });
        }
      } else {
        //Run Loop Again //each 5 mins
        await new Future.delayed(const Duration(seconds: 10), () {
          debugPrint("Hello Internet");
          if (onExitVar) {
            syncDataToServer();
          }
        });
      }
    } else {
      //Run Loop Again //each 5 mins
      await new Future.delayed(const Duration(seconds: 10), () {
        debugPrint("Hello Internet");
        if (onExitVar) {
          syncDataToServer();
        }
      });
    }
  }

  Future<int> checkServerSync() async {
    var url = websiteURL + "checkServerSync.php";
    debugPrint("Last updated ID in SQLITE data: " + getcurrentUserData().LASTUPDATEID.toString());
    final Map<String, int> dataID = {"ID": getcurrentUserData().LASTUPDATEID, "OWNERID": getcurrentUserData().OwnerId};
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(dataID)).timeout(Duration(seconds: 5), onTimeout: () {
        return null;
      });
    } catch (err) {
      print('response Caught error: $err');
      return -1;
      Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    if (response != null) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if(jsonResponse.toString() == "0")
          {
            debugPrint("NO ServerSync Data Found, return value is: " + jsonResponse.toString());
          }
        else
          {
            debugPrint("ServerSync Data Found, return value is: " + jsonResponse.toString());
          }

        if (int.parse(jsonResponse.toString()) > 0) {
          return 1;
        } else {
          return 0;
        }
      } else {
        return -1;
      }
    } else {
      return -1;
    }
  }

  Future<List> getServerSync() async {
    var url = websiteURL + "GetServerSync.php";
    debugPrint("getServerSync function: Last updated ID from SQLLite: " + getcurrentUserData().LASTUPDATEID.toString());
    final Map<String, dynamic> dataID = {"LASTUPDATEID": getcurrentUserData().LASTUPDATEID, "OWNERID": getcurrentUserData().OwnerId, "WorkerID": getcurrentUserData().SQLID};
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(dataID)).timeout(Duration(seconds: 10), onTimeout: () {
        return null;
      });
    } catch (err) {
      print('response Caught error: $err');
      return null;
      Get.snackbar("لم يتم ادخال العميل", "حاول مرة أخري....", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
    if (response != null) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        //DATAID/DataBaseName/Operation/AllData Table
        print("getServerSync return Data: " + jsonResponse.toString());

        if (jsonResponse.length > 0) {
          return jsonResponse;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> clientToServerUpdateUnit(AllData allData) async {
    Directory directory = await getApplicationSupportDirectory();
    var request = new MultipartRequest("POST", Uri.parse(websiteURL + "ClientToServerEditUploadUnit.php"));

    allData.toMap().forEach((key, value) {
      request.fields[key] = value.toString();
    });

    for (int J = 0; J < 4; J++) {
      if (J == 0) {
        request.fields['WorkerID'] = getcurrentUserData().SQLID.toString();
        request.fields['WorkerNAME'] = getcurrentUserData().Name;
      } else if (J == 1) {
        //Audio Files
        if (allData.voiceLink.toString() != "[]") {
          List<String> voiceLinks = allData.voiceLink.split(",");
          voiceLinks[0] = voiceLinks[0].substring(1);
          voiceLinks[voiceLinks.length - 1] = voiceLinks[voiceLinks.length - 1].substring(0, voiceLinks[voiceLinks.length - 1].length - 1);
          for (int u1 = 0; u1 < voiceLinks.length; u1++) {
            voiceLinks[u1] = voiceLinks[u1].trim();
          }
          int counter = 0;
          for (int k = 0; k < voiceLinks.length; k++) {
            File g = File(directory.path + "/FTPAudioUnit/" + voiceLinks[k] + ".aac");
            if (await g.exists()) {
              debugPrint(voiceLinks[k].toString() + " Counter is: " + counter.toString());
              request.files.add(await http.MultipartFile.fromPath('Audio' + counter.toString(), directory.path + "/FTPAudioUnit/" + voiceLinks[k] + ".aac"));
              counter++;
            }
          }
        }
      } else if (J == 2) {
        //Image Files
        if (allData.photoLink.toString() != "[]") {
          List<String> photoLinks = allData.photoLink.split(",");
          photoLinks[0] = photoLinks[0].substring(1);
          photoLinks[photoLinks.length - 1] = photoLinks[photoLinks.length - 1].substring(0, photoLinks[photoLinks.length - 1].length - 1);
          for (int u1 = 0; u1 < photoLinks.length; u1++) {
            photoLinks[u1] = photoLinks[u1].trim();
          }
          int counter = 0;
          for (int k = 0; k < photoLinks.length; k++) {
            File g = File(directory.path + "/FTPPhotoUnit/" + photoLinks[k]);
            if (await g.exists()) {
              debugPrint(photoLinks[k].toString() + " Counter is: " + counter.toString());
              request.files.add(await http.MultipartFile.fromPath('Image' + counter.toString(), directory.path + "/FTPPhotoUnit/" + photoLinks[k]));
              counter++;
            }
          }
        }
      } else if (J == 3) {
        final StreamedResponse responses = await request.send().timeout(Duration(seconds: 180), onTimeout: () {
          return null;
        });
        final Map<String, dynamic> returnData = {"voiceLink": "", "photoLink": ""};

        if (responses.statusCode == 200) {
          var responseString = await responses.stream.bytesToString();
          if (responseString.toString() != "UPDATED2" || responseString.toString() != "UPDATED3") {
            print("Return Value" + responseString.toString());
            print("jsonDecode Value2 " + jsonDecode(responseString)["voiceLink"].toString());
            returnData["voiceLink"] = jsonDecode(responseString)["voiceLink"].toString();

            print("jsonDecode Value2 " + jsonDecode(responseString)["photoLink"].toString());
            returnData["photoLink"] = jsonDecode(responseString)["photoLink"].toString();

            return returnData;
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    }
  }

  Future<AllData> clientToServerInsertUnit(AllData allData) async {
    var url = websiteURL + "ClientToServerInsertUnit.php";
    var data = allData.toMap();
    debugPrint("Data before send: " + data.toString());
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data)).timeout(Duration(seconds: 60), onTimeout: () {
        return null;
      });
      debugPrint(response.body.toString());
      var message = jsonDecode(response.body);
      debugPrint(message.toString());
      if (message.toString() != "[]" && message.toString() != "[]1" && message.toString() != "[]2") {
        AllData functionReturnData = AllData.withNoID(
          int.parse(message["ID"].toString()),
          int.parse(message["ownerID"].toString()),
          int.parse(message["addedByID"].toString()),
          message["addedBy"].toString(),
          message["date"].toString(),
          message["name"].toString(),
          message["phone1"].toString(),
          message["phone2"].toString(),
          message["work"].toString(),
          int.parse(message["unit"].toString()),
          int.parse(message["offerType"].toString()),
          int.parse(message["stage"].toString()),
          message["unitGroup"].toString(),
          int.parse(message["unitStructure"].toString()),
          int.parse(message["unitNumber"].toString()),
          message["unitSection"].toString(),
          int.parse(message["level"].toString()),
          message["unitType"].toString(),
          int.parse(message["unitArea"].toString()),
          int.parse(message["garden"].toString()),
          int.parse(message["gardenArea"].toString()),
          int.parse(message["rooms"].toString()),
          int.parse(message["bathRooms"].toString()),
          int.parse(message["furnished"].toString()),
          int.parse(message["rent"].toString()),
          int.parse(message["cash"].toString()),
          int.parse(message["allOver"].toString()),
          int.parse(message["deposit"].toString()),
          int.parse(message["paid"].toString()),
          int.parse(message["overAmount"].toString()),
          int.parse(message["wanted"].toString()),
          int.parse(message["leftAmount"].toString()),
          int.parse(message["months"].toString()),
          message["info"].toString(),
          message["voiceLink"].toString(),
          message["photoLink"].toString(),
          message["mapLoc"].toString(),
          int.parse(message["lastEditedByID"].toString()),
          message["lastEditedByName"].toString(),
          int.parse(message["available"].toString()),
        );
        debugPrint("Message Data: " + message.toString());
        return functionReturnData;
      } else {
        return null;
      }
    } catch (err) {
      print('response Caught error: $err');
      debugPrint("ERROR IN SERVER STUFF");
      return null;
    }
  }

  Future<Map<String, dynamic>> clientToServerUpdate(ClientTable clientTable) async {
    Directory directory = await getApplicationSupportDirectory();
    var request = new MultipartRequest("POST", Uri.parse(websiteURL + "ClientToServerEditUpload.php"));
    clientTable.toMap().forEach((key, value) {
      request.fields[key] = value.toString();
    });

    for (int K = 0; K < 2; K++) {
      if (K == 0) {
        if (clientTable.VOICELINK.toString() != "[]") {
          List<String> voiceLinks = clientTable.VOICELINK.split(",");
          voiceLinks[0] = voiceLinks[0].substring(1);
          voiceLinks[voiceLinks.length - 1] = voiceLinks[voiceLinks.length - 1].substring(0, voiceLinks[voiceLinks.length - 1].length - 1);
          for (int u1 = 0; u1 < voiceLinks.length; u1++) {
            voiceLinks[u1] = voiceLinks[u1].trim();
          }
          int counter = 0;
          for (int k = 0; k < voiceLinks.length; k++) {
            File g = File(directory.path + "/FTPAudioContact/" + voiceLinks[k] + ".aac");
            if (await g.exists()) {
              debugPrint(voiceLinks[k].toString() + " Counter is: " + counter.toString());
              request.files.add(await http.MultipartFile.fromPath('Audio' + counter.toString(), directory.path + "/FTPAudioContact/" + voiceLinks[k] + ".aac"));
              counter++;
            }
          }
        }
      } else if (K == 1) {
        final StreamedResponse responses = await request.send().timeout(Duration(seconds: 120), onTimeout: () {
          return null;
        });
        final Map<String, dynamic> returnData = {"DATEADDED": "", "VOICELINK": ""};

        if (responses.statusCode == 200) {
          var responseString = await responses.stream.bytesToString();
          if (responseString.toString() != "UPDATED2" || responseString.toString() != "UPDATED3") {
            print("Return Value" + responseString.toString());
            print("jsonDecode Value1 " + jsonDecode(responseString)["DATEADDED"].toString());
            print("jsonDecode Value2 " + jsonDecode(responseString)["VOICELINK"].toString());
            returnData["DATEADDED"] = jsonDecode(responseString)["DATEADDED"].toString();
            returnData["VOICELINK"] = jsonDecode(responseString)["VOICELINK"].toString();
            return returnData;
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    }
  }

  Future<List<dynamic>> clientToServerInsert(ClientTable clientTable) async {
    var url = websiteURL + "ClientToServerInsert.php";
    var data = clientTable.toMap();
    http.Response response;
    try {
      response = await http.post(url, body: json.encode(data)).timeout(Duration(seconds: 60), onTimeout: () {
        return null;
      });
      var message = jsonDecode(response.body);
      debugPrint(message.toString());
      if (message.toString() != "[]") {
        debugPrint("Message length: " + message.length.toString());
        return message;
      } else {
        return null;
      }
    } catch (err) {
      print('response Caught error: $err');
      debugPrint("ERROR IN SERVER STUFF");
      return null;
    }
  }
}
