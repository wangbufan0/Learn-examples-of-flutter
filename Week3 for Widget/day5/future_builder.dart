

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> mockNetworkData() async{
  return Future.delayed(Duration(seconds: 2),()=>"网络获取的数据");
}

class FutureBuilderTestRoute extends StatefulWidget {


  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context)=>FutureBuilderTestRoute()
    ));
  }


  @override
  State createState() {
    return _FutureBuilderTestRouteState();
  }

}

class _FutureBuilderTestRouteState extends State<FutureBuilderTestRoute>{

  int  count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('InheritedWidget Route')
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: mockNetworkData(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasError){
                return Text("Error: ${snapshot.error}");
              }else{
                return Text('Contents: ${snapshot.data}');
              }
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}