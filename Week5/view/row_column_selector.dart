///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/my_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

const LAY_TITLE = "layout";
const LAY_VALUES = ['row', 'column'];

const MAIN_SIZE_TITLE = "Main Axis Size";
const MAIN_SIZE_VALUES = [
  'min',
  'max',
];

const MAIN_ALIGN_TITLE = "Main Axis Alignment";
const MAIN_ALIGN_VALUES = [
  'start',
  'end',
  'center',
  'space\nbetween',
  'space\naround',
  'space\nevenly',
];

const CROSS_ALIGN_TITLE = "Cross Axis Alignment";
const CROSS_ALIGN_VALUES = [
  'start',
  'end',
  'center',
  'stretch',
  'baseline'
];

class RowColumnSelector extends StatelessWidget {
  RowColumnSelector({
    Key key,
  }) : super(key: key);

  RowColumnBloc bloc;

  void _changeLay(pos) {
    bloc.add(LayoutChanged(layType: LayType.values[pos]));
  }

  void _changeMainSize(pos) {
    bloc.add(SizeChanged(sizeType: SizeType.values[pos]));
  }

  void _changeMainAlign(pos) {
    bloc.add(MainAlignChanged(mainAlignValues: MainAlignValues.values[pos]));
  }

  void _changeCrossAlign(pos) {
    bloc.add(CrossAlignChanged(crossAlignValues: CrossAlignValues.values[pos]));
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<RowColumnBloc>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ViewSelector(
                title: LAY_TITLE,
                values: LAY_VALUES,
                onClick: _changeLay,
              ),
              ViewSelector(
                title: MAIN_SIZE_TITLE,
                values: MAIN_SIZE_VALUES,
                onClick: _changeMainSize,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ViewSelector(
                title: MAIN_ALIGN_TITLE,
                values: MAIN_ALIGN_VALUES,
                onClick: _changeMainAlign,
              ),
              ViewSelector(
                title: CROSS_ALIGN_TITLE,
                values: CROSS_ALIGN_VALUES,
                onClick: _changeCrossAlign,
              )
            ],
          ),
        ),
      ],
    );
  }

}
