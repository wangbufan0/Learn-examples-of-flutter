import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/nested_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///  

const _DIRECTION_TITTLE = "Parent Scroll Direction";
const _DIRECTION_VALUES = ["Vertical", "Horizontal"];

const _PARENT_TITLE = "Parent List Count";
const _PARENT_VALUES = ["2", "4", "6", "8", "10"];

const _CHILD_TITLE = "Clild List Count";
const _CHILD_VALUES = ["10", "20", "30", "40", "50"];


class NestedSelector extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<NestedBloc>(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ViewSelector(
                title: _DIRECTION_TITTLE,
                values: _DIRECTION_VALUES,
                onClick: (index){
                  bloc.add(ParentScrollChanged(index: index));
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ViewSelector(
                title: _PARENT_TITLE,
                values: _PARENT_VALUES,
                onClick: (index){
                  bloc.add(ParentCountChanged(index: index));
                },
              ),
            ),
            Expanded(
              child: ViewSelector(
                title: _CHILD_TITLE,
                values: _CHILD_VALUES,
                onClick: (index){
                  bloc.add(ChildCountChanged(index: index));
                },
              ),
            ),
          ],
        ),
      ],
    ) ;
  }
}

