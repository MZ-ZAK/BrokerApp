import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main() => runApp(ClassVariables(anyVarName:"Allah"));
void main() => runApp(
    ClassVariables(
        anyVarName2: new Text("Thanks God",style: TextStyle(fontSize: 36),
            textDirection: TextDirection.ltr)
    )
);

class ClassVariables extends StatelessWidget {
  //Declare the variable name
  final String anyVarName1;

  final Widget anyVarName2;

  //assign this variable to the class
  ClassVariables({this.anyVarName1,this.anyVarName2});
  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text(anyVarName1, style: TextStyle(fontSize: 36),textDirection: TextDirection.ltr)
      child: anyVarName2
    );
  }
}


//LinearProgressIndicator()
//CircularProgressIndicator()