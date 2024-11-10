import 'dart:convert';
import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madinaty_app/Constants/AppConstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPickerServer extends StatefulWidget {
  @override
  _PhotoPickerServerState createState() => _PhotoPickerServerState();
}

class _PhotoPickerServerState extends State<PhotoPickerServer> {
  List<String> _photoList = [];
  int currentIndex = 0;

  Future<void> _takePicture() async {
    final PickedFile imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }

    Directory directory = await getApplicationSupportDirectory();
    debugPrint("Diectory path is: " + directory.path);
    File file1 = File(imageFile.path);
    final checkPathExistence = await Directory(directory.path + "/tempPhotos/").exists();
    if (checkPathExistence) {
      try {
        await file1.rename(directory.path + "/tempPhotos/" + DateTime.now().millisecondsSinceEpoch.toString() + FileUtils.basename(imageFile.path));
        debugPrint("It Is THere!!!! And Copied");
      } catch (e) {
        await file1.copy(directory.path + DateTime.now().millisecondsSinceEpoch.toString() + FileUtils.basename(imageFile.path));
        await file1.delete();
      }
    } else {
      Directory(directory.path + "/tempPhotos/").create().then((Directory directoryOut) async {
        try {
          debugPrint(directoryOut.path);
          await file1.rename(directoryOut.path + DateTime.now().millisecondsSinceEpoch.toString() + FileUtils.basename(imageFile.path));
          debugPrint("It Is NOTNOTNOT THere!!!! And Copied");
        } catch (e) {
          await file1.copy(directoryOut.path + DateTime.now().millisecondsSinceEpoch.toString() + FileUtils.basename(imageFile.path));
          await file1.delete();
        }
      });
    }
    setState(() {
      _photoList.add(directory.path + "/tempPhotos/" + DateTime.now().millisecondsSinceEpoch.toString() + FileUtils.basename(imageFile.path));
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
    //clearTheRecordDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        jsonDecode(AppConstants().getSelectedUnitForEditing().photoLink).length > 0
                ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GFButton(
                    color: AppConstants.orange,
                    textColor: AppConstants.grey,
                    child: Text("أضافة", style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
                    onPressed: () {
                      _takePicture();
                    }),
                SizedBox(width: 100),
                SizedBox(
                  width: 100,
                  child: Text(
                    "أضافة صورة",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Bell Gothic Light"),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            )
                : SizedBox.shrink(),
          ],
        ),

        //Gallery
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
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppConstants.orange),
                      //value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
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
              child: Text("حذف الصورة", style: TextStyle(color: AppConstants.grey, fontSize: 20, fontFamily: "Bell Gothic Light"), textDirection: TextDirection.rtl, textAlign: TextAlign.right),
              onPressed: () {
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
              }),
        ])
            : SizedBox.shrink(),
      ],
    );
  }

  deleteFileAt(List<String> a, int b) async {
    await File(a[b]).delete();
  }
}
