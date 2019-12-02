import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerRoute extends StatelessWidget {
  static launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContainerRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transform Route'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50, left: 120),
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: 1
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2,2),
                    blurRadius: 4
                  )
                ]
              ),
              transform: Matrix4.rotationZ(.2),
              alignment: Alignment.center,
              child: Text(
                '5.20',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
