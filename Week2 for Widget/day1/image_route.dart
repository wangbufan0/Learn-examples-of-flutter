

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageRoute extends  StatelessWidget{

  static launch(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context)=>ImageRoute()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Route'),
      ),
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage('images/girl.jpg'),
            width: 100,
          ),
          Image.network(
            'https://wx3.sinaimg.cn/mw690/006r9iaMgy1g852xp2ckmj323u35sqv7.jpg',
            width: 100,
          )
        ],
      ),
    );
  }
}