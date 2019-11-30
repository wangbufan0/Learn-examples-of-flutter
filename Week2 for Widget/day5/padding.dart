
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaddingRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>PaddingRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding Route'),
      ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('Hello world!'),
          )
        ],
      ),
    ),
    );

  }
}