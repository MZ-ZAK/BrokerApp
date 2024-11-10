import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class PhotoPicker extends StatefulWidget {
  @override
  _PhotoPickerState createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  List<String> _photoList = [];
  List<String> shareList = [];
  List<dynamic> newPhotoLink = [];
  int currentIndexServer = 0;
  int currentIndex = 0;
  bool canTapDeletePhoto = true;
  bool canTapDeleteServerPhoto = true;
  bool shareButtonPressed = false;

  Future<int> clearTheShareDirectory() async {
    Directory directory = await getApplicationSupportDirectory();
    debugPrint(directory.path.toString());
    final checkPathExistence = await Directory(directory.path + "/shareTemp/").exists();
    if (checkPathExistence) {
      try {
        List file2 = new List();
        file2 = Directory(directory.path + "/shareTemp/").listSync();
        if (file2.length > 0) {
          for (int i1 = 0; i1 < file2.length; i1++) {
            debugPrint("Photo Temp Folder Cleared");
            await file2[i1].delete();
            if (i1 == file2.length - 1) {
              return 1;
            }
          }
        } else {
          return 1;
        }
      } catch (e) {
        debugPrint("shareTemp Folder Not Found");
        return 1;
      }
    } else {
      return 1;
    }
  }

  Future<int> createShareTemp() async {
    Directory directory = await getApplicationSupportDirectory();
    final checkPathExistence = await Directory(directory.path + "/shareTemp/").exists();
    shareList.clear();
    if (checkPathExistence) {
      try {
        debugPrint(newPhotoLink.toString());
        for (int st1 = 0; st1 < newPhotoLink.length; st1++) {
          var url = AppConstants.websiteURL + "AudioFiles/" + AppConstants().getcurrentUserData().OwnerId.toString() + "/unit/" + newPhotoLink[st1].toString();
          await get(url).then((value) {
            File newImage = new File(directory.path + "/shareTemp/" + "Type " + AppConstants().getSelectedUnitForEditing().unitType + " No. " + st1.toString() + ".jpg");
            shareList.add(directory.path + "/shareTemp/" + "Type " + AppConstants().getSelectedUnitForEditing().unitType + " No. " + st1.toString() + ".jpg");
            newImage.writeAsBytesSync(value.bodyBytes);
            debugPrint("It Is THere!!!! And Copied");
          });
          if (st1 == newPhotoLink.length - 1) {
            return 1;
          }
        }
      } catch (e) {
        debugPrint(e.toString());
        clearTheShareDirectory();
        return 0;
      }
    } else {
      Directory(directory.path + "/shareTemp/").create().then((Directory directoryOut) async {
        try {
          for (int st1 = 0; st1 < newPhotoLink.length; st1++) {
            var url = AppConstants.websiteURL + "AudioFiles/" + AppConstants().getcurrentUserData().OwnerId.toString() + "/unit/" + newPhotoLink[st1].toString();
            await get(url).then((value) {
              File newImage = new File(directory.path + "/shareTemp/" + "Type " + AppConstants().getSelectedUnitForEditing().unitType + " No. " + st1.toString() + ".jpg");
              shareList.add(directory.path + "/shareTemp/" + "Type " + AppConstants().getSelectedUnitForEditing().unitType + " No. " + st1.toString() + ".jpg");
              newImage.writeAsBytesSync(value.bodyBytes);
              debugPrint("It Is THere!!!! And Copied");
            });
            if (st1 == newPhotoLink.length - 1) {
              return 1;
            }
          }
        } catch (e) {
          debugPrint(e.toString());
          clearTheShareDirectory();
          return 0;
        }
      });
    }
  }

  Future<void> _takePicture() async {
    final PickedFile imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }

    String pickedFilePath = FileUtils.basename(imageFile.path);
    pickedFilePath = DateTime.now().millisecondsSinceEpoch.toString() + pickedFilePath.substring(pickedFilePath.length - 4);

    Directory directory = await getApplicationSupportDirectory();
    debugPrint("Diectory path is: " + directory.path);
    File file1 = File(imageFile.path);
    final checkPathExistence = await Directory(directory.path + "/tempPhotos/").exists();

    if (checkPathExistence) {
      try {
        await file1.rename(directory.path + "/tempPhotos/" + pickedFilePath);
        debugPrint("It Is THere!!!! And Copied");
      } catch (e) {
        await file1.copy(directory.path + pickedFilePath);
        await file1.delete();
      }
    } else {
      Directory(directory.path + "/tempPhotos/").create().then((Directory directoryOut) async {
        try {
          debugPrint(directoryOut.path);
          await file1.rename(directoryOut.path + pickedFilePath);
          debugPrint("It Is NOTNOTNOT THere!!!! And Copied");
        } catch (e) {
          await file1.copy(directoryOut.path + pickedFilePath);
          await file1.delete();
        }
      });
    }
    setState(() {
      _photoList.add(directory.path + "/tempPhotos/" + pickedFilePath);
      AppConstants.photoList = _photoList;
    });
    for (int i = 0; i < _photoList.length; i++) {
      debugPrint("URLs inside _photoList: " + _photoList[i]);
    }
  }

  clearTheRecordDirectory() async {
    Directory directory = await getApplicationSupportDirectory();
    final checkPathExistence = await Directory(directory.path + "/tempPhotos/").exists();
    if (checkPathExistence) {
      try {
        List file2 = new List();
        file2 = Directory(directory.path + "/tempPhotos/").listSync();
        for (int i1 = 0; i1 < file2.length; i1++) {
          debugPrint("Photo Temp Folder Cleared");
          await file2[i1].delete();
        }
      } catch (e) {
        debugPrint("Photo Temp Folder Not Found");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  Future _initSettings() async {
    newPhotoLink = jsonDecode(AppConstants().getSelectedUnitForEditing().photoLink);
    AppConstants.newPhotoLink = newPhotoLink;
    clearTheRecordDirectory();
    clearTheShareDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Show Server Image and Its Delete Button
        newPhotoLink.length > 0 && AppConstants().listenToConnectivity().keys.toList()[0] != ConnectivityResult.none
            ? Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Divider(
                  thickness: 4,
                  height: 10,
                  color: AppConstants.orange,
                ),
                Text(
                  "صور مسجلة سابقا للوحدة",
                  style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                Container(
                    color: AppConstants.grey,
                    width: 300,
                    height: 300,
                    child: PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: Image.network(
                            AppConstants.websiteURL + "AudioFiles/" + AppConstants().getcurrentUserData().OwnerId.toString() + "/unit/" + newPhotoLink[index].toString(),
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ).image,
                          //initialScale: PhotoViewComputedScale.contained * 0.8,
                          heroAttributes: PhotoViewHeroAttributes(tag: index),
                        );
                      },
                      itemCount: newPhotoLink.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            valueColor: AlwaysStoppedAnimation<Color>(AppConstants.orange),
                            //value: event == null ? 0 : (event.cumulativeBytesLoaded / event.expectedTotalBytes.).toDouble(),
                          ),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: AppConstants.grey,
                      ),
                      //pageController: widget.pageController,
                      loadFailedChild: Text(
                        "لا يوجد أتصال بالشبكة",
                        style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      onPageChanged: (int index) {
                        currentIndexServer = index;
                        debugPrint("Current Photo is: " + index.toString());
                      },
                    )),
                //Share Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GFButton(
                        color: AppConstants.orange,
                        textColor: AppConstants.grey,
                        child: Text("مشاركة", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                        onPressed: () async {
                          if (await AppConstants().checkRealInternet() == 1) {
                            setState(() {
                              shareButtonPressed = true;
                            });
                            int a = await clearTheShareDirectory();
                            if (a == 1) {
                              debugPrint("Creating Share Temp Folder Now");
                              int a1 = await createShareTemp();
                              if (a1 == 1) {
                                debugPrint("Should Share NOW !");
                                Share.shareFiles(shareList);
                                setState(() {
                                  shareButtonPressed = false;
                                });
                              }
                              else
                                {
                                  setState(() {
                                    shareButtonPressed = false;
                                  });
                                }
                            }
                            else
                              {
                                setState(() {
                                  shareButtonPressed = false;
                                });
                              }
                          } else {
                            setState(() {
                              shareButtonPressed = false;
                            });
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: "لا يوجد اتصال بالشبكة",
                                content: Text("حاول مرة اخري...", textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: TextStyle(color: AppConstants.grey, fontSize: 15.0.sp, fontFamily: "Bell Gothic Light")),
                                cancel: GFButton(
                                    size: GFSize.LARGE,
                                    color: AppConstants.orange,
                                    text: "الغاء",
                                    textStyle: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"),
                                    onPressed: () {
                                      Get.back();
                                    }));
                          }
                        }),
                    SizedBox(width: 10.0.w),
                    GFButton(
                        color: AppConstants.orange,
                        textColor: AppConstants.grey,
                        child: Text("حذف", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                        onPressed: () async {
                          if (canTapDeleteServerPhoto) {
                            canTapDeleteServerPhoto = false;
                            newPhotoLink.removeAt(currentIndexServer);
                            AppConstants.newPhotoLink = newPhotoLink;
                            await new Future.delayed(const Duration(milliseconds: 500), () async {
                              setState(() {
                                if (currentIndexServer == 0) {
                                  currentIndexServer = 0;
                                  canTapDeleteServerPhoto = true;
                                } else {
                                  currentIndexServer = currentIndexServer - 1;
                                  canTapDeleteServerPhoto = true;
                                }
                              });
                            });
                          }
                        }),
                  ],
                ),
                shareButtonPressed == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: AppConstants.orange,
                          )
                        ],
                      )
                    : SizedBox.shrink(),

                Divider(
                  thickness: 4,
                  height: 10,
                  color: AppConstants.orange,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
              ])
            : SizedBox.shrink(),

        //Gallery
        _photoList.length > 0
            ? Text(
                "عرض الصور المضافة الان للوحدة",
                style: TextStyle(color: AppConstants.orange, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              )
            : SizedBox.shrink(),
        _photoList.length > 0
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    color: AppConstants.grey,
                    width: 300,
                    height: 300,
                    child: PhotoViewGallery.builder(
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: Image.file(
                            File(_photoList[index]),
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ).image,
                          //initialScale: PhotoViewComputedScale.contained * 0.8,
                          heroAttributes: PhotoViewHeroAttributes(tag: index),
                        );
                      },
                      itemCount: _photoList.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                          ),
                        ),
                      ),
                      backgroundDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: AppConstants.grey,
                      ),
                      //pageController: widget.pageController,
                      onPageChanged: (int index) {
                        currentIndex = index;
                        debugPrint("Current Photo is: " + index.toString());
                      },
                    ))
              ])
            : SizedBox.shrink(),

        //Delete photo
        _photoList.length > 0
            ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                GFButton(
                    color: AppConstants.orange,
                    textColor: AppConstants.grey,
                    child: Text("حذف الصورة", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                    onPressed: () async {
                      if (canTapDeletePhoto) {
                        canTapDeletePhoto = false;
                        deleteFileAt(_photoList, currentIndex);
                        setState(() {
                          _photoList.removeAt(currentIndex);
                          AppConstants.photoList = _photoList;
                          if (currentIndex == 0) {
                            currentIndex = 0;
                          } else {
                            currentIndex = currentIndex - 1;
                          }
                        });
                        await new Future.delayed(const Duration(milliseconds: 500), () async {
                          canTapDeletePhoto = true;
                        });
                      }
                    }),
              ])
            : SizedBox.shrink(),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _photoList.length < 6 - newPhotoLink.length
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFButton(
                          color: AppConstants.orange,
                          textColor: AppConstants.grey,
                          child: Text("أضافة", style: TextStyle(color: AppConstants.grey, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                          onPressed: () {
                            _takePicture();
                          }),
                      SizedBox(width: 100),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "أضافة صورة",
                          style: TextStyle(color: Colors.white, fontSize: 18.0.sp, fontFamily: "Bell Gothic Light"),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
        _photoList.length < 6 - newPhotoLink.length
            ? Divider(
                thickness: 4,
                height: 70,
                color: AppConstants.orange,
              )
            : SizedBox.shrink(),
      ],
    );
  }

  deleteFileAt(List<String> a, int b) async {
    await File(a[b]).delete();
  }
}
