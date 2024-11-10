import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/MadinatyStages.dart';
import 'package:sizer/sizer.dart';
import 'UserPage.dart';

class OthersPage extends StatefulWidget {
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  int unit = 0;
  List<dynamic> stage = ['', 0];
  String unitType = "";

  //from to
  String areaFrom = "100";
  String areaTo = "111";
  String areaValues = "";

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
          body: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
            //Villa or App
            SizedBox(height: 5.0.h),
            //Choose Villa or App
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
            //unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),
            //Stage
            unit > 0
                ? Row(mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              unit == 1
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
              )
            ])
                : SizedBox.shrink(),
            //unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),

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
            //unit > 0 ? SizedBox(height: MediaQuery.of(context).size.height * .02) : SizedBox.shrink(),


          ]),
        ));
  }

  //Return Villa Stage Unit Type
  DropdownButton returnVillaStage() {
    setState(() {
      if (unit == 1 && stage[0] == "") {
        stage = ["VG1", 1];
        areaFrom = "601";
      } else if (unit == 1 && stage[0][0] != "V") {
        stage = ["VG1", 1];
        areaFrom = "601";
      }
    });
    returnAreaValue();
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
              break;
            case "VG2":
              stage[1] = 2;
              break;
            case "VG3":
              stage[1] = 3;
              break;
            case "VG4":
              stage[1] = 4;
              break;
            case "VG5":
              stage[1] = 5;
              break;
            default:
              break;
          }
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
  DropdownButton returnVillaUnitType() {
    List<String> unitVillaType = [];
    bool found = false;
    if (stage[1] == 1) {
      unitVillaType = ["T", "U", "V", "W", "X","Y", "Z"];
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "T";
      }
    }
    else if (stage[1] == 2) {
      unitVillaType = ["A", "B", "C", "D", "E", "F", "G","H"];
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "A";
      }
    }
    else if (stage[1] == 3) {
      unitVillaType = ["A3", "B3", "C3", "D3", "E3", "F3"];
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "A3";
      }
    }
    else if (stage[1] == 4) {
      unitVillaType = ["J" ,"K" ,"L" ,"M" ,"N" ,"O"];
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "J";
      }
    }
    else if (stage[1] == 5) {
      unitVillaType = ["I^", "I", "II^", "II", "J^", "J", "K^", "K", "L^", "L", "M^", "M"];
      for (int i = 0; i < unitVillaType.length; i++) {
        if (unitType == unitVillaType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "I^";
      }
    }
    //returnAreaValueVilla();
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
        areaFrom = "437";
      }
      else if(unitType == "M^")
      {
        areaFrom = "447";
      }
      if(mounted) {
        setState(() {
          areaValues = "مساحة " + areaFrom;
        });
      }
    });
  }

  //Return APP Stage Unit Type
  DropdownButton returnAppStage() {
    setState(() {
      if (unit == 2 && stage[0] == "") {
        stage = ["B1", 1];
      } else if (unit == 2 && stage[0][0] != "B") {
        stage = ["B1", 1];
      }
    });
    returnAreaValue();
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
              break;
            case "B2":
              stage[1] = 2;
              break;
            case "B3":
              stage[1] = 3;
              break;
            case "B6":
              stage[1] = 6;
              break;
            case "B7":
              stage[1] = 7;
              break;
            case "B8":
              stage[1] = 8;
              break;
            case "B10":
              stage[1] = 10;
              break;
            case "B11":
              stage[1] = 11;
              break;
            case "B12":
              stage[1] = 12;
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
  DropdownButton returnAppUnitType() {
    List<String> unitAppType = [];
    bool found = false;
    if (stage[1] == 1) {
      unitAppType = ["100", "200", "300", "400", "500", "600", "700"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "100";
      }
    }
    else if (stage[1] == 2) {
      unitAppType = ["100", "200", "300", "400", "500", "600", "700"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "100";
      }
    }
    else if (stage[1] == 3) {
      unitAppType = ["100", "200", "300", "400", "500", "600", "700"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "100";
      }
    }
    else if (stage[1] == 6) {
      unitAppType = ["11", "10", "20", "22", "30", "33", "40"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "11";
      }
    }
    else if (stage[1] == 7) {
      unitAppType = ["50", "60", "70"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "50";
      }
    }
    else if (stage[1] == 8) {
      unitAppType = ["105", "305", "310", "320", "340", "350", "351", "405", "450", "550", "650", "660", "750", "850"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "105";
      }
    }
    else if (stage[1] == 10) {
      unitAppType = ["01", "04", "06", "07", "08"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "01";
      }
    }
    else if (stage[1] == 11) {
      unitAppType = ["60", "70", "80", "90", "02", "05", "07", "08"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "60";
      }
    }
    else if (stage[1] == 12) {
      unitAppType = ["01", "04", "06", "07", "08"];
      for (int i = 0; i < unitAppType.length; i++) {
        if (unitType == unitAppType[i]) {
          found = true;
        }
      }
      if (found == false) {
        unitType = "01";
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
          returnAreaValue();
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
  returnAreaValue() {
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
  }
}

/*
                if (await AppConstants().checkRealInternet() == 1) {
                  debugPrint("There is Internet");
                }
                else {
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
                }*/
