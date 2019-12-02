import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class TransformRoute extends StatelessWidget {


  static launch(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransformRoute())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transform Route'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black,
                child: Transform(
                  alignment: Alignment.bottomRight,
                  transform: Matrix4.skewY(0.3),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.deepOrange,
                    child: const Text('Matrix'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.translate(
                  offset: Offset(-20, -5),
                  child: Text('translate'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.rotate(
                  angle: math.pi/2,
                  child: Text('rotate'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                  scale: 1.5,
                  child: Text('scale'),
                ),
              ),

              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text('RotatedBox'),
                ),
              )


            ],
          ),
        )
    );
  }


}
