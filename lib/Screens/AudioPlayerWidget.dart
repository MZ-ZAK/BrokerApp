import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  String selectedAudio = "1";
  List<String> audioListString = [];
  bool playStopFunction = true;
  AudioWidget audioWidgetBuild;
  String urlPathOfAudio = "";
  Duration duration = Duration.zero;
  String playButtonText = "تشغيل";
  Color playButtonColor = AppConstants.orange;
  bool playNow = false;
  List<Audio> audios = <Audio>[];
  @override
  initState() {
    super.initState();
    _initSettings();
  }

  Future _initSettings() async {
    AppConstants.newVoiceLink = jsonDecode(AppConstants().selectedContact.VOICELINK);
    for (int i1 = 0; i1 < AppConstants.newVoiceLink.length; i1++) {
      debugPrint(AppConstants.newVoiceLink[i1].toString());
      audios.add(Audio.network(AppConstants.websiteURL + "AudioFiles/" + AppConstants().selectedContact.OWNERID.toString() + "/contact/" + AppConstants.newVoiceLink[i1].toString() + ".aac"));
      audioListString.add((i1 + 1).toString());
    }
    super.initState();
  }

  changePlayButtonSettings() async {
    if (playNow == false) {
      setState(() {
        playNow = true;
        urlPathOfAudio = audios[0].path;
        audioWidgetBuild = returnAudioNetwork();
        playButtonText = "إيقاف";
        playButtonColor = Colors.lightBlueAccent;
      });
      await new Future.delayed(const Duration(seconds: 1));
      playStopFunction = true;
    } else {
      setState(() {
        playNow = false;
        audioWidgetBuild = null;
        playButtonText = "تشغيل";
        playButtonColor = AppConstants.orange;
      });
      await new Future.delayed(const Duration(seconds: 1));
      playStopFunction = true;
    }
  }

  dropDownChangeSelection(String newV) async {
    playStopFunction = false;
    setState(() {
      playNow = false;
      audioWidgetBuild = null;
      playButtonText = "تشغيل";
      playButtonColor = AppConstants.orange;
      selectedAudio = newV;
      urlPathOfAudio = audios[int.parse(newV) - 1].path;
    });
    await new Future.delayed(const Duration(seconds: 1));
    audioWidgetBuild = returnAudioNetwork();
    playStopFunction = true;
    debugPrint("URL OF THE AUDIO IS: " + urlPathOfAudio);
  }

  AudioWidget returnAudioNetwork() {
    return AudioWidget.network(
      child: SizedBox.shrink(),
      url: urlPathOfAudio,
      play: playNow,
      loopMode: LoopMode.none,
      onFinished: () {
        changePlayButtonSettings();
      },
    );
  }

  deleteSelectedAudio() async
  {
    playStopFunction = false;
    if(audios.length > 1)
    {
      setState(() {
        playNow = false;
        audioWidgetBuild = null;
        playButtonText = "تشغيل";
        playButtonColor = AppConstants.orange;
        audios.removeAt(int.parse(selectedAudio)-1);
        AppConstants.newVoiceLink.removeAt(int.parse(selectedAudio)-1);
        audioListString.removeAt(int.parse(selectedAudio)-1);
        for(int i = 0; i < audioListString.length; i++)
        {
          audioListString[i] = (i+1).toString();
        }
        selectedAudio = "1";
        urlPathOfAudio = audios[0].path;
      });

      await new Future.delayed(const Duration(seconds: 1));
      audioWidgetBuild = returnAudioNetwork();
      playStopFunction = true;
    }
    else if(audios.length == 1)
    {
      setState(() {
        audios.removeAt(int.parse(selectedAudio)-1);
        AppConstants.newVoiceLink.removeAt(int.parse(selectedAudio)-1);
        playNow = false;
        audioWidgetBuild = null;
      });
    }
    debugPrint("URL OF THE AUDIO IS: " + AppConstants.newVoiceLink.toString());
  }

  DropdownButton returnRecordList() {
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
      onChanged: (String newValue) {
        dropDownChangeSelection(newValue);
      },
      items: audioListString.map<DropdownMenuItem<String>>((value) {
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

  @override
  Widget build(BuildContext context) {
    return AppConstants.newVoiceLink.length > 0
        ? Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
            audioWidgetBuild != null ? audioWidgetBuild : SizedBox.shrink(),
            GFButton(
                color: AppConstants.orange,
                textColor: AppConstants.grey,
                child: Text("حذف", style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                onPressed: () {
                  deleteSelectedAudio();
                }),
            SizedBox(width: 5),
            GFButton(
                color: playButtonColor,
                textColor: AppConstants.grey,
                child: Text(playButtonText, style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                onPressed: () {
                  if (playStopFunction == true) {
                    setState(() {
                      playStopFunction = false;
                      changePlayButtonSettings();
                    });
                  }
                }),
            SizedBox(width: 10),
            returnRecordList(),
            SizedBox(width: 10),
            SizedBox(
                width: 100,
                child: Text(
                  "عرض مذكرة \n صوتية سابقة",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                )),
          ])
        : SizedBox.shrink();
  }
}
