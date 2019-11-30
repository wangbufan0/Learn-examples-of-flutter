
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecoratedBoxRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>DecoratedBoxRoute()
        )
    );
  }



  static Widget _redBox=DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DecoratedBox Route'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red,Colors.orange]),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2,2),
              blurRadius: 4
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80,vertical: 18),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );

  }
}