class MadinatyStages{
  //villa Stages
  static const List<dynamic> VG1 = ['VG1',1];
  static const List<dynamic> VG2 = ['VG2',2];
  static const List<dynamic> VG3 = ['VG3',3];
  static const List<dynamic> VG4 = ['VG4',4];
  static const List<dynamic> VG5 = ['VG5',5];

  //App Stages
  static const List<dynamic> B1 = ['B1',1];
  static const List<dynamic> B2 = ['B2',2];
  static const List<dynamic> B3 = ['B3',3];
  static const List<dynamic> B6 = ['B6',6];
  static const List<dynamic> B7 = ['B7',7];
  static const List<dynamic> B8 = ['B8',8];
  static const List<dynamic> B10 = ['B10',10];
  static const List<dynamic> B11 = ['B11',11];
  static const List<dynamic> B12 = ['B12',12];

  //App Levels
  static const List<dynamic> Ground = ['أرضي',0];
  static const List<dynamic> First = ['أول',1];
  static const List<dynamic> Second = ['ثاني',2];
  static const List<dynamic> Third = ['ثالث',3];
  static const List<dynamic> Fourth = ['رابع',4];
  static const List<dynamic> Fifth = ['خامس',5];
  static const List<dynamic> Six = ['سادس',6];

  //B1
  // 100 purple 100 111
  // 200 brown 123 141
  // 300 yellow 157 183
  // 400 pink 177 211
  // 500 orange 186 239
  // 600 offblue 237 266
  // 700 blue 298 324

  static const List<List<int>> b1Groups = [
    [100,200,300,400,500],
    [100,200,300,400],
    [100,200,300,400],
    [100,200,300,400,500,600,700],
    //5
    [300,400,500,600],
    [300,400,500,700],
    [100,200,300,400],
    [100,200,300,400,500]];
  static const List<List<int>> b2Groups = [
    [400,500,600,700],
    [100,300,400],
    [100,200,300,400,600],
    [200,300,400],
    [400],
    [100,400]];
  static const List<List<int>> b3Groups = [
    [100,200,300,400,600,700],
    [100,200,300,400,500,600,700],
    [100,200,300,400,500,600],
    [100,200,300,400]];
  static const List<List<dynamic>> b123UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["100",4,6,[100,111]],
    ["200",4,6,[123,141]],
    ["300",2,6,[157,183]],
    ["400",2,6,[177,211]],
    ["500",2,6,[186,239]],
    ["600",2,6,[237,266]],
    ["700",2,6,[298,324]],
    ];

  // 61 65 66  6 levels,
  static const List<List<int>> b6Groups = [
    //61
    [10,20],
    //62
    [30,33,40],
    //63
    [30,40],
    //64
    [30,40],
    //65
    [11,22],
    //66
    [10,20],
    //67
    [30],
    //68
    [30,40],
    //69
    [30,40],
    //70
    [30,40]];
  static const List<List<dynamic>> b6UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["10",2,6,[78,146]],
    ["20",2,6,[106,142]],

    ["11",2,6,[78,146]],
    ["22",2,6,[106,142]],

    ["30",4,5,[58,104]],
    ["33",4,5,[86,174]],

    ["40",3,5,[88,131]],
  ];

  //50 42-69
  //60 46-82
  //70 64-96
  //All
  static const List<List<int>> b7Groups = [
    [50,60,70],
    [50,60,70],
    [60,70],
    [50,60,70]];
  static const List<List<dynamic>> b7UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["50",4,5,[42,69]],
    ["60",4,5,[46,82]],
    ["70",4,5,[64,96]]
  ];

  //81 105 4 305 2 405 2
  //82 305 2 405 2
  //83 310 3 142-337  320 4 143-151
  //84 340 2 351 2 350 2
  //85 750 2 199-245  850 2 200-245
  //86 650 4 270-290  660 3 272-344
  //87 310 3 142-337  320 4 143-151
  //88 650 4 270-290  660 3 272-344
  //89 450 4 550 4
 
  static const List<List<int>> b8Groups = [
    //1
    [105,305,405],
    //2
    [305,405],
    //3
    [310,320],
    //4
    [340,350,351],
    //5
    [750,850],
    //6
    [650,660],
    //7
    [310,320],
    //8
    [650,660],
    //9
    [450,550]];
  static const List<List<dynamic>> b8UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["105",4,5,["-","-"]],
    ["305",2,5,["-","-"]],
    ["310",3,5,[142,444]],
    ["320",4,5,[82,151]],
    ["340",2,5,["-","-"]],
    ["350",2,5,["-","-"]],
    ["351",2,5,["-","-"]],
    ["405",2,5,["-","-"]],
    ["450",4,5,["-","-"]],
    ["550",4,5,["-","-"]],
    ["650",4,5,[270,290]],
    ["660",3,5,[272,430]],
    ["750",2,5,[199,245]],
    ["850",2,5,[200,245]],
  ];
  //01 yellow 56-78
  //04 red 70-117
  //06 brown 92-140
  //07 blue 112-165
  //08 purple 149-200
  static const List<List<int>> b10Groups = [
    [01,04,06,07,08],
    [01,04,06,07,08],
    [01,04,06,07,08],
    [01,04,06,07,08]];
  static const List<List<dynamic>> b10UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["01",4,5,[56,78]],
    ["04",4,5,[70,117]],
    ["06",4,5,[92,140]],
    ["07",2,5,[112,165]],
    ["08",2,5,[149,200]],
  ];


  //02 54-71
  //05 67-110
  //07 112-165
  //08 149-200

  //50 42-69
  //60 46-82
  //70 64-96
  //80 70-116
  //90 90-133
  //All
  static const List<List<int>> b11Groups = [
    [60,70,80,90],
    [02,05,07,08],
    [50,60,70,80],
    [60,70,80,90]];
  static const List<List<dynamic>> b11UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["02",4,5,[54,71]],
    ["05",4,5,[67,110]],
    ["07",2,5,[112,165]],
    ["08",2,5,[149,200]],
    ["50",4,5,[42,69]],
    ["60",4,5,[46,82]],
    ["70",4,5,[64,96]],
    ["80",4,5,[70,116]],
    ["90",4,5,[90,133]],
  ];

  //01 56-78
  //04 70-117
  //06 92-140
  //07 112-168
  //08 149-200
  static const List<List<int>> b12Groups = [
    [01,04,06,07,08],
    [01,04,06,07,08],
    [01,04,06,07,08],
    [01,04,06,07,08],
    [01,04,06,07,08]];
  static const List<List<dynamic>> b12UnitTypes = [
    //[unitName,sections,levels,area[from,to]]
    ["01",4,5,[56,78]],
    ["04",4,5,[70,117]],
    ["06",4,5,[92,140]],
    ["07",2,5,[112,168]],
    ["08",2,5,[149,200]]
  ];

  static const List<List<dynamic>> allAppTypes = [
    //123
    ["100",4,6,[100,111]],
    ["200",4,6,[123,141]],
    ["300",2,6,[157,183]],
    ["400",2,6,[177,211]],
    ["500",2,6,[186,239]],
    ["600",2,6,[237,266]],
    ["700",2,6,[298,324]],
    //6
    ["10",2,6,[78,146]],
    ["20",2,6,[106,142]],
    ["11",2,6,[78,146]],
    ["22",2,6,[106,142]],
    ["30",4,5,[58,104]],
    ["33",4,5,[86,174]],
    ["40",3,5,[88,131]],
    //7
    ["50",4,5,[42,69]],
    ["60",4,5,[46,82]],
    ["70",4,5,[64,96]],
    //8
    ["105",4,5,["-","-"]],
    ["305",2,5,["-","-"]],
    ["310",3,5,[142,444]],
    ["320",4,5,[82,151]],
    ["340",2,5,["-","-"]],
    ["350",2,5,["-","-"]],
    ["351",2,5,["-","-"]],
    ["405",2,5,["-","-"]],
    ["450",4,5,["-","-"]],
    ["550",4,5,["-","-"]],
    ["650",4,5,[270,290]],
    ["660",3,5,[272,430]],
    ["750",2,5,[199,245]],
    ["850",2,5,[200,245]],
    //10
    ["01",4,5,[56,78]],
    ["04",4,5,[70,117]],
    ["06",4,5,[92,140]],
    ["07",2,5,[112,165]],
    ["08",2,5,[149,200]],
    //11
    ["02",4,5,[54,71]],
    ["05",4,5,[67,110]],
    ["07",2,5,[112,165]],
    ["08",2,5,[149,200]],
    ["80",4,5,[70,116]],
    ["90",4,5,[90,133]],
  ];

  //areaFrom
  /*
  switch (stage[1]) {
  case 1:
  areaFrom = MadinatyStages.b123UnitTypes[0][3][0];
  areaTo = MadinatyStages.b123UnitTypes[0][3][1];
  break;
  case 2:
  areaFrom = MadinatyStages.b123UnitTypes[0][3][0];
  areaTo = MadinatyStages.b123UnitTypes[0][3][1];
  break;
  case 3:
  areaFrom = MadinatyStages.b123UnitTypes[0][3][0];
  areaTo = MadinatyStages.b123UnitTypes[0][3][1];
  break;
  case 6:
  areaFrom = MadinatyStages.b6UnitTypes[0][3][0];
  areaTo = MadinatyStages.b6UnitTypes[0][3][1];
  break;
  case 7:
  areaFrom = MadinatyStages.b7UnitTypes[0][3][0];
  areaTo = MadinatyStages.b7UnitTypes[0][3][1];
  break;
  case 8:
  areaFrom = MadinatyStages.b8UnitTypes[0][3][0];
  areaTo = MadinatyStages.b8UnitTypes[0][3][1];
  break;
  case 10:
  areaFrom = MadinatyStages.b10UnitTypes[0][3][0];
  areaTo = MadinatyStages.b10UnitTypes[0][3][1];
  break;
  case 11:
  areaFrom = MadinatyStages.b11UnitTypes[0][3][0];
  areaTo = MadinatyStages.b11UnitTypes[0][3][1];
  break;
  case 12:
  areaFrom = MadinatyStages.b12UnitTypes[0][3][0];
  areaTo = MadinatyStages.b12UnitTypes[0][3][1];
  break;
  default:
  break;
  }
  */
  //Group V10 VG2 173 A B C
  //VG1 V8 7 or 7A
  static const List<int> VG1V8 = [7,10,11,12,24,29,30,41,42,44,45,46,57,58,59,75,76,77,80,81,82,98,100,
  102,103,104,];
  static const List<int> VG2V10 = [27,34,39,54,57,109,111,130,163,173,181,182,183,195,207,211,222,223,224,230,233,
  243,245,287,289,290,303];
}