import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:get/get.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:madinaty_app/DataBase/DataProvider.dart';
import 'package:sizer/sizer_util.dart';

import 'Screens/LoginPage.dart';

//flutter pub get
// flutter pub run flutter_launcher_icons:main -f <your config file name here>
// flutter build appbundle --target-platform android-arm,android-arm64,android-x64
//flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
//AE:FD:EA:F6:21:6B
//934d7fb319d2bfcc  Moh
//acfce6a3007f2944 Kar
//dcd23e8c81dcf1b6 alaa adel

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Function duringSplash = () {
    //FlutterStatusbarManager.setHidden(true);
    //dataBaseProvider.removeDatabase();
    DataBaseProvider dataBaseProvider = DataBaseProvider.db;
    //dataBaseProvider.removeDatabase();
    dataBaseProvider.initializeDatabase();

    AppConstants().init();
    AppConstants().initPlatformState();
    return 1;
  };

  Map<int, Widget> op = {1: LoginPage(), 2: LoginPage()};
  runApp(LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
    return OrientationBuilder(
        //return OrientationBuilder
        builder: (context, orientation) {
      //initialize SizerUtil()
      SizerUtil().init(constraints, orientation);
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          home: AnimatedSplash(
            imagePath: 'assets/Splash/BackSplash.png',
            home: LoginPage(),
            customFunction: duringSplash,
            duration: 2500,
            type: AnimatedSplashType.BackgroundProcess,
            outputAndHome: op,
          ));
    });
  }));
}
