import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/page/move/grid_view_detail_page.dart';
import 'package:flutter_layouts_exampls/page/move/start_view.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///  

const RELEASE_DATE = "RELEASE DATE", RUNTIME = "RUMTIME";

class GridViewPage extends StatelessWidget{

  Widget _backImage(MoveItem item){
    return AspectRatio(
      aspectRatio: 1.5,
      child: Image.asset(
        item.trailerImg1,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _showTimeItem(name,value){
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: TEXT_SMALL_SIZE_2,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 2,),
        Text(
          value,
          style: TextStyle(
            fontSize: TEXT_SMALL_SIZE_2,
            color: Colors.grey[900]
          ),
        ),
      ],
    );
  }

  Widget _cardBottom(MoveItem item){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 1,
        ),
        Text(
          item.name,
          style: TextStyle(
            color:Colors.grey[900],
            fontSize: TEXT_SMALL_SIZE,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 1,),
        Text(
          item.category,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: TEXT_SMALL_SIZE
          ),
        ),
        SizedBox(height: 5,),
        CountStar(item.rating),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            _showTimeItem(RELEASE_DATE, item.releaseDate),
            SizedBox(width: 6,),
            _showTimeItem(RUNTIME, item.runtime),
          ],
        )
      ],
    );
  }

  Widget _getItem(context,MoveItem item){
    return InkWell(
      onTap: (){
        GridViewDetailPage.launch(context, item);
      },
      child: Card(
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _backImage(item),
                Container(
                  padding: EdgeInsets.only(left: 4,right: 4,bottom: 8),
                  child: _cardBottom(item),
                )
              ],
            )
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var items = getItemList();
    var l = List<Widget>();
    for(var item in items)
      l.add(_getItem(context,item));
    return Scaffold(
      appBar: AppBar(
        title: Text(BOTTOM_TITLES[ItemType.move.index]),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 2,
          childAspectRatio: 0.9,
          children: l,
        ),
      ),
    );
  }
}

