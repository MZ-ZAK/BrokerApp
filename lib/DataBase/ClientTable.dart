

class ClientTable{
  int _ID;
  int _SQLID;
  int _WORKERID;
  int _gotBy;
  int _OWNERID;
  String _CONTACTNAME;
  String _CONTACTMOBILE;
  String _CONTACTWORK;
  String _CONTACTCAR;
  String _INFO;
  String _VOICELINK;

  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }

  String _DATEADDED;
  int _ACTIVEUSER;
  static List<String> cColumns(){
    return ['ID','SQLID','WORKERID','gotBy','OWNERID','ACTIVEUSER','CONTACTNAME','CONTACTMOBILE',
      'CONTACTWORK','CONTACTCAR','INFO','VOICELINK','DATEADDED'];
  }

    ClientTable(
        this._ID,
        this._SQLID,
        this._WORKERID,
        this._gotBy,
        this._OWNERID,
        this._ACTIVEUSER,
        this._CONTACTNAME,
        this._CONTACTMOBILE,
        this._CONTACTWORK,
        this._CONTACTCAR,
        this._INFO,
        this._VOICELINK,
        this._DATEADDED
        );

    ClientTable.withNoID(
        this._SQLID,
        this._WORKERID,
        this._gotBy,
        this._OWNERID,
        this._ACTIVEUSER,
        this._CONTACTNAME,
        this._CONTACTMOBILE,
        this._CONTACTWORK,
        this._CONTACTCAR,
        this._INFO,
        this._VOICELINK,
        this._DATEADDED
        );

  ClientTable.withNoIDAll(
      this._SQLID,
      this._WORKERID,
      this._gotBy,
      this._OWNERID,
      this._ACTIVEUSER,
      this._CONTACTNAME,
      this._CONTACTMOBILE,
      this._CONTACTWORK,
      this._CONTACTCAR,
      this._INFO,
      this._VOICELINK,
      this._DATEADDED
      );


    ClientTable.fromMapObject(Map<String,dynamic> map){
      this._ID = map['ID'];
      this._SQLID = map['SQLID'];
      this._WORKERID = map['WORKERID'];
      this._gotBy = map['gotBy'];
      this._OWNERID = map['OWNERID'];
      this._ACTIVEUSER = map['ACTIVEUSER'];
      this._CONTACTNAME = map['CONTACTNAME'];
      this._CONTACTMOBILE = map['CONTACTMOBILE'];
      this._CONTACTWORK = map['CONTACTWORK'];
      this._CONTACTCAR = map['CONTACTCAR'];
      this._INFO = map['INFO'];
      this._VOICELINK = map['VOICELINK'];
      this._DATEADDED = map['DATEADDED'];
    }

    Map<String,dynamic> toMap() {
      var map = Map<String,dynamic>();
      if(this._ID != null)
      {
        map['ID'] = this._ID;
      }
      map['SQLID'] = this._SQLID;
      map['WORKERID'] = this._WORKERID;
      map['gotBy'] = this._gotBy;
      map['OWNERID'] = this._OWNERID;
      map['ACTIVEUSER'] = this._ACTIVEUSER;
      map['CONTACTNAME'] = this._CONTACTNAME;
      map['CONTACTMOBILE'] = this._CONTACTMOBILE;
      map['CONTACTWORK'] = this._CONTACTWORK;
      map['CONTACTCAR'] = this._CONTACTCAR;
      map['INFO'] = this._INFO;
      map['VOICELINK'] = this._VOICELINK;
      map['DATEADDED'] = this._DATEADDED;
      return map;
    }

  int get SQLID => _SQLID;

  set SQLID(int value) {
    _SQLID = value;
  }

  int get WORKERID => _WORKERID;

  set WORKERID(int value) {
    _WORKERID = value;
  }

  int get OWNERID => _OWNERID;

  set OWNERID(int value) {
    _OWNERID = value;
  }

  String get CONTACTNAME => _CONTACTNAME;

  set CONTACTNAME(String value) {
    _CONTACTNAME = value;
  }

  String get CONTACTMOBILE => _CONTACTMOBILE;

  set CONTACTMOBILE(String value) {
    _CONTACTMOBILE = value;
  }

  String get CONTACTWORK => _CONTACTWORK;

  set CONTACTWORK(String value) {
    _CONTACTWORK = value;
  }

  String get CONTACTCAR => _CONTACTCAR;

  set CONTACTCAR(String value) {
    _CONTACTCAR = value;
  }

  String get INFO => _INFO;

  set INFO(String value) {
    _INFO = value;
  }

  int get gotBy => _gotBy;

  set gotBy(int value) {
    _gotBy = value;
  }

  String get DATEADDED => _DATEADDED;

  set DATEADDED(String value) {
    _DATEADDED = value;
  }

  int get ACTIVEUSER => _ACTIVEUSER;

  set ACTIVEUSER(int value) {
    _ACTIVEUSER = value;
  }

  String get VOICELINK => _VOICELINK;

  set VOICELINK(String value) {
    _VOICELINK = value;
  }
}
