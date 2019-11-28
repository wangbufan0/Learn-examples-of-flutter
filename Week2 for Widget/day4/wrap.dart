
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>WrapRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap Route'),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 4,
            alignment: WrapAlignment.center,

            children: <Widget>[
              new Chip(
                avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                label: new Text('Hamilton'),
              ),
              new Chip(
                avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                label: new Text('Lafayette'),
              ),
              new Chip(
                avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                label: new Text('Mulligan'),
              ),
              new Chip(
                avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                label: new Text('Laurens'),
              ),
            ],
          ),
        ],
      ),
    );

  }
}