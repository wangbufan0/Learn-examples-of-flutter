import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/expand_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

const ARRANGE_TITLE = "Row/Column";
const ARRANGE_VALUES = ["Row", "Column"];

const TITLES = ["Expand One", "Expand Two"];
const _NUM_VALUES = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

class ExpandSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ViewSelector(
          title: ARRANGE_TITLE,
          values: ARRANGE_VALUES,
          onClick: (index) {
            BlocProvider.of<ExpandBloc>(context)
                .add(ArrangeTypeChanged(type: ArrangeTypeValues.values[index]));
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ViewSelector(
                title: TITLES[0],
                values: _NUM_VALUES,
                onClick: (index){
                  BlocProvider.of<ExpandBloc>(context)
                      .add(OneFlexChanged(oneFlex: index));
                },
              ),
            ),
            Expanded(
              child: ViewSelector(
                title: TITLES[1],
                values: _NUM_VALUES,
                onClick: (index){
                  BlocProvider.of<ExpandBloc>(context)
                      .add(TwoFlexChanged(twoFlex: index));
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
