import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/nested_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/nested_selector.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///  

final List<MaterialColor> _parentColors = [
  Colors.deepOrange,
  Colors.green,
  Colors.brown,
  Colors.indigo,
  Colors.purple,
];

class NestedPage extends StatelessWidget{

  Widget _parentBody(NestedState state){
    var _height=100.0;
    return ListView.builder(
      itemCount: state.parentCount,
      scrollDirection: state.direction,
      itemBuilder: (context,index){
        return Container(
          constraints: BoxConstraints.tightForFinite(height: _height,width: _height),
          alignment: AlignmentDirectional.centerStart,
          child: _childBody(index,_height,state),
        );
      },
    );
  }

  Widget _childBody(int parentIndex,double height,NestedState state){
    return ListView.builder(
      itemCount: state.childCount,
      scrollDirection: state.direction==Axis.vertical?Axis.horizontal:Axis.vertical,
      itemBuilder: (context,index){
        return Container(
          width: height,
          height: height,
          color: _parentColors[parentIndex%5][100*(index%5+4)],
          margin: EdgeInsets.all(1),
          alignment: Alignment.center,
          child: Text(
            index.toString(),
            style: TextStyle(
              color: Colors.white
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NestedBloc>(
      create: (context)=>NestedBloc(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(BOTTOM_TITLES[ItemType.nested.index]),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(SELECTOR_TWO_HEIGHT),
              child: NestedSelector(),
            )
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: BlocBuilder<NestedBloc,NestedState>(
            builder: (context,state){
              return _parentBody(state);
            },
          ),
        ),
      ),
    );
  }
}

