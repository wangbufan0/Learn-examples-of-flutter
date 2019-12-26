///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/constant/main_const.dart';
import 'package:flutter_layouts_exampls/page/expand_page.dart';
import 'package:flutter_layouts_exampls/page/hero_page.dart';
import 'package:flutter_layouts_exampls/page/list_page.dart';
import 'package:flutter_layouts_exampls/page/move/grid_view_page.dart';
import 'package:flutter_layouts_exampls/page/nested_page.dart';
import 'package:flutter_layouts_exampls/page/padding_page.dart';
import 'package:flutter_layouts_exampls/page/page_view_page.dart';
import 'package:flutter_layouts_exampls/page/row_column_page.dart';
import 'package:flutter_layouts_exampls/page/sliver_page.dart';
import 'package:flutter_layouts_exampls/page/stack_page.dart';

import 'bloc/theme_color_bloc.dart';

class MyMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyMainState();
}

const ITEM_COUNT = 5;

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
      ),
    );
  }

  Widget _itemBody(type) {
    switch (type) {
      case ItemType.row_column:
        return RowColumnPage();
      case ItemType.stack:
        return StackPage();
      case ItemType.expanded:
        return ExpandPage();
      case ItemType.padding:
        return PaddingPage();
      case ItemType.move:
        return GridViewPage();
      case ItemType.page_view:
        return PageViewPage();
      case ItemType.list:
        return ListPage();
      case ItemType.sliver:
        return SliverPage();
      case ItemType.hero:
        return HeroPage();
      case ItemType.nested:
        return NestedPage();
      default:
        return RowColumnPage();
    }
  }

  List<BottomNavigationBarItem> _bottomItems() {
    return curGroup == GroupType.simple
        ? [
            _bottomItem(ItemType.row_column),
            _bottomItem(ItemType.stack),
            _bottomItem(ItemType.expanded),
            _bottomItem(ItemType.padding),
            _bottomItem(ItemType.move),
          ]
        : [
            _bottomItem(ItemType.page_view),
            _bottomItem(ItemType.list),
            _bottomItem(ItemType.sliver),
            _bottomItem(ItemType.hero),
            _bottomItem(ItemType.nested),
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
        )
    );
  }

  Color _itemColor(type) {
    return curItemType == type ? Theme.of(context).iconTheme.color : Colors.grey;
  }

  void _selectItem(index) {
    setState(() {
      var cur = curGroup == GroupType.simple ? index : index + ITEM_COUNT;
      curItemType = convertItemType(cur);
    });
  }

  void _changeGroup() {
    BlocProvider.of<ThemeColorBloc>(context).add(ThemeColorChangeEvent());
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
