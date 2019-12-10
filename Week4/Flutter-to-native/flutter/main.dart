import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _counter = 0;

  ///
  ///BasicMessageChannel
  ///给系统消息通信
  ///
  static const messageChannel = const BasicMessageChannel(
      'samples.flutter.io/message', StandardMessageCodec());
  static const messageChannel2 = const BasicMessageChannel(
      'samples.flutter.io/message2', StandardMessageCodec());

  Future<String> sendMessage() async {
    String reply = await messageChannel.send('发送给Native的数据');
    print('reply:$reply');
    return reply;
  }

  void receiveMessage() {
    messageChannel2.setMessageHandler((message) async {
      print('message: $message');
      return '返回给Native端的数据';
    });
  }

  ///
  ///
  ///
  ///
  ///MethodChannel
  ///
  ///
  ///获得系统电量
  ///

  static const platform = const MethodChannel('samples.flutter.io/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: ${e.message}.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  ///
  /// EventChannel
  ///
  ///
  ///
  ///

  static const EventChannel _eventChannel=
      const EventChannel('samples.flutter.io/test');

  void _onEvent(Object event)=>print('返回的内容：$event');
  void _onError(Object error)=>print('返回的错误');


  @override
  void initState() {
    super.initState();
    receiveMessage();
    sendMessage();
    _eventChannel.receiveBroadcastStream()
          .listen(_onEvent,onError: _onError);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_batteryLevel),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryLevel,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
