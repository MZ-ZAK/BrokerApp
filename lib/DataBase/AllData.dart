class AllData {

  int _ID;
  int _sqlID;
  int _ownerID;
  int _addedByID;
  String _addedBy;
  String _date;
  String _name;
  String _phone1;
  String _phone2;
  String _work;

  int _unit;
  int _offerType;
  int _stage;
  String _unitGroup;
  int _unitStructure;
  int _unitNumber;
  String _unitSection;
  int _level;
  String _unitType;
  int _unitArea;
  int _garden;
  int _gardenArea;
  int _rooms;
  int _bathRooms;
  int _furnished;

  int _rent;
  int _cash;
  int _allOver;
  int _deposit;
  int _paid;
  int _overAmount;
  int _wanted;
  int _leftAmount;
  int _months;

  String _info;
  String _voiceLink;
  String _photoLink;
  String _mapLoc;
  int _lastEditedByID;
  String _lastEditedByName;
  int _available;

  static List<String> aDColumns(){
    return ['ID','sqlID','ownerID','addedByID','addedBy','date','name','phone1','phone2','work',

      'unit','offerType','stage','unitGroup','unitStructure','unitNumber',
      'unitSection','level','unitType','unitArea','garden','gardenArea',
      'rooms','bathRooms','furnished',

      'rent','cash',
      'allOver','deposit','paid','overAmount','wanted','leftAmount','months','info',

      'voiceLink','photoLink','mapLoc','lastEditedByID','lastEditedByName','available'];
  }

  AllData(
      this._ID,
      this._sqlID,
      this._ownerID,
      this._addedByID,
      this._addedBy,
      this._date,
      this._name,
      this._phone1,
      this._phone2,
      this._work,

      this._unit,
      this._offerType,
      this._stage,
      this._unitGroup,
      this._unitStructure,
      this._unitNumber,
      this._unitSection,
      this._level,
      this._unitType,
      this._unitArea,

      this._garden,
      this._gardenArea,
      this._rooms,
      this._bathRooms,
      this._furnished,

      this._rent,
      this._cash,
      this._allOver,
      this._deposit,
      this._paid,
      this._overAmount,
      this._wanted,
      this._leftAmount,
      this._months,

      this._info,
      this._voiceLink,
      this._photoLink,
      this._mapLoc,
      this._lastEditedByID,
      this._lastEditedByName,
      this._available);

  AllData.withNoID
      (
      this._sqlID,
      this._ownerID,
      this._addedByID,
      this._addedBy,
      this._date,
      this._name,
      this._phone1,
      this._phone2,
      this._work,

      this._unit,
      this._offerType,
      this._stage,
      this._unitGroup,
      this._unitStructure,
      this._unitNumber,
      this._unitSection,
      this._level,
      this._unitType,
      this._unitArea,

      this._garden,
      this._gardenArea,
      this._rooms,
      this._bathRooms,
      this._furnished,

      this._rent,
      this._cash,
      this._allOver,
      this._deposit,
      this._paid,
      this._overAmount,
      this._wanted,
      this._leftAmount,
      this._months,

      this._info,
      this._voiceLink,
      this._photoLink,
      this._mapLoc,
      this._lastEditedByID,
      this._lastEditedByName,
      this._available);

  AllData.fromMapObject(Map<String,dynamic> map){
    this._ID = map['ID'];
    this._sqlID = map['sqlID'];
    this._ownerID = map['ownerID'];
    this._addedByID = map['addedByID'];
    this._addedBy = map['addedBy'];
    this._date = map['date'];
    this._name = map['name'];
    this._phone1 = map['phone1'];
    this._phone2 = map['phone2'];
    this._work = map['work'];

    this._unit = map['unit'];
    this._offerType = map['offerType'];
    this._stage = map['stage'];
    this._unitGroup = map['unitGroup'];
    this._unitStructure = map['unitStructure'];
    this._unitNumber = map['unitNumber'];
    this._unitSection = map['unitSection'];
    this._level = map['level'];
    this._unitType = map['unitType'];
    this._unitArea = map['unitArea'];
    this._garden = map['garden'];
    this._gardenArea = map['gardenArea'];
    this._rooms = map['rooms'];
    this._bathRooms = map['bathRooms'];
    this._furnished = map['furnished'];

    this._rent = map['rent'];
    this._cash = map['cash'];
    this._allOver = map['allOver'];
    this._deposit = map['deposit'];
    this._paid = map['paid'];
    this._overAmount = map['overAmount'];
    this._wanted = map['wanted'];
    this._leftAmount = map['leftAmount'];
    this._months = map['months'];

    this._info = map['info'];
    this._voiceLink = map['voiceLink'];
    this._photoLink = map['photoLink'];
    this._mapLoc = map['mapLoc'];
    this._lastEditedByID = map['lastEditedByID'];
    this._lastEditedByName = map['lastEditedByName'];
    this._available = map['available'];
  }

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._ID != null) {
      map['ID'] = this._ID;
    }
    map['sqlID'] = this._sqlID;
    map['ownerID'] = this._ownerID;
    map['addedByID'] = this._addedByID;
    map['addedBy'] = this._addedBy;
    map['date'] = this._date;
    map['name'] = this._name;
    map['phone1'] = this._phone1;
    map['phone2'] = this._phone2;
    map['work'] = this._work;

    map['unit'] = this._unit;
    map['offerType'] = this._offerType;
    map['stage'] = this._stage;
    map['unitGroup'] = this._unitGroup;
    map['unitStructure'] = this._unitStructure;
    map['unitNumber'] = this._unitNumber;
    map['unitSection'] = this._unitSection;
    map['level'] = this._level;
    map['unitType'] = this._unitType;
    map['unitArea'] = this._unitArea;
    map['garden'] = this._garden;
    map['gardenArea'] = this._gardenArea;
    map['rooms'] = this._rooms;
    map['bathRooms'] = this._bathRooms;
    map['furnished'] = this._furnished;

    map['rent'] = this._rent;
    map['cash'] = this._cash;
    map['allOver'] = this._allOver;
    map['deposit'] = this._deposit;
    map['paid'] = this._paid;
    map['overAmount'] = this._overAmount;
    map['wanted'] = this._wanted;
    map['leftAmount'] = this._leftAmount;
    map['months'] = this._months;

    map['info'] = this._info;
    map['voiceLink'] = this._voiceLink;
    map['photoLink'] = this._photoLink;
    map['mapLoc'] = this._mapLoc;
    map['lastEditedByID'] = this._lastEditedByID;
    map['lastEditedByName'] = this._lastEditedByName;
    map['available'] = this._available;
    return map;
  }

  String get mapLoc => _mapLoc;

  set mapLoc(String value) {
    _mapLoc = value;
  }

  String get photoLink => _photoLink;

  set photoLink(String value) {
    _photoLink = value;
  }

  String get voiceLink => _voiceLink;

  set voiceLink(String value) {
    _voiceLink = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }

  int get months => _months;

  set months(int value) {
    _months = value;
  }

  int get leftAmount => _leftAmount;

  set leftAmount(int value) {
    _leftAmount = value;
  }

  int get wanted => _wanted;

  set wanted(int value) {
    _wanted = value;
  }

  int get overAmount => _overAmount;

  set overAmount(int value) {
    _overAmount = value;
  }

  int get paid => _paid;

  set paid(int value) {
    _paid = value;
  }

  int get deposit => _deposit;

  set deposit(int value) {
    _deposit = value;
  }

  int get allOver => _allOver;

  set allOver(int value) {
    _allOver = value;
  }

  int get cash => _cash;

  set cash(int value) {
    _cash = value;
  }

  int get rent => _rent;

  set rent(int value) {
    _rent = value;
  }

  int get furnished => _furnished;

  set furnished(int value) {
    _furnished = value;
  }

  int get bathRooms => _bathRooms;

  set bathRooms(int value) {
    _bathRooms = value;
  }

  int get rooms => _rooms;

  set rooms(int value) {
    _rooms = value;
  }

  int get gardenArea => _gardenArea;

  set gardenArea(int value) {
    _gardenArea = value;
  }

  int get garden => _garden;

  set garden(int value) {
    _garden = value;
  }

  int get unitArea => _unitArea;

  set unitArea(int value) {
    _unitArea = value;
  }

  String get unitType => _unitType;

  set unitType(String value) {
    _unitType = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  String get unitSection => _unitSection;

  set unitSection(String value) {
    _unitSection = value;
  }

  int get unitNumber => _unitNumber;

  set unitNumber(int value) {
    _unitNumber = value;
  }

  String get unitGroup => _unitGroup;

  set unitGroup(String value) {
    _unitGroup = value;
  }

  int get stage => _stage;

  set stage(int value) {
    _stage = value;
  }

  int get offerType => _offerType;

  set offerType(int value) {
    _offerType = value;
  }

  int get unit => _unit;

  set unit(int value) {
    _unit = value;
  }

  String get work => _work;

  set work(String value) {
    _work = value;
  }

  String get phone2 => _phone2;

  set phone2(String value) {
    _phone2 = value;
  }

  String get phone1 => _phone1;

  set phone1(String value) {
    _phone1 = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get addedBy => _addedBy;

  set addedBy(String value) {
    _addedBy = value;
  }

  int get sqlID => _sqlID;

  set sqlID(int value) {
    _sqlID = value;
  }

  int get unitStructure => _unitStructure;

  set unitStructure(int value) {
    _unitStructure = value;
  }

  int get ownerID => _ownerID;

  set ownerID(int value) {
    _ownerID = value;
  }

  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }

  int get addedByID => _addedByID;

  set addedByID(int value) {
    _addedByID = value;
  }

  String get lastEditedByName => _lastEditedByName;

  set lastEditedByName(String value) {
    _lastEditedByName = value;
  }

  int get lastEditedByID => _lastEditedByID;

  set lastEditedByID(int value) {
    _lastEditedByID = value;
  }

  int get available => _available;

  set available(int value) {
    _available = value;
  }
}