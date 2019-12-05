


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewSeparatedRoute extends StatelessWidget{


  static void launch(BuildContext context){
    Navigator.of(context)
        .push(
        MaterialPageRoute(
            builder: (context)=>ListViewSeparatedRoute()
        )
    );
  }


  Widget divider1=Divider(color: Colors.blue,);
  Widget divider2=Divider(color: Colors.green,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Separated'),
      ),

      body: Column(
       children: <Widget>[
         ListTile(title: Text('商品列表'),),
         SizedBox(
           height: MediaQuery.of(context).size.height-24-56-56,
           child:  ListView.separated(
             itemCount: 10,
             itemBuilder: (context,index){
               return ListTile(title: Text('$index'),);
             },
             separatorBuilder: (context,index){
               return index%2==0?divider1:divider2;
             },
           ),
         )

       ],
      )
    );
  }
}