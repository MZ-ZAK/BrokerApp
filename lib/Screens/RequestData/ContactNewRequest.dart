import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ContactNewRequest {
  int BudgetLow;
  int BudgetHigh;

  Map<String, int> RequestType = {"Buy": 0, "Rent": 1};

  Map<String, int> UnitType = {"Villa": 0, "Apartment": 1};

  Map<String, int> Furnished = {"No": 0, "Yes": 1};

  Map<String, int> Instalments = {"No": 0, "Yes": 1};

  //39 Villa Model Type
  //For Villa
  List<String> VillaStage = ["VG1", "VG2", "VG3", "VG4", "VG5"];
  //VG1
  // Single = 1 , Twin = 2 , Quad = 4
  //Classic = 0  , Modern = 1
  //[TypeName,Stage,Villa Group,Area,Single,Classic]
  //Letter : [0,1,2[],3,4,5]
  //1-7
  Map<String, List> VG1VillaModels = {
    "Y": ["Y","VG1",["V1","V3","V8","V9"],289,2,0], //Orange Twin
    "X": ["X","VG1",["V1","V2","V3","V4","V5","V6","V7","V8","V9"],317,1,0],  //Red Single
    "W": ["W","VG1",["V2","V3","V4","V5","V7","V8","V9"],347,1, 0], //Light Pink  Single
    "Z": ["Z","VG1",["V1","V8","V9"],355,2,0],  //Dark Pink Twin
    "V": ["V","VG1",["V4","V5","V6","V7","V8"],390,1,0],   //Blue Single
    "U": ["U","VG1",["V3","V4","V5","V6","V7","V8","V9"],441,1,0],  //Brown Single
    "T": ["T","VG1",["V3","V7","V9"],601,1,0] //Purple Single not X shaped
  };

  //VG2
  List<String> VG2Groups = ["V10", "V11", "V12", "V13"];
  // Single = 1 , Twin = 2 , Quad = 4
  //Classic = 0  , Modern = 1
  //[TypeName,Stage,Villa Group,Area,Single,Classic]
  //Letter : [0,1,2[],3,4,5]
  //8-15
  Map<String, List> VG2Models = {
    "H": ["H","VG2",["V10","V11","V12","V13"],275,2,0],  //Yellow Twin
    "G": ["G","VG2",["V10","V11","V12","V13"],333,1,0],  //Red Single
    "F": ["F","VG2",["V10","V11","V12","V13"],360,1,0],  //Pale pink
    "E": ["E","VG2",["V10","V11","V12","V13"],405,1,0],  //Blue Single
    "D": ["D","VG2",["V10","V11","V12","V13"],478,1,0],  //Brown Single
    "C": ["C","VG2",["V10","V11","V12","V13"],555,1,0],  //Orange Single
    "B": ["B","VG2",["V10","V11","V12","V13"],629,1,0],  //Purple Single
    "A": ["A","VG2",["V10","V11","V12","V13"],660,1,0]   //Nile Blue Single
  };

  //VG3
  List<String> VG3Groups = ["V23","24"];
  // Single = 1 , Twin = 2 , Quad = 4
  //Classic = 0  , Modern = 1
  //[TypeName,Stage,Villa Group,Area,Single,Classic]
  //Letter : [0,1,2[],3,4,5]
  //16-21
  Map<String, List> VG3Models = {
    "F3": ["F3","VG3",["V23","24"],201,4,0],  //Pale pink Single
    "E3": ["E3","VG3",["V23","24"],253,2,0],  //Blue Single
    "D3": ["D3","VG3",["V23","24"],276,1,0],  //Brown Single
    "C3": ["C3","VG3",["V23","24"],304,1,0],  //Orange Single
    "B3": ["B3","VG3",["V23","24"],374,1,0],  //Purple Single
    "A3": ["A3","VG3",["V23","24"],404,1,0]   //Orange Single
  };

  //VG4
  List<String> VG4Groups = ["V14", "V15", "V16", "V17"];
  // Single = 1 , Twin = 2 , Quad = 4
  //Classic = 0  , Modern = 1
  //[TypeName,Stage,Villa Group,Area,Single,Classic]
  //Letter : [0,1,2[],3,4,5]
  //22-27
  Map<String, List> VG4Models = {
    "J": ["J","VG4",["V14","V15","V16","V17"],259,2,0],  //White Twin
    "K": ["K","VG4",["V14","V15","V16","V17"],312,1,0],  //Blue Single
    "L": ["L","VG4",["V14","V15","V16","V17"],388,1,0],  //Brown Single
    "M": ["M","VG4",["V14","V15"],437,1,0],  //Purple Single
    "N": ["N","VG4",["V14","V15"],493,1,0],  //Yellow Single
    "O": ["O","VG4",["V14","V15" ],557,1,0]   //Red  Single
  };

  //VG5
  // Single = 1 , Twin = 2 , Quad = 4
  //Classic = 0  , Modern = 1
  //[TypeName,Stage,Villa Group,Area,Single,Classic]
  //Letter : [0,1,2[],3,4,5]
  //28-39
  List<String> VG5Groups = ["V18", "V19", "V20", "V21", "V22"];
  Map<String, List> VG5Models = {
    "II" : ["II" ,"VG5",["V18","V22"],180,4,0],  //Deep Blue Quad
    "II^": ["II^","VG5",["V19","V20","V21"],191,4,1],      //Deep Blue Quad
    "I"  : ["I"  ,"VG5",["V18","V22"],222,4,0],      //dark Brown Quad
    "I^" : ["I^" ,"VG5",["V19","V20","V21"],231,4,1],   //dark Brown Quad
    "J"  : ["J"  ,"VG5",["V18","V22"],259,2,0],      //white Twin
    "J^" : ["J^" ,"VG5",["V19","V20","V21"],267,2,1],   //White Twin
    "K"  : ["K"  ,"VG5",["V22"],312,1,0],      //Light Blue Signle
    "K^" : ["K^" ,"VG5",["V19","V20","V21"],316,1,1],   //Light Blue Signle
    "L"  : ["L"  ,"VG5",["V18"],388,1,0],      //Yellow Single
    "L^" : ["L^" ,"VG5",["V19","V20","V21"],397,1,1],   //Yellow Single
    "M"  : ["M"  ,"VG5",["V22"],388,1,0],    //Purple Single
    "M^" : ["M^ ","VG5",["V19","V20","V21"],397,1,1],  //Purple Single
  };

  Map<String, List> Request = {
    "UnitType" :[0], //1 villa 2 app
    "RequestType" : [0],  //1 buy   2 rent
    "Furnish" : [0,0,0],  //1 company   2 private   3 no
    "UnitStructure" : [0,0,0],  //  1 single  2 twin  4 quad
    "UnitStyle" : [0,0],  // 1 classic    2 modern
    "UnitStage" : [0,0,0,0,0],  // VG1 ---- VG5
    "UnitGroup" : [[0,0,0,0,0,0,0,0,0],[0,0,0,0],[0,0], //1 -24
      [0,0,0,0],[0,0,0,0,0]],
    "Unit" : ["UnitName"] //A----Z
  };
  //B1  11-18
  //B2  22-26
}

/*
requestValue  "نوع الطلب",
(i * 2) + 1   Rent    (i * 2) + 2   Buy

requestValue[i] == (i * 2) + 2    Buy
requestFurnishedValue  == (i * 2) + 2   Yes Furnished
requestBuyTypeValue   (i * 2) + 1   Villa Type single twin quad
requestVillaTypeValue requestVillaModern requestVillaClassic
requestVillaStageVG1 requestVillaStageVG2 ......


*/
/*
enum VillaStages {
  VG1,
  VG2,
  VG4,
  VG5
}
extension VillaStagesExtension on VillaStages {

  String get Stage {
    switch (this) {
      case VillaStages.VG1:
        return 'VG1';
      case VillaStages.VG2:
        return 'VG2';
      case VillaStages.VG4:
        return 'VG4';
      case VillaStages.VG5:
        return 'VG5';
      default:
        return null;
    }
  }
}

enum VG1Groups {
  VG1Group1,
  VG1Group2,
  VG1Group3,
  VG1Group4,
  VG1Group5,
  VG1Group6,
  VG1Group7,
  VG1Group8,
  VG1Group9,
}
extension VG1GroupsExtension on VG1Groups {
  int get group {
    switch (this) {
      case VG1Groups.VG1Group1:
        return 1;
      case VG1Groups.VG1Group2:
        return 2;
      case VG1Groups.VG1Group3:
        return 3;
      case VG1Groups.VG1Group4:
        return 4;
      case VG1Groups.VG1Group5:
        return 5;
      case VG1Groups.VG1Group6:
        return 6;
      case VG1Groups.VG1Group7:
        return 7;
      case VG1Groups.VG1Group8:
        return 8;
      case VG1Groups.VG1Group9:
        return 9;
      default:
        return null;
    }
  }
}
*/
