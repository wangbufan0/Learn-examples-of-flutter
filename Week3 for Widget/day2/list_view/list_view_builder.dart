

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewBuildRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.of(context)
        .push(
        MaterialPageRoute(
            builder: (context)=>ListViewBuildRoute()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Children'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemExtent: 50,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            title: Text('$index'),
            contentPadding: EdgeInsets.only(left: 100),
          );
        },
      ),
    );
  }
}