import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(
        MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NavigationPage()),
    );

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  Object text_reciver;
  void goToSecondPage ()
  async {
    text_reciver = await Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) {
      return SecondScreen(passedString: "Hi From First Page");
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Column(
          children: <Widget>[
      Container(
      alignment: Alignment.topLeft,
          child: Text("$text_reciver",style: TextStyle(decoration: TextDecoration.underline),textDirection: TextDirection.ltr,)
      ),
          RaisedButton(onPressed:goToSecondPage)
          ],
      ),
    );
  }
}
class SecondScreen extends StatefulWidget {
  final String passedString;
  SecondScreen({this.passedString});
  @override
  _SecondScreenState createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  void goBack()
  {
     Navigator.pop(context,"Hello From Second Page");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              child: Text(widget.passedString,style: TextStyle(decoration: TextDecoration.underline),textDirection: TextDirection.ltr,),
          ),
        RaisedButton(onPressed: goBack)],
      ),
    );
  }
}


