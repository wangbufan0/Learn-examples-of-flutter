import 'package:flutter/material.dart';

///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

const BOTTOM_TITLES=[
  "Row/Column",

];

const BOTTOM_ICONS=[
  Icons.view_headline,
];

const BAR_ICONS=[
  Icons.filter_1,
  Icons.filter_2,
];


const BAR_BACK_COLORS = [
  Colors.green,
  Colors.blueAccent,
];

enum GroupType{
 simple,
  scroll
}

enum ItemType{
  row_column,
}

ItemType convertItemType(index){
  switch(index){
    case 0:
      return ItemType.row_column;


    default:
      return ItemType.row_column;
  }

}


