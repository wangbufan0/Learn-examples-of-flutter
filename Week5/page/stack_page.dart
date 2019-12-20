import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/stack_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/stack_selector.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///
const _BOX_COLORS = [
  Colors.deepPurple,
  Colors.cyan,
  Colors.amberAccent,
  Colors.red,
  Colors.lightGreen
];

class StackPage extends StatelessWidget {
  StackPage({Key key}) : super(key: key);

  Widget _body(StackState state) {
    return state.type == StackTypeValues.Align
        ? Stack(
            alignment: state.align,
            children: <Widget>[
              SizedBox(
                width: 400,
                height: 400,
                child: Container(
                  color: _BOX_COLORS[0],
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Container(
                  color: _BOX_COLORS[1],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  color: _BOX_COLORS[2],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  color: _BOX_COLORS[3],
                ),
              )
            ],
          )
        : Stack(
            alignment: state.align,
            children: <Widget>[
              SizedBox(
                width: 400,
                height: 400,
                child: Container(
                  color: _BOX_COLORS[0],
                ),
              ),
              Positioned(
                top: 50,
                left: 30,
                width: 100,
                height: 100,
                child: Container(
                  color: _BOX_COLORS[1],
                ),
              ),
              Positioned(
                top: 50,
                right: 30,
                width: 100,
                height: 100,
                child: Container(
                  color: _BOX_COLORS[2],
                ),
              ),
              Positioned(
                bottom: 50,
                left: 30,
                width: 100,
                height: 100,
                child: Container(
                  color: _BOX_COLORS[3],
                ),
              ),
              Positioned(
                width: 100,
                height: 100,
                bottom: 50,
                right: 30,
                child: Container(
                  color: _BOX_COLORS[4],
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StackBloc>(
      create: (context) => StackBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(BOTTOM_TITLES[ItemType.stack.index]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SELECTOR_ONE_HEIGHT),
            child: StackSelector(),
          ),
          backgroundColor: Theme.of(context).iconTheme.color,
        ),
        body: Container(
          padding: EdgeInsets.all(11),
          color: Colors.grey[350],
          child: BlocBuilder<StackBloc, StackState>(
            builder: (context, state) {
              return _body(state);
            },
          ),
        ),
      ),
    );
  }
}
