import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckRoute()));
  }

  @override
  State createState() {
    return _CheckRouteState();
  }
}

class _CheckRouteState extends State<CheckRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('check route'),
      ),
      body: Column(
        children: <Widget>[
          Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            },
          ),
          Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
