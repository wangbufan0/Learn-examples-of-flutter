
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>StackRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Route'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Text("Hello world",style: TextStyle(color: Colors.white)),
            ),
            Positioned(
              left: 18.0,
              child: Text('I am happy'),
            ),
            Positioned(
              top: 18.0,
              child: Text('No,you do not'),
            ),

          ],
        ),
      ),

    );

  }
}