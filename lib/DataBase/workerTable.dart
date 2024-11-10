class WorkerTable{
  int _ID;
  int _SQLID;
  String _Name;
  String _Mobile;
  String _Mac;
  int _Active;
  int _Admin;
  int _Owner;
  int _OwnerId;
  String _COMPANYNAME;
  String _COMPANYMOBILE;
  int _WORKERSCOUNT;
  String _StartDate;
  String _EndDate;
  int _LASTUPDATEID;
  int _VILLA;
  int _APP;
  int _SHOP;

  static List<String> wColumns(){
    return ['ID','SQLID','Name','Mobile','Mac',
      'Active','Admin','Owner','OwnerId','COMPANYNAME','COMPANYMOBILE','WORKERSCOUNT',
      'StartDate','EndDate','LASTUPDATEID','VILLA','APP','SHOP'];
  }

  WorkerTable(this._ID, this._SQLID, this._Name, this._Mobile,
      this._Mac, this._Active, this._Admin, this._Owner, this._OwnerId,
      this._COMPANYNAME,this._COMPANYMOBILE, this._WORKERSCOUNT, this._StartDate, this._EndDate, this._LASTUPDATEID,
      this._VILLA,this._APP,this._SHOP);

  WorkerTable.withNoID(this._SQLID, this._Name, this._Mobile,
      this._Mac, this._Active, this._Admin, this._Owner, this._OwnerId,
      this._COMPANYNAME,this._COMPANYMOBILE, this._WORKERSCOUNT, this._StartDate, this._EndDate, this._LASTUPDATEID,
      this._VILLA,this._APP,this._SHOP);

  WorkerTable.fromMapObject(Map<String,dynamic> map){
    this._ID = map['ID'];
    this._SQLID = map['SQLID'];
    this._Name = map['Name'];
    this._Mobile = map['Mobile'];
    this._Mac = map['Mac'];
    this._Active = map['Active'];
    this._Admin = map['Admin'];
    this._Owner = map['Owner'];
    this._OwnerId = map['OwnerId'];
    this._COMPANYNAME = map['COMPANYNAME'];
    this._COMPANYMOBILE = map['COMPANYMOBILE'];
    this._WORKERSCOUNT = map['WORKERSCOUNT'];
    this._StartDate = map['StartDate'];
    this._EndDate = map['EndDate'];
    this._LASTUPDATEID = map['LASTUPDATEID'];
    this._VILLA = map['VILLA'];
    this._APP = map['APP'];
    this._SHOP = map['SHOP'];
  }

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._ID != null) {
      map['ID'] = this._ID;
    }
    map['SQLID'] = this._SQLID;
    map['Name'] = this._Name;
    map['Mobile'] = this._Mobile;
    map['Mac'] = this._Mac;
    map['Active'] = this._Active;
    map['Admin'] = this._Admin;
    map['Owner'] = this._Owner;
    map['OwnerId'] = this._OwnerId;
    map['COMPANYNAME'] = this._COMPANYNAME;
    map['COMPANYMOBILE'] = this._COMPANYMOBILE;
    map['WORKERSCOUNT'] = this._WORKERSCOUNT;
    map['StartDate'] = this._StartDate;
    map['EndDate'] = this._EndDate;
    map['LASTUPDATEID'] = this._LASTUPDATEID;
    map['VILLA'] = this._VILLA;
    map['APP'] = this._APP;
    map['SHOP'] = this._SHOP;
    return map;
  }

  String get EndDate => _EndDate;

  set EndDate(String value) {
    _EndDate = value;
  }

  String get StartDate => _StartDate;

  set StartDate(String value) {
    _StartDate = value;
  }

  int get WORKERSCOUNT => _WORKERSCOUNT;

  set WORKERSCOUNT(int value) {
    _WORKERSCOUNT = value;
  }

  String get COMPANYMOBILE => _COMPANYMOBILE;

  set COMPANYMOBILE(String value) {
    _COMPANYMOBILE = value;
  }

  String get COMPANYNAME => _COMPANYNAME;

  set COMPANYNAME(String value) {
    _COMPANYNAME = value;
  }

  int get OwnerId => _OwnerId;

  set OwnerId(int value) {
    _OwnerId = value;
  }

  int get Owner => _Owner;

  set Owner(int value) {
    _Owner = value;
  }

  int get Admin => _Admin;

  set Admin(int value) {
    _Admin = value;
  }

  int get Active => _Active;

  set Active(int value) {
    _Active = value;
  }

  String get Mac => _Mac;

  set Mac(String value) {
    _Mac = value;
  }

  String get Mobile => _Mobile;

  set Mobile(String value) {
    _Mobile = value;
  }

  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }

  int get SQLID => _SQLID;

  set SQLID(int value) {
    _SQLID = value;
  }

  int get LASTUPDATEID => _LASTUPDATEID;

  set LASTUPDATEID(int value) {
    _LASTUPDATEID = value;
  }

  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }

  int get SHOP => _SHOP;

  set SHOP(int value) {
    _SHOP = value;
  }

  int get APP => _APP;

  set APP(int value) {
    _APP = value;
  }

  int get VILLA => _VILLA;

  set VILLA(int value) {
    _VILLA = value;
  }
}