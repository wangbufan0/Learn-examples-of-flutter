

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1),(i){
    return i;
  });
}

class StreamBuilderTestRoute extends StatefulWidget {


  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context)=>StreamBuilderTestRoute()
    ));
  }


  @override
  State createState() {
    return _StreamBuilderTestRouteState();
  }

}

class _StreamBuilderTestRouteState extends State<StreamBuilderTestRoute>{

  int  count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('InheritedWidget Route')
      ),
      body: Center(
        child:  StreamBuilder<int>(
          stream: counter(),
          builder: (context,AsyncSnapshot<int> snapshot){
            if(snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return Text('没有Sream');
              case ConnectionState.waiting:
                return Text('等待数据');
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return Text('Steamg关闭');
            }
            return null;
          },
        ),
      ),
    );
  }
}