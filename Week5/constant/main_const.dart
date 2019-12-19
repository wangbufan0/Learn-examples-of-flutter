import 'package:flutter/material.dart';

///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

const BOTTOM_TITLES = [
  "Row/Column",
  'Stack',
  'Expanded',
  'Padding',

  //The second items.
  'Page View',
  'List',
  'Slivers',
  'Hero',
  'Nested'
];

const BOTTOM_ICONS = [
  Icons.view_headline,
  Icons.layers,
  Icons.line_weight,
  Icons.format_line_spacing,

  // The second items.
  Icons.view_week,
  Icons.format_list_bulleted,
  Icons.view_day,
  Icons.gradient,
  Icons.dashboard,
];

const BAR_ICONS = [
  Icons.filter_1,
  Icons.filter_2,
];


enum GroupType { simple, scroll }

enum ItemType {
  row_column,
  stack,
  expanded,
  padding,

  //The second items.
  page_view,
  list,
  sliver,
  hero,
  nested
}

ItemType convertItemType(index) {
  switch (index) {
    case 0:
      return ItemType.row_column;
    case 1:
      return ItemType.stack;
    case 2:
      return ItemType.expanded;
    case 3:
      return ItemType.padding;

    case 4:
      return ItemType.page_view;
    case 5:
      return ItemType.list;
    case 6:
      return ItemType.sliver;
    case 7:
      return ItemType.hero;
    case 8:
      return ItemType.nested;
    default:
      return ItemType.row_column;
  }
}
