
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlignRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>AlignRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Route'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.blue[50],
            child: Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          )
        ],
      ),
    );

  }
}