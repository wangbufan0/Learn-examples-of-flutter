import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';

///
///time:  2019/12/24
///author: wangbufan
///email: wangbufan00@gmail.com
///

const IMAGES = [
  "pic_01",
  "pic_02",
  "pic_04",
  "pic_05",
  "pic_06",
  "pic_07",
  "pic_08",
  "pic_09"
];

Image _getAssetImage(name) {
  return Image.asset(
    "assets/$name.jpg",
    fit: BoxFit.cover,
  );
}
class HeroPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(

        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(BOTTOM_TITLES[ItemType.hero.index]),
              background: _getAssetImage(IMAGES[0]),
            ),
          ),


          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
                (context,index){
                  var name=IMAGES[index%8];
                  return Container(
                    margin: EdgeInsets.all( 20),
                    child: _getAssetImage(name),
                  );
                }
                ,childCount: IMAGES.length
            ),

          )
        ],
      ),
    );
  }
}

