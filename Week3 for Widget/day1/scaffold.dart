import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week2/week3/day1/my_app_bar.dart';
import 'package:flutter_week2/week3/day1/my_drawer.dart';

class ScaffoldRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScaffoldRoute()));
  }

  @override
  State createState() {
    return ScaffoldRouteState();
  }
}

class ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List tabs = ['新闻', "历史", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        tabController: _tabController,
        tabs: tabs,
      ),
      drawer: MyDrawer(),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 5,
              ),
            );
          }).toList()),
    );
  }
}
