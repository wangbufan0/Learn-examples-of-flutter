import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProgressRoute()));
  }

  @override
  State createState() {
    return _ProgressRouteState();
  }
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _progressValue = 0;
  ReceivePort receivePort = ReceivePort();

  static void ff(SendPort sendPort) async {
    double _progressValue = 0;
    while (_progressValue < 1.0) {
      sleep(Duration(milliseconds: 1000));
      _progressValue += 0.05;
      sendPort.send(_progressValue);
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });

    receivePort.listen((value) {
      setState(() {
        _progressValue = value;
      });
    });

    Isolate.spawn(ff, receivePort.sendPort);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Route'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
//            valueColor: ColorTween(begin: Colors.grey,end: Colors.blue)
//            .animate(_animationController),
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: _animationController.value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: _animationController.value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
          ),
          SizedBox(
            height: 10,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: _progressValue,
            ),
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .7,
            ),
          ),
        ],
      ),
    );
  }
}
