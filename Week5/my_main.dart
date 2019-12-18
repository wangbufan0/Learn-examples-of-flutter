///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/main_const.dart';
import 'package:flutter_layouts_exampls/page/row_column_page.dart';

class MyMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMainState();
}

const ITEM_COUNT = 2;

class MyMainState extends State<MyMain> {
  var curGroup = GroupType.simple;
  var curItemType = ItemType.row_column;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: _itemBody(curItemType),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomItems(),
        onTap: _selectItem,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(BAR_ICONS[curGroup.index]),
        onPressed: _changeGroup,
        backgroundColor: BAR_BACK_COLORS[curGroup.index],
      ),
    );
  }

  Widget _itemBody(type) {
    switch (type) {
      case ItemType.row_column:
        return RowColumnPage(themeColor: BAR_BACK_COLORS[curGroup.index],);
      default:
        return RowColumnPage(themeColor: BAR_BACK_COLORS[curGroup.index],);
    }
  }

  List<BottomNavigationBarItem> _bottomItems() {
    return curGroup == GroupType.simple
        ? [
            _bottomItem(ItemType.row_column),
            _bottomItem(ItemType.row_column)
          ]
        : [
            _bottomItem(ItemType.row_column),
            _bottomItem(ItemType.row_column)
          ];
  }

  BottomNavigationBarItem _bottomItem(ItemType type) {
    return BottomNavigationBarItem(
        icon: Icon(
          BOTTOM_ICONS[type.index],
          color: _itemColor(type),
        ),
        title: Text(
          BOTTOM_TITLES[type.index],
          style: TextStyle(color: _itemColor(type)),
        ));
  }

  Color _itemColor(type) {
    return curItemType == type ? BAR_BACK_COLORS[curGroup.index] : Colors.grey;
  }

  void _selectItem(index) {
    setState(() {
      var cur = curGroup == GroupType.simple ? index : index + ITEM_COUNT;
      curItemType = convertItemType(cur);
    });
  }

  void _changeGroup() {
    setState(() {
      if (curGroup == GroupType.simple) {
        curGroup = GroupType.scroll;
        if (curItemType.index < ITEM_COUNT)
          curItemType = convertItemType(curItemType.index + ITEM_COUNT);
      } else {
        curGroup = GroupType.simple;
        if (curItemType.index >= ITEM_COUNT)
          curItemType = convertItemType(curItemType.index - ITEM_COUNT);
      }
    });
  }
}
