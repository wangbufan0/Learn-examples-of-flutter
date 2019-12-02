
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizeBoxRoute extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>SizeBoxRoute()
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
        title: Text('Box Route'),
        actions: <Widget>[
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50
            ),
            child: _redBox,
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: _redBox,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),  //父
            child: UnconstrainedBox(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
                child: _redBox,
              ),
            ) ,
          )
        ],
      ),
    );

  }
}