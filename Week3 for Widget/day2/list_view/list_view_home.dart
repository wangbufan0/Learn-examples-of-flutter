
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week2/week3/day2/list_view/list_view_builder.dart';
import 'package:flutter_week2/week3/day3/infinite_list_view.dart';
import 'package:flutter_week2/week3/day3/list_view_separated.dart';

import 'list_view_children.dart';



class ListViewHomeRoute extends StatefulWidget {

  static void launch(BuildContext context){
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context)=>ListViewHomeRoute()
      )
    );
  }

  @override
  State createState() => _ListViewHomeRouteState();
}

class _ListViewHomeRouteState extends State<ListViewHomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Home'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('ListView-Children'),
                onPressed: ()=>ListViewChildrenRoute.launch(context),
              ),
              RaisedButton(
                child: Text('ListView-builder'),
                onPressed: ()=>ListViewBuildRoute.launch(context),
              ),
              RaisedButton(
                child: Text('ListView-separated'),
                onPressed: ()=>ListViewSeparatedRoute.launch(context),
              ),
              RaisedButton(
                child: Text('Infinite-ListView'),
                onPressed: ()=>InfiniteListView.launch(context),
              ),
            ],
          ),
        )
    );
  }
}
