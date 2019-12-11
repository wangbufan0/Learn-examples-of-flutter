import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class StreamMainPage extends StatelessWidget {
  // ignore: close_sinks
  final StreamController<int> _streamController = StreamController();
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Text('0')
                    : Text(snapshot.data.toString());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _streamController.sink.add(++_count);
        },
      ),
    );
  }
}
