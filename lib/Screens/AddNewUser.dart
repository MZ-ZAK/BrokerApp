import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';

class Controller extends GetxController {}

class AddNewUser extends StatelessWidget {

  TextEditingController _newContactName = TextEditingController();
  TextEditingController _newContactMobile = TextEditingController();
  TextEditingController _newContactWork = TextEditingController();
  TextEditingController _newContactCar = TextEditingController();

  @override
  Widget build(context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Add new user"),),
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactName,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Name',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactMobile,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Mobile',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactWork,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Occupation',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        //alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: AppConstants.grey,
                        ),
                        //height: 50.0,
                        child: TextField(
                          controller: _newContactCar,
                          textAlign: TextAlign.justify,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            hintText: 'Enter Car brand',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: 20,
                              fontFamily: "Bell Gothic Light",
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  GFButton(
                    size: GFSize.LARGE,
                    //color: Color.fromRGBO(248, 187, 22, 1.0),
                    color: AppConstants.grey,
                    text: "Add",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Bell Gothic Light"),
                    onPressed: () async =>
                        await AppConstants().CheckInternet(context, () {
                      String translatedNumbers = "";
                      if (AppConstants().translateArabicNumToEng(
                              _newContactMobile.text) !=
                          "Wrong Data") {
                        translatedNumbers = AppConstants()
                            .translateArabicNumToEng(_newContactMobile.text);
                        //AppConstants().requestFunction(translatedNumbers);
                        debugPrint("User Finally Added");
                      }
                    }),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

/*
Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          //alignment: Alignment.centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                            color: AppConstants
                                                                .grey,
                                                          ),
                                                          //height: 50.0,
                                                          child: TextField(
                                                            controller:
                                                                _newContactName,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light"),
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            decoration:
                                                                InputDecoration(
                                                              alignLabelWithHint:
                                                                  true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Enter Name',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05),
                                                    Center(
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          //alignment: Alignment.centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                            color: AppConstants
                                                                .grey,
                                                          ),
                                                          //height: 50.0,
                                                          child: TextField(
                                                            controller:
                                                                _newContactMobile,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light"),
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            decoration:
                                                                InputDecoration(
                                                              alignLabelWithHint:
                                                                  true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Enter Mobile',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05),
                                                    Center(
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          //alignment: Alignment.centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                            color: AppConstants
                                                                .grey,
                                                          ),
                                                          //height: 50.0,
                                                          child: TextField(
                                                            controller:
                                                                _newContactWork,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light"),
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            decoration:
                                                                InputDecoration(
                                                              alignLabelWithHint:
                                                                  true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Enter Occupation',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05),
                                                    Center(
                                                      child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          //alignment: Alignment.centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                            color: AppConstants
                                                                .grey,
                                                          ),
                                                          //height: 50.0,
                                                          child: TextField(
                                                            controller:
                                                                _newContactCar,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light"),
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            decoration:
                                                                InputDecoration(
                                                              alignLabelWithHint:
                                                                  true,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Enter Car brand',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "Bell Gothic Light",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05),
                                                    GFButton(
                                                      size: GFSize.LARGE,
                                                      //color: Color.fromRGBO(248, 187, 22, 1.0),
                                                      color: AppConstants.grey,
                                                      text: "Add",
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Bell Gothic Light"),
                                                      onPressed: () async =>
                                                          await AppConstants()
                                                              .CheckInternet(
                                                                  context, () {
                                                        String
                                                            translatedNumbers =
                                                            "";
                                                        if (AppConstants()
                                                                .translateArabicNumToEng(
                                                                    _newContactMobile
                                                                        .text) !=
                                                            "Wrong Data") {
                                                          translatedNumbers =
                                                              AppConstants()
                                                                  .translateArabicNumToEng(
                                                                      _newContactMobile
                                                                          .text);
                                                          //AppConstants().requestFunction(translatedNumbers);
                                                          debugPrint(
                                                              "User Finally Added");
                                                        }
                                                      }),
                                                    )
                                                  ]
 */
