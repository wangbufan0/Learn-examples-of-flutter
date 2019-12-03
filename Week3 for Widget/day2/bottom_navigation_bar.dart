

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends  StatefulWidget{

  @override
  State createState() {
    return _MyBottomNavigationBarState();
  }
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>{

  int _selectedIndex=1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.business),title: Text('Business')),
        BottomNavigationBarItem(icon: Icon(Icons.school),title: Text('School')),
      ],
      currentIndex: _selectedIndex,
      fixedColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}