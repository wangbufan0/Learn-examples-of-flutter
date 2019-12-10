import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_bative/flutter_to_native.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timerPeriod;
  var textStyle;
  int count = 3;

  @override
  void initState() {
    super.initState();
    count = 3;
    textStyle = TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    _timerPeriod = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (count == 0) {
        _timerPeriod.cancel();
      } else
        count--;

      setState(() {});
    });
  }

  void _goMain() {
    //  FlutterToNativePage.launch(context, 'Flutter To Native');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FlutterToNativePage(
              title: '  ',
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Image(
            image: AssetImage('images/girl.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 30,
          right: 30,
          child: OutlineButton(
            child: Text(
              count != 0 ? '$count S后点击' : '进入',
              style: textStyle,
            ),
            onPressed: count != 0 ? null : () => _goMain(),
          ),
        )
      ],
    ));
  }
}
