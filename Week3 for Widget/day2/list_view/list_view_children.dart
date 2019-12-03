

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewChildrenRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.of(context)
        .push(
        MaterialPageRoute(
            builder: (context)=>ListViewChildrenRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Children'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          const Text('I\'m dedicating every day to you'),
          const Text('Domestic life was never quite my style'),
          const Text('When you smile, you knock me out, I fall apart'),
          const Text('And I thought I was so smart'),
        ],
      ),
    );
  }
}