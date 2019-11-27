import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnRoute extends StatelessWidget {
  static void launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ColumnRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column Route'),
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: double.infinity),
          child: Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('hello '),
                          Text('i am happy'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('hello '),
                        Text('i am happy'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
