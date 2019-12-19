import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/stack_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

const _SET_TYPE_TITLE = "Set Type";
const _SET_TYPE_VALUES = ["Align", "Position"];

const _DIRECTION_TITLE = "Align Direcation";
const _DIRECTION_VALUES = [
  "top\nstart",
  "top\ncenter",
  "top\nend",
  "center\nstart",
  "center",
  "center\nend",
  "bottom\nstart",
  "bottom\ncenter",
  "bottom\nend",
];

class StackSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ViewSelector(
            title: _SET_TYPE_TITLE,
            values: _SET_TYPE_VALUES,
            onClick: (index) {
              BlocProvider.of<StackBloc>(context).add(
                  StackTypeChanged(stackType: StackTypeValues.values[index]));
            },
          ),
        ),
        Expanded(
          child: ViewSelector(
            title: _DIRECTION_TITLE,
            values: _DIRECTION_VALUES,
            onClick: (index) {
              BlocProvider.of<StackBloc>(context).add(AlignDirectionChanged(
                  alignDirectionValues: AlignDirectionValues.values[index]));
            },
          ),
        )
      ],
    );
  }
}
