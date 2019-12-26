import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///time:  2019/12/26
///author: wangbufan
///email: wangbufan00@gmail.com
///  


class CountStar extends StatelessWidget{

 bool isHalf;
 int num;
 Color color;
  CountStar(double rating,{this.color=Colors.deepOrange}){
    num=rating~/2;
    isHalf=(rating-num*2)>1;

  }



  @override
  Widget build(BuildContext context) {
    var starts=List<Widget>();

    var size=20.0;
    var line=SizedBox(width: 0,);
    for(int i=0;i<num;i++){
      starts.add(
        Icon(
          Icons.star,
          color: color,
          size: size,
        )
      );
    }
    if(isHalf){
      starts.add(
        Icon(
          Icons.star_half,
          color: color,
          size: size,
        )
      );
    }
    int surplus=5-num-(isHalf?1:0);
    for(int i=0;i<surplus;i++){
      starts.add(
        Icon(
          Icons.star_border,
          color: color,
          size: size,
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:starts
    );
  }
}
