

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{

  TabController tabController;

  List tabs;

  MyAppBar({
    @required this.tabController,
    this.tabs,
  }):assert(tabController!=null);

  @override
  State createState() {
    return MyAppBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(98);


}

class MyAppBarState extends State<MyAppBar>{


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('App Name'),
      leading: Builder(builder:(context){
        return IconButton(
          icon: Icon(Icons.dashboard,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        );
      },),
      bottom: TabBar(
        controller: widget.tabController,
        tabs: widget.tabs.map((e)=>Tab(text: e,)).toList(),
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.share),onPressed: (){},)
      ],
    );
  }
}