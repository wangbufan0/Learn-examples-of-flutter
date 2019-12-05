import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WillPopScopeTestRoute()));
  }

  @override
  State createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WillPopScope Route'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text('1s点两次退出'),
        ),
      ),
    );
  }
}
