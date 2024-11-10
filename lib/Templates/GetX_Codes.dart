import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Step 1: Add "Get" before your MaterialApp, turning it into GetMaterialApp
void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 500)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: Home(), 2: TestingGetXNavigations()};
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.zoom,
      home: AnimatedSplash(
        imagePath: 'assets/Splash/BackSplash.png',
        home: Home(),
        customFunction: duringSplash,
        duration: 2500,
        type: AnimatedSplashType.BackgroundProcess,
        outputAndHome: op,
      ),)
  );
}

//Step 2: Create your business logic class and place all variables,
// methods and controllers inside it. You can make any variable
// observable using a simple ".obs".
class Controller extends GetxController {
  var count = 0.obs;

  //bool asd = GetUtils.IsEmail("asd");
  //String asd1 = GetPlatform.isAndroid.toString();
  //String asdtring = Get.height.toString();

  increment() => count++;
}

//Step 3: Create your View, use StatelessWidget and save some RAM,
// with Get you may no longer need to use StatefulWidget.
class Home extends StatelessWidget {
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final Controller c = Get.put(Controller());

  @override
  Widget build(context) => Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(
          child: RaisedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

class TestingGetXNavigations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hello Zekass")),
        body: ListView(children: [
          RaisedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other1())),
          RaisedButton(
              child: Text("Snack Bar View"),
              onPressed: () => Get.snackbar(
                  "Hello There, Did you like it?", "Snackbar loves you : )",
                  snackPosition: SnackPosition.BOTTOM)),
          RaisedButton(
              child: Text("Dialog"),
              onPressed: () => Get.defaultDialog(
                  title: "Simple Dialog", content: Text("Easy One"))),
          RaisedButton(
              child: Text("BottomSheet"),
              onPressed: () => Get.bottomSheet(ListView(
                  children: [Text("Hello1"), Text("Hello2"), Text("Hello3")]))),
        ]));
  }
}

class Other1 extends StatelessWidget {
  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("You Are Here : )")));
  }
}
