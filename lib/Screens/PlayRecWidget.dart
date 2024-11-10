import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayRecWidget extends StatefulWidget {
  @override
  _PlayRecWidgetState createState() => new _PlayRecWidgetState();
}

class _PlayRecWidgetState extends State<PlayRecWidget> {
  MedcorderAudio audioModule = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  String fileURL = "";
  bool nowOk = false;

  String recordButtonText = "تسجيل";
  Color recordButtonColor = AppConstants.orange;

  String playButtonText = "تشغيل";
  Color playButtonColor = AppConstants.orange;

  List<dynamic> getAll;
  List<List<dynamic>> tempList = [];
  List<List<dynamic>> recordList = [];
  List<String> playList = [];
  String selectedRecord = "";

  @override
  initState() {
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  Future<bool> updateRecordList() async {
    Directory directory = await getApplicationSupportDirectory();
    if (await Directory(directory.path + "/temp/").exists()) {
      setState(() {
        getAll = Directory(directory.path + "/temp/").listSync();
        List<dynamic> tempListAdd = [0, 0];
        int i1;
        getAll.length > 0 ? i1 = getAll.length - 1 : i1 = 0;
        for (int i = i1; i < getAll.length; i++) {
          tempListAdd[0] = (i + 1).toString();
          tempListAdd[1] = getAll[i].toString();
          //tempList.add(tempListAdd);
          recordList.add(tempListAdd);
        }
        if (recordList.length > 0) {
          selectedRecord = recordList[recordList.length - 1][0];
        }
      });
      nowOk = false;
      return true;
    } else {
      nowOk = false;
      return true;
    }
  }

  clearTheRecordDirectory() async {
    Directory directory = await getApplicationSupportDirectory();
    final checkPathExistence = await Directory(directory.path + "/temp/").exists();
    if (checkPathExistence) {
      try {
        List file2 = new List();
        file2 = Directory(directory.path + "/temp/").listSync();
        for (int i1 = 0; i1 < file2.length; i1++) {
          debugPrint("Second One: " + file2[i1].toString());
          await file2[i1].delete();
        }
      } catch (e) {
        debugPrint("No Folder");
      }
    }
    try {
      List file1 = new List();
      file1 = Directory(directory.path + "/").listSync();
      for (int i = 0; i < file1.length; i++) {
        debugPrint("First One: " + file1[i].toString());
        await file1[i].delete();
      }
    } catch (e) {
      debugPrint("empty folder");
    }
    updateRecordList();
  }

  Future _initSettings() async {
    clearTheRecordDirectory();
    var status = await Permission.microphone.status;
    debugPrint(status.toString());
    if (status.isUndetermined) {
      Map<Permission, PermissionStatus> statuses = await [Permission.microphone].request();
    } else if (status.isGranted) {
      final String result = await audioModule.checkMicrophonePermissions();
      if (result == 'OK') {
        await audioModule.setAudioSettings();
        setState(() {
          canRecord = true;
        });
      }
      return;
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      recordPosition = event['currentTime'];
      changeRecordButtonSettings();
    }
    if (event['code'] == 'playing') {
      playPosition = event['currentTime'];
      isPlay = true;
      changePlayButtonSettings();
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      playPosition = 0.0;
      isPlay = false;
      changePlayButtonSettings();
    }
  }

  Future _startRecord() async {
    isRecord = true;
    changeRecordButtonSettings();
    try {
      DateTime time = new DateTime.now();
      fileURL = "";
      file = time.millisecondsSinceEpoch.toString();
      final String result = await audioModule.startRecord(file);
      isRecord = true;
      nowOk = false;
    } catch (e) {
      file = "";
      nowOk = false;
    }
  }

  Future _stopRecord() async {
    try {
      if (file != "") {
        fileURL = file;
        playList.add("temp/$file");
        setState(() {
          AppConstants.playList = playList;
        });
        String fileName = file;

        Directory directory = await getApplicationSupportDirectory();

        File file1 = File(directory.path + "/" + fileName + ".aac");
        String newPath1 = directory.path + "/temp/" + fileName + ".aac";
        String newPath2 = directory.path + "/temp/";

        final checkPathExistence = await Directory(directory.path + "/temp/").exists();
        if (checkPathExistence) {
          try {
            await file1.rename(directory.path + "/temp/" + fileName + ".aac");
            debugPrint("It Is THere!!!! And Copied");
          } catch (e) {
            await file1.copy(directory.path + fileName + ".aac");
            await file1.delete();
          }
        } else {
          Directory(directory.path + "/temp/").create().then((Directory directory) async {
            try {
              await file1.rename(directory.path + fileName + ".aac");
              debugPrint("It Is NOTNOTNOT THere!!!! And Copied");
            } catch (e) {
              await file1.copy(directory.path + fileName + ".aac");
              await file1.delete();
            }
          });
        }
      }
      final String result = await audioModule.stopRecord();
      if (await updateRecordList() == true) {
        isRecord = false;
        fileURL = file;
        changeRecordButtonSettings();
        file = "temp/$file";
        nowOk = false;
      }
    } catch (e) {
      isRecord = false;
      changeRecordButtonSettings();
      updateRecordList();
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
      setState(() {
        isPlay = false;
        changePlayButtonSettings();
        nowOk = false;
      });
    } else {
      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
      setState(() {
        isPlay = true;
        changePlayButtonSettings();
        nowOk = false;
      });
    }
  }

  changePlayButtonSettings() {
    if (isPlay) {
      setState(() {
        playButtonText = "إيقاف";
        playButtonColor = Colors.lightBlueAccent;
      });
    } else {
      setState(() {
        playButtonText = "تشغيل";
        playButtonColor = AppConstants.orange;
      });
    }
  }

  changeRecordButtonSettings() {
    if (isRecord) {
      setState(() {
        recordButtonText = "إيقاف";
        recordButtonColor = Colors.red;
      });
    } else {
      setState(() {
        recordButtonText = "تسجيل";
        recordButtonColor = AppConstants.orange;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
      recordList.length < 5 - AppConstants.newVoiceLink.length
          ? GFButton(
              color: recordButtonColor,
              textColor: AppConstants.grey,
              child: Text(recordButtonText, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                if (nowOk == false && isRecord && isPlay == false) {
                  nowOk = true;
                  _stopRecord();
                } else if (nowOk == false && isRecord == false && isPlay == false && recordList.length < 5) {
                  nowOk = true;
                  _startRecord();
                }
              })
          : SizedBox.shrink(),
      recordList.length == 0
          ? SizedBox(
              width: 200,
              child: Text(
                "تسجيل مذكرة صوتية",
                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            )
          : SizedBox.shrink(),
      recordList.length > 0 ? SizedBox(width: 10) : SizedBox.shrink(),
      recordList.length > 0
          ? GFButton(
              color: playButtonColor,
              textColor: AppConstants.grey,
              child: Text(playButtonText, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                if (nowOk == false && !isRecord && file.length > 0) {
                  nowOk = true;
                  _startStopPlay();
                }
              })
          : SizedBox.shrink(),
      recordList.length > 0 ? SizedBox(width: 10) : SizedBox.shrink(),
      recordList.length > 0 ? returnRecordList() : SizedBox.shrink(),
      recordList.length > 0 ? SizedBox(width: 10) : SizedBox.shrink(),
      recordList.length > 0
          ? GFButton(
              color: AppConstants.orange,
              textColor: AppConstants.grey,
              child: Text("حذف", style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                deleteSelectedAudio();
              })
          : SizedBox.shrink(),
    ]);
  }

  deleteSelectedAudio() async {
    if (!isRecord && isPlay && nowOk == false) {
      nowOk = true;
      _startStopPlay();
    }
    await getApplicationSupportDirectory().then((value) async {
      File fileToDelete = File(value.absolute.path + "/" + file + ".aac");
      await fileToDelete.delete().then((value) {
        if (recordList.length == 1) {
          setState(() {
            selectedRecord = "";
            playList = [];
            setState(() {
              AppConstants.playList = playList;
            });
            recordList = [];
            nowOk = false;
          });
        } else {
          setState(() {
            recordList.removeAt(int.parse(selectedRecord) - 1);
            playList.removeAt(int.parse(selectedRecord) - 1);
            setState(() {
              AppConstants.playList = playList;
            });
            file = playList[0];
            for (int i = 0; i < recordList.length; i++) {
              recordList[i][0] = (i + 1).toString();
            }
            selectedRecord = "1";
            nowOk = false;
          });
        }
      });
    });
  }

  DropdownButton returnRecordList() {
    return DropdownButton<String>(
      value: selectedRecord,
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
          if (!isRecord && isPlay) {
            nowOk = true;
            _startStopPlay();
          }
          selectedRecord = newValue;
          file = playList[int.parse(selectedRecord) - 1];
        });
      },
      items: recordList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value[0].toString(),
          child: Text(
            value[0].toString(),
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
