import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/list_bloc.dart';
import 'package:flutter_layouts_exampls/view/view_selector.dart';

///
///time:  2019/12/24
///author: wangbufan
///email: wangbufan00@gmail.com
///  


const _SCROLL_TITLE = "Scroll Direction";
const _SCROLL_VALUES = ["Vertical", "Horizontal"];


class ListSelector extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ViewSelector(
            title: _SCROLL_TITLE,
            values: _SCROLL_VALUES,
            onClick: (index){
              BlocProvider.of<ListBloc>(context).add(index);
            },
          ),
        )
      ],
    );
  }
}
