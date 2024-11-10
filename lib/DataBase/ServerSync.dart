class ServerSync{
  int _ID;
  int _doneBy;
  int _ownerID;
  String _dataBaseName;
  int _dataID;
  String _operation;

  static List<String> syncColumns(){
    return ['ID','doneBy','ownerID','dataBaseName','dataID','operation'];
  }

  ServerSync(this._ID, this._doneBy, this._ownerID, this._dataBaseName,this._dataID, this._operation);

  ServerSync.withNoID(this._doneBy, this._ownerID, this._dataBaseName,this._dataID, this._operation);

  ServerSync.fromMapObject(Map<String,dynamic> map){
    this._ID = map['ID'];
    this._doneBy = map['doneBy'];
    this._ownerID = map['ownerID'];
    this._dataBaseName = map['dataBaseName'];
    this._dataID = map['dataID'];
    this._operation = map['operation'];
  }

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._ID != null) {
      map['ID'] = this._ID;
    }
    map['doneBy'] = this._doneBy;
    map['ownerID'] = this._ownerID;
    map['dataBaseName'] = this._dataBaseName;
    map['dataID'] = this._dataID;
    map['operation'] = this._operation;
    return map;
  }

  String get operation => _operation;

  set operation(String value) {
    _operation = value;
  }

  int get dataID => _dataID;

  set dataID(int value) {
    _dataID = value;
  }

  String get dataBaseName => _dataBaseName;

  set dataBaseName(String value) {
    _dataBaseName = value;
  }

  int get ownerID => _ownerID;

  set ownerID(int value) {
    _ownerID = value;
  }

  int get doneBy => _doneBy;

  set doneBy(int value) {
    _doneBy = value;
  }

  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }
}