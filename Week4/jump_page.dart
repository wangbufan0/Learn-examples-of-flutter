import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_bative/bloc/counter_page.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_list_page.dart';
import 'package:flutter_to_bative/native_view.dart';

import 'bloc_me/count_page.dart';
import 'flutter_to_native.dart';

class JumpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jump Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Flutter to Native'),
              onPressed: () {
                FlutterToNativePage.launch(context, 'ss');
              },
            ),
            RaisedButton(
              child: Text('Bloc'),
              onPressed: () {
                CounterPage.launch(context);
              },
            ),
            RaisedButton(
              child: Text('Bloc_My'),
              onPressed: () {
                CountPage.launch(context);
              },
            ),
            RaisedButton(
              child: Text('bloc_list'),
              onPressed: () {
                PostListPage.launch(context);
              },
            ),
            RaisedButton(
              child: Text('NativeView'),
              onPressed: () {
                NativeViewPage.launch(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
