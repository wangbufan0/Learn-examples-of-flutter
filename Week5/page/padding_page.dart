import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/padding_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/padding_selector.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///

const _PADDING_COLORS=[
  Colors.deepPurple,
  Colors.yellowAccent
];

class PaddingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaddingBloc>(
      create: (it)=>PaddingBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).iconTheme.color,
          title: Text(BOTTOM_TITLES[ItemType.padding.index]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SELECTOR_TWO_HEIGHT),
            child: PaddingSelector(),
          ),
        ),
        body: BlocBuilder<PaddingBloc,PaddingState>(
          builder: (context,state){
            return Container(
              constraints: BoxConstraints.expand(),
              color: _PADDING_COLORS[0],
              child: Padding(
                padding: EdgeInsets.fromLTRB(state.left, state.top, state.right, state.bottom),
                child: Container(
                  color: _PADDING_COLORS[1],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

