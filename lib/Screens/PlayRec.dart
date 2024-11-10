import 'dart:io';

import 'package:flutter/material.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayRec extends StatefulWidget {
  @override
  _PlayRecState createState() => new _PlayRecState();
}

class _PlayRecState extends State<PlayRec> {
  //D:\flutterSDK\flutter\.pub-cache\hosted\pub.dartlang.org\medcorder_audio-0.0.6\android\src\main\java\co\medcorder\medcorderaudio
  MedcorderAudio audioModule = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  String fileURL = "";

  @override
  initState() {
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  Future _initSettings() async {
    var status = await Permission.microphone.status;
    debugPrint(status.toString());
    if(status.isUndetermined)
      {
        Map<Permission, PermissionStatus> statuses = await [Permission.microphone].request();

      }
    else if (status.isGranted) {
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

  Future _startRecord() async {
    Directory directory = await getApplicationSupportDirectory();
    debugPrint(directory.path);

    try {
      debugPrint("File Url Is: " + file);
      if(file != "")
        {
          fileURL = file;
          try {
            Directory directory = await getApplicationSupportDirectory();
            File file1 = File(directory.path + "/" + fileURL + ".aac");
            await file1.delete();
          } catch (e) {
            debugPrint("Can't delete the file");
          }
        }
      DateTime time = new DateTime.now();
      setState(() {
        file = time.millisecondsSinceEpoch.toString();
      });
      final String result = await audioModule.startRecord(file);
      isRecord = true;
      //print('startRecord: ' + result);
    } catch (e) {
      file = "";
     // print('startRecord: fail');
    }
  }

  Future _stopRecord() async {
    try {
      final String result = await audioModule.stopRecord();
     // print('stopRecord: ' + result);
      setState(() {
        isRecord = false;
      });
    } catch (e) {
      //print('stopRecord: fail');
      setState(() {
        isRecord = false;
      });
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
      isPlay = false;
    } else {
      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      setState(() {
        recordPower = (60.0 - power.abs().floor()).abs();
        recordPosition = event['currentTime'];
      });
    }
    if (event['code'] == 'playing') {
      String url = event['url'];
      debugPrint(url);
      setState(() {
        playPosition = event['currentTime'];
        isPlay = true;
      });
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      setState(() {
        playPosition = 0.0;
        isPlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Audio example app'),
        ),
        body: new Center(
          child: canRecord
              ? new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new InkWell(
                child: new Container(
                  alignment: FractionalOffset.center,
                  child: new Text(isRecord ? 'Stop' : 'Record'),
                  height: 40.0,
                  width: 200.0,
                  color: Colors.blue,
                ),
                onTap: () {
                  if (isRecord) {
                    _stopRecord();
                  } else {
                    _startRecord();
                  }
                },
              ),
              new Text('recording: ' + recordPosition.toString()),
              new Text('power: ' + recordPower.toString()),
              new InkWell(
                child: new Container(
                  margin: new EdgeInsets.only(top: 40.0),
                  alignment: FractionalOffset.center,
                  child: new Text(isPlay ? 'Stop' : 'Play'),
                  height: 40.0,
                  width: 200.0,
                  color: Colors.blue,
                ),
                onTap: () {
                  if (!isRecord && file.length > 0) {
                    _startStopPlay();
                  }
                },
              ),
              new Text('playing: ' + playPosition.toString()),
            ],
          )
              : new Text(
            'Microphone Access Disabled.\nYou can enable access in Settings',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}