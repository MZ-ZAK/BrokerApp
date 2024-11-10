import 'dart:io';
import 'package:flutter/material.dart';
import 'package:madinaty_app/DataBase/AllData.dart';
import 'package:madinaty_app/DataBase/ClientTable.dart';
import 'package:madinaty_app/DataBase/ServerSync.dart';
import 'package:madinaty_app/DataBase/workerTable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider
{
  static DataBaseProvider _dataBaseProvider;

  static Database _database;

  //Clients Table
  String client = 'clients';
  String worker = 'worker';
  String allData = 'allData';
  String serverSync = 'serverSync';

  DataBaseProvider._();
  static final DataBaseProvider db = DataBaseProvider._();

  Future<int> dispose() async {
    await _database.close().then((value)
    {
      return 1;
    }
    );
    return 1;
  }

  Future<Database> get database async{
    if(_database == null)
    {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/MadinatyApp.db';

    return await openDatabase(path,version: 2,onCreate: _createDb);
  }

  Future<void> removeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/MadinatyApp.db';
    await deleteDatabase(path);
  }

  void _createDb (Database db, int newVersion) async{
    //serverSync
    await db.execute('''
        CREATE TABLE $serverSync (
        ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        doneBy INTEGER NOT NULL,
        ownerID INTEGER NOT NULL,
        dataBaseName TEXT NOT NULL,
        dataID INTEGER NOT NULL,
        operation TEXT NOT NULL)
        ''');
    //allData
    await db.execute('''
        CREATE TABLE $allData (
        ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sqlID INTEGER NOT NULL,
        ownerID INTEGER NOT NULL,
        addedByID INTEGER NOT NULL,
        addedBy TEXT NOT NULL,
        date TEXT NOT NULL,
        name TEXT NOT NULL,
        phone1 TEXT NOT NULL,
        phone2 TEXT NOT NULL,
        work TEXT NOT NULL,
        
        unit INTEGER NOT NULL,
        offerType INTEGER NOT NULL,
        stage INTEGER NOT NULL,
        unitGroup TEXT NOT NULL,
        unitStructure INTEGER NOT NULL,
        unitNumber INTEGER NOT NULL,
        unitSection TEXT NOT NULL,
        level INTEGER NOT NULL,
        unitType TEXT NOT NULL,
        unitArea INTEGER NOT NULL,
        garden INTEGER NOT NULL,
        gardenArea INTEGER NOT NULL,
        rooms INTEGER NOT NULL,
        bathRooms INTEGER NOT NULL,
        furnished INTEGER NOT NULL,
        
        rent INTEGER NOT NULL,
        cash INTEGER NOT NULL,
        allOver INTEGER NOT NULL,
        deposit INTEGER NOT NULL,
        paid INTEGER NOT NULL,
        overAmount INTEGER NOT NULL,
        wanted INTEGER NOT NULL,
        leftAmount INTEGER NOT NULL,
        months INTEGER NOT NULL,
        
        info TEXT NOT NULL,
        voiceLink TEXT NOT NULL,
        photoLink TEXT NOT NULL,
        mapLoc TEXT NOT NULL,
        lastEditedByID INTEGER NOT NULL,
        lastEditedByName TEXT NOT NULL,
        available INTEGER NOT NULL)
        ''');
    //client
    await db.execute('''
        CREATE TABLE $client (
        ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        SQLID INTEGER NOT NULL,
        WORKERID INTEGER NOT NULL,
        gotBy INTEGER NOT NULL,
        OWNERID INTEGER NOT NULL,
        ACTIVEUSER INTEGER NOT NULL,
        CONTACTNAME TEXT NOT NULL,
        CONTACTMOBILE TEXT NOT NULL,
        CONTACTWORK TEXT NOT NULL,
        CONTACTCAR TEXT NOT NULL,
        INFO TEXT NOT NULL,
        VOICELINK TEXT NOT NULL,
        DATEADDED TEXT NOT NULL)
        ''');
    //worker
    await db.execute('''
        CREATE TABLE $worker (
        ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        SQLID INTEGER NOT NULL,
        Name TEXT NOT NULL,
        Mobile TEXT NOT NULL,
        Mac TEXT NOT NULL,
        Active INTEGER NOT NULL,
        Admin INTEGER NOT NULL,
        Owner INTEGER NOT NULL,
        OwnerId INTEGER NOT NULL,
        COMPANYNAME TEXT NOT NULL,
        COMPANYMOBILE TEXT NOT NULL,
        WORKERSCOUNT INTEGER NOT NULL,
        StartDate TEXT NOT NULL,
        EndDate TEXT NOT NULL,
        LASTUPDATEID INTEGER NOT NULL,
        VILLA INTEGER NOT NULL,
        APP INTEGER NOT NULL,
        SHOP INTEGER NOT NULL)
        ''');
  }



  //Client Table
  Future<int> cInsertContact(ClientTable clientTable) async{
    Database db = await database;
    return await db.insert(client, clientTable.toMap());
  }

  Future<List<ClientTable>> cGetAllRowsByTableName() async{
    Database db = await database;
    final List<Map>clientRow = await db.query(client,orderBy: 'CONTACTNAME');
    return clientRow.length == 0
        ? null
        : clientRow.map((e) => ClientTable.fromMapObject(e)).toList();
  }

  Future<List<Map>> cGetColumnsWhere({List<String> columnsNames,
    String whereCode = ""}) async {
    Database db = await database;
    List<Map> cRow;
    cRow = await db.query(client,
        columns: columnsNames,
        where: "$whereCode");

    //debugPrint("FROM DATAPROVIDER " + cRow[0]['mapLoc'].toString());
    return cRow.length == 0
        ? null
        : cRow;
  }

  Future<List<ClientTable>> cGetAllRowsByTableNameLogin() async{
    Database db = await database;
    final List<Map>clientRow = await db.query(client,orderBy: 'CONTACTNAME');
    return clientRow.length == 0
        ? []
        : clientRow.map((e) => ClientTable.fromMapObject(e)).toList();
  }

  Future<ClientTable> cGetRow(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        'clients',columns: ClientTable.cColumns(),where: 'ID = $id'
    );
    if (maps.length > 0) {
      return ClientTable.fromMapObject(maps.first);
    }
    else
    {
      return null;
    }
  }

  Future<bool> cCheckMobile(String number) async {
    Database db = await database;
    List<Map> maps = await db.query(
        //'clients',columns: ClientTable.cColumns(),where: 'CONTACTMOBILE = $number'
      client,columns: ['CONTACTMOBILE'],where: 'CONTACTMOBILE = ?',
      whereArgs: [number]
    );
    maps.forEach((element) {debugPrint(element.toString());});
    if (maps.length > 0) {
      return true;
    }
    else
      {
        return false;
      }
  }

  Future<int> cDelete(String columnName,int id) async {
    Database db = await database;
    return await db.delete(client, where: '$columnName = $id');
  }

  Future<int> cUpdate(ClientTable clientTable,String columnName,int id) async {
    Database db = await database;
    return await db.update(client, clientTable.toMap(),
        where: '$columnName = $id');
  }

  Future<int> cUpdateColumn(String columnName,dynamic columnNameValue,int idValue) async {
    var map = Map<String,dynamic>();
    map[columnName] = columnNameValue;

    Database db = await database;
    return await db.update(client, map,
        where: 'ID = $idValue');
  }

  Future<bool> cUpdateColumns(List<String> columnsName,List<dynamic> columnsNameValue,int idValue) async {
    var map = Map<String,dynamic>();
    debugPrint("Coulumns Names: " + columnsName.length.toString());
    debugPrint("Coulumns Values: " + columnsNameValue.length.toString());
    if(columnsName.length == columnsNameValue.length)
      {
        for(int i = 0; i< columnsName.length; i++)
        {
          map[columnsName[i]] = columnsNameValue[i];
        }
        Database db = await database;
        if(await db.update(client, map,
            where: 'ID = $idValue') > 0)
          {
            return true;
          }
        else
          {
            return false;
          }
    }
    else
      {
        debugPrint("ERROR Total Inputs not equal Total Values");
        return false;
      }
    return false;
  }

  //Worker Table
  Future<int> wInsertContact(WorkerTable workerTable) async{
    Database db = await database;
    return await db.insert(worker, workerTable.toMap());
  }

  Future<List<WorkerTable>> wGetAllRowsByTableName() async{
    Database db = await database;
    final List<Map> workerRow = await db.query(worker);
    return workerRow.length == 0
        ? []
        : workerRow.map((e) => WorkerTable.fromMapObject(e)).toList();
  }

  Future<WorkerTable> wGetRow(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        worker,columns: WorkerTable.wColumns(),where: 'ID = $id'
    );
    if (maps.length > 0) {
      return WorkerTable.fromMapObject(maps.first);
    }
    return null;
  }

  Future<int> wDelete(String columnName,int id) async {
    Database db = await database;
    return await db.delete(worker, where: '$columnName = $id');
  }

  Future<int> wUpdate(WorkerTable workerTable,String columnName,int id) async {
    Database db = await database;
    return await db.update(worker, workerTable.toMap(),
        where: '$columnName = $id');
  }

  //LAST-ID or COLUMN IN WORKER
  Future<int> wUpdateLastUpdate(String columnName,dynamic columnNameValue) async {
    var map = Map<String,int>();
    map[columnName] = columnNameValue;

    Database db = await database;
    return await db.update(worker, map,
        where: 'ID = 1');
  }

  //EDIT COLUMN IN WORKER
  Future<int> wUpdateThisColumn(String columnName,dynamic columnNameValue) async {
    var map = Map<String,int>();
    map[columnName] = columnNameValue;

    Database db = await database;
    return await db.update(worker, map,
        where: 'ID = 1');
  }

  //AllData
  Future<int> aDInsertUnit(AllData allDataTable) async{
    Database db = await database;
    return await db.insert(allData, allDataTable.toMap());
  }

  Future<List<AllData>> aDGetAllRowsByTableName() async{
    Database db = await database;
    final List<Map> aDRow = await db.query(allData);
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
  }

  Future<List<AllData>> aDGetAllValuesWhere({List<String> columnsNames,
      String whereCode = "", String debugCode}) async {
    Database db = await database;
    List<Map> aDRow;
    aDRow = await db.query(allData,
        columns: columnsNames,
        where: "$whereCode");

    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
  }

  Future<List<Map>> aDGetColumnsWhere({List<String> columnsNames,
    String whereCode = ""}) async {
    Database db = await database;
    List<Map> aDRow;
    aDRow = await db.query(allData,
        columns: columnsNames,
        where: "$whereCode");

    debugPrint("FROM DATAPROVIDER " + aDRow[0]['mapLoc'].toString());
    return aDRow.length == 0
        ? null
        : aDRow;
  }

  Future<List<List>> aDGetAllAppOfUnit({List<String> columnsNames,
    String whereCode = "", String debugCode}) async {
    Database db = await database;
    List<Map> aDRow;
    List<List<dynamic>> listOfDynamics = List();
    aDRow = await db.query(allData,
        orderBy: 'level',
        columns: columnsNames,
        where: "$whereCode");
    aDRow.forEach((row) => listOfDynamics.add([row['ID'],row['unitNumber'],row['level'],row['unitSection']]));

    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }

  Future<List<List>> aDGetAllDistinctValuesOfColumn(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<List<dynamic>> listOfDynamics = List();
    if(groupedBy == "")
      {
        aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy);
        //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
        aDRow.forEach((row) => listOfDynamics.add(row['$debugCode'] == 1 ? ["فيلا",1] : ["شقة",2]));
      }
    else if(exFor == "stage")
      {
        aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
            groupBy: groupedBy,where: "$whereCode");
        //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
        aDRow.forEach((row) => listOfDynamics.add([row['stage'],"VG" + row['stage'].toString()]));
      }
    else if(exFor == "stageApp")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add([row['stage'],"B" + row['stage'].toString()]));
    }
    else if(exFor == "type")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add([row['unitType']]));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    //debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }

  Future<List> aDGetAllDistinctValuesOfTypes(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<dynamic> listOfDynamics = List();
    if(exFor == "type")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(row['unitType']));
      //aDRow.forEach((row) => listOfDynamics.add(row['unitType']));
    }
    if(exFor == "everyType")
    {
      aDRow = await db.query(allData,columns: columnsNames,orderBy: orderedBy,
          where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(row['mapLoc']));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    //debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }

  Future<List> aDGetAllDistinctValuesOfTypesApp(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<dynamic> listOfDynamics = List();
    if(exFor == "type")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add([row['stage'],row['unitGroup'],row['unitType']]));
      //aDRow.forEach((row) => listOfDynamics.add(row['unitType']));
    }
    if(exFor == "everyType")
    {
      aDRow = await db.query(allData,columns: columnsNames,orderBy: orderedBy,
          where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(row['mapLoc']));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    //debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }


  Future<List<List<dynamic>>> aDGetAllDistinctValuesOfTypesLocNumber(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<List<dynamic>> listOfDynamics = List();
    if(exFor == "everyType")
    {
      aDRow = await db.query(allData,columns: columnsNames,orderBy: orderedBy,
          where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(
      [
        row['unitNumber'],
        [
          row['mapLoc'],
          row['level']
        ],
        row['ID'],
        row['available'],
        row['offerType'],
      ]));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    //debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }
//mapLoc of each unitNumber with any Level
  Future<List<List<dynamic>>> aDGetAllDistinctValuesOfUnitNumberLocations(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<List<dynamic>> listOfDynamics = List();
    if(exFor == "DistinctUnitNumberLocations")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(
          [
            row['unitNumber'],
            [
              row['mapLoc'],
              row['level']
            ],
            row['ID'],
            row['stage'],
            row['unitGroup'],
            row['available'],
          ]));
    }

    if(exFor == "everyType")
    {
      aDRow = await db.query(allData,columns: columnsNames,orderBy: orderedBy,
          where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(
          [
            row['unitNumber'],
            [
              row['mapLoc'],
              row['level']
            ],
            row['ID']
          ]));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    //debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }

  //Get Distinct values of Level for each type
  Future<List<dynamic>> aDGetAllDistinctValuesOfLevelsForEachType(List<String> columnsNames,
      String orderedBy,{String groupedBy = "",String whereCode = "", String debugCode,String exFor}) async{
    Database db = await database;
    List<Map> aDRow;
    List<dynamic> listOfDynamics = List();
    if(exFor == "allLevels")
    {
      aDRow = await db.query(allData,distinct: true,columns: columnsNames,orderBy: orderedBy,
          groupBy: groupedBy,where: "$whereCode");
      //aDRow.forEach((row) => print("Value of $debugCode is : " + row['$debugCode'].toString()));
      aDRow.forEach((row) => listOfDynamics.add(
          row['level']));
    }

    /*
    return aDRow.length == 0
        ? []
        : aDRow.map((e) => AllData.fromMapObject(e)).toList();
        */
    debugPrint(listOfDynamics.toString());
    return listOfDynamics.length == 0
        ? []
        : listOfDynamics;
  }

  Future<bool> aDCheckUnitNumber(int unit, int stage, String unitGroup, int unitNumber, int level, String unitSection) async {
    Database db = await database;
    List<Map> maps = await db.query(
        allData,
        columns: ['*'],
        where: 'unit = $unit AND stage = $stage AND unitGroup = "$unitGroup" AND unitNumber = $unitNumber AND level = $level AND unitSection = "$unitSection"',
    );
    maps.forEach((element) {debugPrint(element.toString());});
    if (maps.length > 0) {
      return true;
    }
    else
    {
      return false;
    }
  }

  Future<List<Map>> aDCheckAppUnitNumber(int unit, int stage, String unitGroup, int unitNumber) async {
    Database db = await database;
    List<Map> maps = await db.query(
      allData,
      columns: ['mapLoc'],
      where: 'unit = $unit AND stage = $stage AND unitGroup = "$unitGroup" AND unitNumber = $unitNumber',
    );
    maps.forEach((element) {debugPrint(element.toString());});
    if (maps.length > 0) {
      return maps;
    }
    else
    {
      return null;
    }
  }

  Future<AllData> aDGetRow(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        allData,columns: AllData.aDColumns(),where: 'ID = $id'
    );
    if (maps.length > 0) {
      debugPrint(maps.first.toString());
      return AllData.fromMapObject(maps.first);
    }
    return null;
  }

  Future<bool> aDCheckSQLID(int sqlID) async {
    Database db = await database;
    List<Map> maps = await db.query(
        allData,columns: ['sqlID'],where: 'sqlID = $sqlID'
    );
    if (maps.length > 0) {
      debugPrint("Unit check found, Update only now");
      return true;
    }
    debugPrint("Unit check not found, return false");
    return false;
  }

  Future<int> aDDelete(String columnName,int id) async {
    Database db = await database;
    return await db.delete(allData, where: '$columnName = $id');
  }

  Future<int> aDUpdate(AllData allDataTable,String columnName,int id) async {
    Database db = await database;
    return await db.update(allData, allDataTable.toMap(),
        where: '$columnName = $id');
  }

  Future<int> aDUpdateColumn(String columnName,dynamic columnNameValue,int idValue) async {
    var map = Map<String,dynamic>();
    map[columnName] = columnNameValue;

    Database db = await database;
    return await db.update(allData, map,
        where: 'ID = $idValue');
  }

  Future<int> aDUpdateWhere(String columnName,dynamic columnNameValue,int iDValue) async {
    var map = Map<String,dynamic>();
    map[columnName] = columnNameValue;

    Database db = await database;
    return await db.update(allData, map,
        where: 'ID = $iDValue');
  }

  //SyncServer
  Future<int> syncInsertOperation(ServerSync serverSyncTable) async{
    Database db = await database;
    return await db.insert(serverSync, serverSyncTable.toMap());
  }

  Future<List<ServerSync>> syncGetAllRowsByTableName() async{
    Database db = await database;
    final List<Map> syncRow = await db.query(serverSync);
    return syncRow.length == 0
        ? []
        : syncRow.map((e) => ServerSync.fromMapObject(e)).toList();
  }

  Future<ServerSync> syncGetFirstRows() async{
    Database db = await database;
    final List<Map> syncRow = await db.query(serverSync);
    //debugPrint("syncRow: " + syncRow.toString());
    if (syncRow.length > 0) {
      return ServerSync.fromMapObject(syncRow.first);
    }
    else
      {
        return null;
      }
  }

  Future<ServerSync> syncGetRow(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        serverSync,columns: ServerSync.syncColumns(),where: 'ID = $id'
    );
    if (maps.length > 0) {
      return ServerSync.fromMapObject(maps.first);
    }
    return null;
  }

  Future<int> syncDelete(String columnName,int id) async {
    Database db = await database;
    return await db.delete(serverSync, where: '$columnName = $id');
  }

  Future<int> syncUpdate(ServerSync serverSyncTable,String columnName,int id) async {
    Database db = await database;
    return await db.update(serverSync, serverSyncTable.toMap(),
        where: '$columnName = $id');
  }

  Future<List<ServerSync>> syncGetAllValuesWhere({List<String> columnsNames,
    String whereCode = "", String debugCode}) async {
    Database db = await database;
    List<Map> syncRow;
    syncRow = await db.query(serverSync,
        columns: columnsNames,
        where: "$whereCode");

    return syncRow.length == 0
        ? []
        : syncRow.map((e) => ServerSync.fromMapObject(e)).toList();
  }
}