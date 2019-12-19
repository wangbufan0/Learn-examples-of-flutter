import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/expand_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/constant/main_const.dart';
import 'package:flutter_layouts_exampls/view/expand_selector.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///
const _EXPAND_COLORS = [
  Colors.deepPurple,
  Colors.amberAccent,
  Colors.red,
];

class ExpandPage extends StatelessWidget {
  Widget _body(ExpandState state) {
    var children = [
      Expanded(
        flex: state.oneFlex,
        child: Container(
          color: _EXPAND_COLORS[0],
          child: Center(
            child: Text(
              TITLES[0],
              style: TextStyle(color: Colors.white, fontSize: TEXT_LARGE_SIZE),
            ),
          ),
        ),
      ),
      Expanded(
        flex: state.twoFlex,
        child: Container(
          color: _EXPAND_COLORS[1],
          child: Center(
            child: Text(
              TITLES[1],
              style: TextStyle(color: Colors.white, fontSize: TEXT_LARGE_SIZE),
            ),
          ),
        ),
      ),
    ];

    return state.type == ArrangeTypeValues.Row
        ? Row(
            mainAxisSize: MainAxisSize.max,
            children: children,
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            children: children,
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpandBloc>(
      create: (context) => ExpandBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).iconTheme.color,
          title: Text(BOTTOM_TITLES[ItemType.expanded.index]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SELECTOR_TWO_HEIGHT),
            child: ExpandSelector(),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: BlocBuilder<ExpandBloc, ExpandState>(
            builder: (context, state) {
              return _body(state);
            },
          ),
        ),
      ),
    );
  }
}
