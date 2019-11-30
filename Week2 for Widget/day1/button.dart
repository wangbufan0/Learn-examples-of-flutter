

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context)=>ButtonRoute._()
      )
    );
  }
  ButtonRoute._();

  void _onPressed(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Route') ,
      ),
      body:Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('RaiseButton'),
              onPressed: _onPressed,
            ),
            FlatButton(
              child: Text('FlatButton'),
              onPressed: _onPressed,
            ),
            OutlineButton(
              child: Text('OutlineButton'),
              onPressed: _onPressed,
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: _onPressed,
            ),
            RaisedButton.icon(
                onPressed: _onPressed,
                icon: Icon(Icons.send),
                label: Text('发送')
            ),
            FlatButton.icon(
              icon: Icon(Icons.add),
              label: Text('添加'),
              onPressed: _onPressed,
            ),
            OutlineButton.icon(
              icon: Icon(Icons.info),
              label: Text('详情'),
              onPressed: _onPressed,
            ),
            RaisedButton(
              child: Text('自定义'),
              onPressed: _onPressed,
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      )

    );
  }
}