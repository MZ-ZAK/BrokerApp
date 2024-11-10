import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class PlayerRecorderUnitWidget extends StatefulWidget {
  @override
  _PlayerRecorderUnitWidgetState createState() => _PlayerRecorderUnitWidgetState();
}

class _PlayerRecorderUnitWidgetState extends State<PlayerRecorderUnitWidget> {
  //Player
  String selectedAudio = "1";
  int selectedItem = 0;
  List<String> audioListString = [];
  bool playStopFunction = true;
  AudioWidget audioWidgetBuild;
  String urlPathOfAudio = "";
  Duration duration = Duration.zero;
  String playButtonTextPlay = "تشغيل";
  Color playButtonColorPlay = AppConstants.orange;
  bool playNow = false;
  List<Audio> audios = <Audio>[];
  int loadingTime = 2;

  //Recorder
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

  String playButtonTextRec = "تشغيل";
  Color playButtonColorRec = AppConstants.orange;

  List<dynamic> getAll;
  List<List<dynamic>> tempList = [];
  List<List<dynamic>> recordList = [];
  List<String> playList = [];
  String selectedRecord = "";

  @override
  initState() {
    clearTheRecordDirectory();
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  @override
  void dispose() {
    clearTheRecordDirectoryDispose();
    super.dispose();
  }

  Future _initSettings() async {
    //Player
    AppConstants.newVoiceLink = [];
    if (AppConstants().selectedUnitForEditing.voiceLink != "" && AppConstants().selectedUnitForEditing.voiceLink != "[]") {
      AppConstants.newVoiceLink = jsonDecode(AppConstants().selectedUnitForEditing.voiceLink);
      for (int i1 = 0; i1 < AppConstants.newVoiceLink.length; i1++) {
        debugPrint(AppConstants.newVoiceLink[i1].toString());
        audios.add(Audio.network(AppConstants.websiteURL + "AudioFiles/" + AppConstants().selectedUnitForEditing.ownerID.toString() + "/unit/" + AppConstants.newVoiceLink[i1].toString() + ".aac"));
        //audioListString.add((i1 + 1).toString());
        String s = DateTime.fromMillisecondsSinceEpoch(AppConstants.newVoiceLink[i1]).toString();
        audioListString.add((i1 + 1).toString() + "-(" + s.substring(2, s.length - 7) + ")");
        if (i1 == 0) {
          selectedAudio = audioListString[0];
          selectedItem = 0;
        }
      }
      urlPathOfAudio = audios[0].path;
    }
    //Rec
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

  //Play Functions
  changePlayButtonSettingsPlay() async {
    if (AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none) {
      setState(() {
        playButtonTextPlay = "تحميل..";
        playButtonColorPlay = Colors.green;
      });
      if (await AppConstants().checkRealInternet() == 1) {
        if (playNow == false) {
          setState(() {
            playNow = true;
            urlPathOfAudio = audios[selectedItem].path;
            playButtonTextPlay = "إيقاف";
            playButtonColorPlay = Colors.lightBlueAccent;
            audioWidgetBuild = returnAudioNetworkPlay();
          });
          await new Future.delayed(const Duration(seconds: 1));
          playStopFunction = true;
        } else {
          setState(() {
            playNow = false;
            audioWidgetBuild = null;
            playButtonTextPlay = "تشغيل";
            playButtonColorPlay = AppConstants.orange;
          });
          await new Future.delayed(const Duration(seconds: 1));
          playStopFunction = true;
        }
      } else {
        debugPrint("NO RETURN");
        Get.defaultDialog(
            barrierDismissible: false,
            title: "يوجد خطأ بالأتصال بشبكة الأنترنت",
            content: GFButton(
                onPressed: () {
                  if (Get.isDialogOpen) {
                    Navigator.of(context).pop();
                  }
                  setState(() {
                    playStopFunction = true;
                    playButtonTextPlay = "تشغيل";
                    playButtonColorPlay = AppConstants.orange;
                  });
                },
                text: "حاول مرة أخري"));
      }
    } else {
      setState(() {
        playStopFunction = true;
      });
    }
  }

  dropDownChangeSelectionPlay(String newV) async {
    playStopFunction = true;
    //playButtonTextPlay = "تشغيل";
    //playButtonColorPlay = AppConstants.orange;
    playButtonTextPlay = "تحميل..";
    playButtonColorPlay = Colors.green;
    bool a = false;
    for (int i = 0; i < audioListString.length; i++) {
      if (newV == audioListString[i]) {
        selectedItem = i;
        a = true;
        break;
      }
    }
    if (a) {
      if (AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none) {
        setState(() {
          playButtonTextPlay = "تحميل..";
          playButtonColorPlay = Colors.green;
        });
        if (await AppConstants().checkRealInternet() == 1) {
          playStopFunction = false;
          setState(() {
            playNow = false;
            audioWidgetBuild = null;
            playButtonTextPlay = "تحميل..";
            playButtonColorPlay = Colors.green;
            selectedAudio = newV;
            urlPathOfAudio = audios[selectedItem].path;
          });
          await new Future.delayed(Duration(seconds: 1));
          audioWidgetBuild = returnAudioNetworkPlay();
          await new Future.delayed(Duration(seconds: loadingTime));
          setState(() {
            playButtonTextPlay = "تشغيل";
            playButtonColorPlay = AppConstants.orange;
            playStopFunction = true;
            debugPrint("URL OF THE AUDIO IS: " + urlPathOfAudio);
          });
        } else {
          setState(() {
            playStopFunction = true;
            playButtonTextPlay = "تشغيل";
            playButtonColorPlay = AppConstants.orange;
          });
        }
      }
    }
  }

  AudioWidget returnAudioNetworkPlay() {
    return AudioWidget.file(
      child: SizedBox.shrink(),
      path: urlPathOfAudio,
      play: playNow,
      loopMode: LoopMode.none,
      onFinished: () {
        playStopFunction = false;
        changePlayButtonSettingsPlay();
      },
    );
  }

  deleteSelectedAudioPlay() async {
    if (AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none) {
      playStopFunction = false;
      if (await AppConstants().checkRealInternet() == 1) {
        if (audios.length > 1) {
          setState(() {
            playNow = false;
            audioWidgetBuild = null;
            playButtonTextPlay = "تحميل..";
            playButtonColorPlay = Colors.green;
            audios.removeAt(selectedItem);
            AppConstants.newVoiceLink.removeAt(selectedItem);
            audioListString.removeAt(selectedItem);
            for (int i = 0; i < audioListString.length; i++) {
              audioListString[i] = (i + 1).toString() + audioListString[i].substring(1);
            }
            selectedAudio = audioListString[0];
            urlPathOfAudio = audios[0].path;
            selectedItem = 0;
          });
          await new Future.delayed(Duration(seconds: 1));
          setState(() {
            audioWidgetBuild = returnAudioNetworkPlay();
          });
          await new Future.delayed(Duration(seconds: loadingTime));
          setState(() {
            //audioWidgetBuild = returnAudioNetworkPlay();
            playButtonTextPlay = "تشغيل";
            playButtonColorPlay = AppConstants.orange;
            playStopFunction = true;
          });
        } else if (audios.length == 1) {
          setState(() {
            audios.removeAt(selectedItem);
            AppConstants.newVoiceLink.removeAt(selectedItem);
            playNow = false;
            audioWidgetBuild = null;
          });
        }
        debugPrint("URL OF THE AUDIO IS: " + AppConstants.newVoiceLink.toString());
      }
    } else {
      setState(() {
        playStopFunction = true;
      });
    }
  }

  DropdownButton returnRecordListPlay() {
    return DropdownButton<String>(
      value: selectedAudio,
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
      onChanged: (String newValue) async {
        if (selectedAudio != newValue) {
          setState(() {
            playButtonTextPlay = "تحميل..";
            playButtonColorPlay = Colors.green;
          });
        if (await AppConstants().checkRealInternet() == 1) {
            dropDownChangeSelectionPlay(newValue);
          }
        }
      },
      items: audioListString.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: AppConstants.orange, fontFamily: AppConstants.BellGothisLight, fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  //Rec Functions
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
    updateRecordListRecord();
  }
  clearTheRecordDirectoryDispose() async {
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
  }

  Future<bool> updateRecordListRecord() async {
    Directory directory = await getApplicationSupportDirectory();
    if (await Directory(directory.path + "/temp/").exists()) {
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
      setState(() {
        selectedRecord = selectedRecord;
        recordList = recordList;
      });
      nowOk = false;
      return true;
    } else {
      nowOk = false;
      return true;
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      recordPosition = event['currentTime'];
      changeRecordButtonSettingsRecord();
    }
    if (event['code'] == 'playing') {
      playPosition = event['currentTime'];
      isPlay = true;
      changePlayButtonSettingsRecord();
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      playPosition = 0.0;
      isPlay = false;
      changePlayButtonSettingsRecord();
    }
  }

  Future _startRecord() async {
    AppConstants.isRecord = true;
    if (playNow == true) {
      changePlayButtonSettingsPlay();
    }
    isRecord = true;
    AppConstants.isRecord = true;
    changeRecordButtonSettingsRecord();
    try {
      DateTime time = new DateTime.now();
      fileURL = "";
      file = time.millisecondsSinceEpoch.toString();
      final String result = await audioModule.startRecord(file);
      isRecord = true;
      AppConstants.isRecord = true;
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
      if (await updateRecordListRecord() == true) {
        isRecord = false;
        AppConstants.isRecord = false;
        fileURL = file;
        changeRecordButtonSettingsRecord();
        file = "temp/$file";
        nowOk = false;
      }
    } catch (e) {
      isRecord = false;
      AppConstants.isRecord = false;
      changeRecordButtonSettingsRecord();
      updateRecordListRecord();
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
      setState(() {
        isPlay = false;
        playButtonTextRec = "تشغيل";
        playButtonColorRec = AppConstants.orange;
        //changePlayButtonSettingsRecord();
      });
      await new Future.delayed(Duration(milliseconds: 300));
      nowOk = false;
    } else {
      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
      setState(() {
        isPlay = true;
        playButtonTextRec = "إيقاف";
        playButtonColorRec = Colors.lightBlueAccent;
        //changePlayButtonSettingsRecord();
      });
      await new Future.delayed(Duration(milliseconds: 300));
      nowOk = false;
    }
  }

  changePlayButtonSettingsRecord() {
    if (isPlay) {
      setState(() {
        playButtonTextRec = "إيقاف";
        playButtonColorRec = Colors.lightBlueAccent;
      });
    } else {
      setState(() {
        playButtonTextRec = "تشغيل";
        playButtonColorRec = AppConstants.orange;
      });
    }
  }

  changeRecordButtonSettingsRecord() {
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

  deleteSelectedAudioRecord() async {
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

  DropdownButton returnRecordListRecord() {
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
        if (selectedRecord != newValue) {
          setState(() {
            if (!isRecord && isPlay) {
              nowOk = true;
              _startStopPlay();
            }
            selectedRecord = newValue;
            file = playList[int.parse(selectedRecord) - 1];
          });
        }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Player
        AppConstants.newVoiceLink.length > 0 && AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "عرض مذكرة صوتية سابقة",
            style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          )
        ])
            : SizedBox.shrink(),
        AppConstants.newVoiceLink.length > 0 && AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          audioWidgetBuild != null ? audioWidgetBuild : SizedBox.shrink(),
          GFButton(
              color: AppConstants.orange,
              textColor: AppConstants.grey,
              child: Text("حذف", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                deleteSelectedAudioPlay();
              }),
          SizedBox(width: 5.0.w),
          GFButton(
              color: playButtonColorPlay,
              textColor: AppConstants.grey,
              child: Text(playButtonTextPlay, style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                if (playStopFunction == true) {
                  setState(() {
                    playStopFunction = false;
                    changePlayButtonSettingsPlay();
                  });
                }
              })
        ])
            : SizedBox.shrink(),
        AppConstants.newVoiceLink.length > 0 && AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [returnRecordListPlay()])
            : SizedBox.shrink(),
        SizedBox(height: 10),
        //Rec
        AppConstants.newVoiceLink.length < 5
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "تسجيل مذكرة صوتية",
            style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          )
        ])
            : SizedBox.shrink(),
        recordList.length <= 5 - AppConstants.newVoiceLink.length
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          recordList.length < 5 - AppConstants.newVoiceLink.length
              ? GFButton(
              color: recordButtonColor,
              textColor: AppConstants.grey,
              child: Text(recordButtonText, style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
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
          recordList.length > 0 ? SizedBox(width: 2.0.w) : SizedBox.shrink(),
          recordList.length > 0
              ? GFButton(
              color: playButtonColorRec,
              textColor: AppConstants.grey,
              child: Text(playButtonTextRec, style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                if (nowOk == false && !isRecord && file.length > 0) {
                  nowOk = true;
                  _startStopPlay();
                }
              })
              : SizedBox.shrink(),
          recordList.length > 0 ? SizedBox(width: 4.0.w) : SizedBox.shrink(),
          recordList.length > 0 ? returnRecordListRecord() : SizedBox.shrink(),
          recordList.length > 0 ? SizedBox(width: 4.0.w) : SizedBox.shrink(),
          recordList.length > 0
              ? GFButton(
              color: AppConstants.orange,
              textColor: AppConstants.grey,
              child: Text("حذف", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
                deleteSelectedAudioRecord();
              })
              : SizedBox.shrink(),
        ])
            : SizedBox.shrink(),
      ],
    );
  }
}
