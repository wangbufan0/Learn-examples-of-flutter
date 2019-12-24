import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';

///
///time:  2019/12/24
///author: wangbufan
///email: wangbufan00@gmail.com
///

const _ITEM_CONTENTS = [
  "SliverGrid",
  "SliverFixedExtentList",
  "SliverList",
  "SliverFillViewport",
];

class SliverPage extends StatelessWidget {
  Widget _sliverBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(BOTTOM_TITLES[ItemType.sliver.index]),
      ),
    );
  }

  Widget _itemBody(index, int type) {
    var c = 100 * (index % 9);
    return Container(
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.brown[c == 0 ? 400 : c],
      child: Text(
        _ITEM_CONTENTS[type] + index.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _sliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return _itemBody(index, 0);
      }, childCount: 20),
    );
  }

  Widget _sliverFixed() {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _itemBody(index, 1);
      }, childCount: 10),
      itemExtent: 100,
    );
  }

  Widget _sliverList(){
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context,index){
            return _itemBody(index, 2);
          },
        childCount: 10
      ),
    );
  }

  Widget _sliverViewPort(){
    return SliverFillViewport(
      delegate: SliverChildBuilderDelegate(
          (context,index){
            return _itemBody(index, 3);
          },
        childCount: 4
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          _sliverBar(),
          _sliverGrid(),
          _sliverFixed(),
          _sliverList(),
          _sliverViewPort()
        ],
      ),
    );
  }
}
