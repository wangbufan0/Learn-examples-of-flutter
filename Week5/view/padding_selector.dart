import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/padding_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///  

const _LEFT_TITLE = "padding left";
const _RIGHT_TITLE = "padding right";
const _TOP_TITLE = "padding top";
const _BOTTOM_TITLE = "padding bottom";

const PADDING_VALUES = [
  "0",
  "5",
  "10",
  "15",
  "20",
  "25",
  "30",
  "35",
  "40",
  "45",
  "50"
];

class PaddingSelector extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ViewSelector(
                title: _LEFT_TITLE,
                values: PADDING_VALUES,
                onClick: (index){
                  BlocProvider.of<PaddingBloc>(context).add(LeftEvent(left: index));
                },
              ),
            ),
            Expanded(
              child: ViewSelector(
                title: _RIGHT_TITLE,
                values: PADDING_VALUES,
                onClick: (index){
                  BlocProvider.of<PaddingBloc>(context).add(RightEvent(right: index));
                },
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ViewSelector(
                title: _TOP_TITLE,
                values: PADDING_VALUES,
                onClick: (index){
                  BlocProvider.of<PaddingBloc>(context).add(TopEvent(top: index));
                },
              ),
            ),
            Expanded(
              child: ViewSelector(
                title: _BOTTOM_TITLE,
                values: PADDING_VALUES,
                onClick: (index){
                  BlocProvider.of<PaddingBloc>(context).add(BottomEvent(bottom: index));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

