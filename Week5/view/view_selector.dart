import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/view_selector_bloc.dart';
import 'package:flutter_layouts_exampls/constant/size_const.dart';

///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///



class ViewSelector extends StatelessWidget {
  ViewSelector(
      {Key key,
      this.title,
      this.values,
      this.onClick,
      this.mainColor = Colors.white})
      : super(key: key);

  final String title;
  final List<String> values;
  final ValueChanged<int> onClick;
  final Color mainColor;

  List<DropdownMenuItem> _items(List<String> values){
    return values.map((value)=>DropdownMenuItem(
      value: values.indexOf(value),
      child: Text(
        value,
        style: TextStyle(
          // color: widget.mainColor,
            fontSize: TEXT_NORMAL_SIZE
        ),
      ),

    )).toList();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewSelectBloc>(
      create: (context)=>ViewSelectBloc(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Divider(color: mainColor,),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: mainColor,
                fontSize: TEXT_NORMAL_SIZE,
              ),
            ),
          ),
          BlocBuilder<ViewSelectBloc,int>(
            builder: (context,state){
              return DropdownButton(
                value: state,
                items: _items(values),
                onChanged: (value){
                  BlocProvider.of<ViewSelectBloc>(context).add(value);
                  onClick(value);
                },
              );
            },
          ),

        ],
      ),
    );
  }


}

