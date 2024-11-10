import 'package:flutter/material.dart';
import 'package:madinaty_app/Screens/MyConnectivity.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StateFulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  final MyConnectivity myConnectivity;

  const StateFulWrapper({@required this.onInit, @required this.child, @required this.myConnectivity});
  @override
  _StateFulWrapperState createState() => _StateFulWrapperState();
}

class _StateFulWrapperState extends State<StateFulWrapper> {
  @override
  void initState() {
  if(widget.onInit != null) {
    widget.onInit();
  }
  super.initState();
  }
  @override
  void dispose() {
    widget.myConnectivity.disposeStream();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return widget.child;
}
}