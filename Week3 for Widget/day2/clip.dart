

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClipTestRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context)=>ClipTestRoute()
    ));
  }


  @override
  Widget build(BuildContext context) {

    Widget imageGirl= Image.asset('images/girl.jpg',
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Clip Text Route'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            imageGirl,
            ClipOval(child: imageGirl,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageGirl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: imageGirl,
                ),
                Text('hello world',style: TextStyle(color: Colors.red),)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5,
                    child: imageGirl,
                  ),
                ),
                Text('hello world',style: TextStyle(color: Colors.red),)
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red
              ),
              child: ClipRect(
                clipper: MyClipper(),
                child: imageGirl
                ,
              ),
            )
          ],
        ),
      ),
    );

  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10, 15, 60, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}