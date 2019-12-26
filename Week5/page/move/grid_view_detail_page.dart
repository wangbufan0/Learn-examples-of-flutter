import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/page/move/start_view.dart';
import 'package:toast/toast.dart';

///
///time:  2019/12/26
///author: wangbufan
///email: wangbufan00@gmail.com
///

class GridViewDetailPage extends StatelessWidget {
  static void launch(BuildContext context, MoveItem item) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GridViewDetailPage(
        item: item,
      ),
    ));
  }

  final MoveItem item;

  const GridViewDetailPage({@required this.item});

  Widget _topImage() => Image.asset(
        item.bannerUrl,
        fit: BoxFit.cover,
      );

  Widget _textWhite({@required name, size = TEXT_NORMAL_SIZE, isBold = false}) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: isBold ? FontWeight.w700 : null,
        shadows: isBold
            ? [Shadow(color: Colors.grey[500], offset: Offset(0, 1))]
            : null,
      ),
    );
  }

  Widget _topBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textWhite(name: item.name, size: TEXT_LARGE_SIZE, isBold: true),
        SizedBox(height: 1),
        CountStar(item.rating, color: Colors.white),
        SizedBox(height: 2),
        _textWhite(name: item.directors),
        _textWhite(name: item.releaseDateDesc),
      ],
    );
  }

  Widget _topView() {
    return Container(
      height: 380,
      //constraints: BoxConstraints.expand(height: 380),
      padding: EdgeInsets.only(bottom: 4),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _topImage(),
          Positioned(
            left: 8,
            bottom: 10,
            child: _topBody(),
          ),
        ],
      ),
    );
  }

  Widget _categoryButton({@required str, @required VoidCallback onPress}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: OutlineButton(
        textColor: Colors.white,
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          str,
          style: TextStyle(fontSize: TEXT_NORMAL_SIZE),
        ),
        onPressed: onPress,
      ),
    );
  }

  Widget _category(context) {
    var sp = item.category.split(',');
    // assert(sp.length == 3);
    return Container(
      height: 50,
      child: Row(
        children: sp.map((str) {
          return Expanded(
            child: _categoryButton(
              str: str,
              onPress: () {
                Toast.show("click: $str", context);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _watchButton(context) {
    return Container(
//      color: Colors.grey,
      constraints: BoxConstraints.expand(height: 50),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Text(
          "Watch Move",
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.w700,
              fontSize: TEXT_LARGE_SIZE,
              shadows: [Shadow(color: Colors.grey[500], offset: Offset(0, 2))]),
        ),
        onPressed: () {
          Toast.show("watch move", context);
        },
      ),
    );
  }

  Widget _middleView(context) {
    return Column(
      children: <Widget>[
        _category(context),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: _textWhite(name: item.desc),
        ),
        _watchButton(context)
      ],
    );
  }

  Widget _childMove(img) {
    return Image.asset(
      img,
      fit: BoxFit.cover,
      width: 140,
      height: 100,
    );
  }

  Widget _bottomView() {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _textWhite(name: 'Other Moves'),
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => _childMove(item.trailerImg1),
              separatorBuilder: (context, index) => VerticalDivider(
                color: Colors.transparent,
                width: 10,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      backgroundColor: Color(0xff761322),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _topView(),
          _middleView(context),
          _bottomView(),
        ],
      ),
    );
  }
}
