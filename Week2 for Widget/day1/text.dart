import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello world',
            textAlign: TextAlign.left,
          ),
          Text(
            'Hello World I\'m a boy. ' * 4,
            //maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            'Hello world',
            textScaleFactor: 1.5,
          ),
          Text(
            'Hello world',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: 'Courier',
                background: Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Home:'),
              TextSpan(
                text: 'http://wangbufan.cn',
                style: TextStyle(
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Toast.show(
                      'onpress',
                      context,
                    );
                  },
              )
            ],
          )),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('hello world'),
                Text('I\'m wangbufan'),
                Text(
                  'I\'m 20s',
                  style: TextStyle(inherit: false, color: Colors.green),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
