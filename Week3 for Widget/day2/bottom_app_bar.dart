

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
          ),
          SizedBox(),
          IconButton(
            icon: Icon(Icons.business),
          ),
        ],
      ),
    );
  }
}
