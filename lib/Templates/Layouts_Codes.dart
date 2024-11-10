import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(debugShowCheckedModeBanner: false, home: layOutsCodes()),
    );

/*
Center
Container
Row
Column
Expanded has flex (ratio)
ListView widget in a list (can has ListTile(title,subtitle,leading icon))
Stack
 */
class layOutsCodes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("First Page"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: Container(
                    padding: EdgeInsets.all(20),
                    //alignment: Alignment.topLeft,
                    width: 150,
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                          "Hello from Container inside a Center",style: TextStyle(),textAlign: TextAlign.center,),
                    ))),
            SizedBox(width: 10,),
            Center(
                child: Container(
                    padding: EdgeInsets.all(20),
                    //alignment: Alignment.topLeft,
                    width: 150,
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Hello from Container inside a Center",style: TextStyle(),textAlign: TextAlign.center,),
                    ))),

          ],
        ));
  }
}
