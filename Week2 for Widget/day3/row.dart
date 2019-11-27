

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowRoute extends StatefulWidget{

  static void launch(BuildContext context){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>RowRoute()
    ));
  }

  @override
  State createState() {
    return RowRouteState();
  }
}

class RowRouteState extends State<RowRoute>{




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Row Route'),
     ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hello world',),
              Text('i am happy')
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hello world'),
              Text('i am happy')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text('hello world'),
              Text('i am happy')
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Text('hello world',style: TextStyle(fontSize: 30.0),),
              Text('i am happy')
            ],
          )
        ],
      ),
    );
  }
}