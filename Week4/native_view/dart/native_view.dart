import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeViewPage extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NativeViewPage()));
  }

  @override
  State createState() => _NativeViewPageState();
}

class _NativeViewPageState extends State<NativeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native View'),
      ),
      body: Center(
        child: AndroidView(
          viewType: 'plugins.nightfarmer.top/myview',
          creationParams: {"myContent": "参数传值"},
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: onMyViewCreated,
        ),
      ),
    );
  }
  MethodChannel _channel;

  void onMyViewCreated(int id) {
    _channel = new MethodChannel('plugins.nightfarmer.top/myview_$id');
    setMyViewText('sss');
  }

  Future<void> setMyViewText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
}




