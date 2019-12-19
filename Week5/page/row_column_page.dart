import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/my_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/row_column_selector.dart';

///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

class RowColumnPage extends StatelessWidget {
  RowColumnPage({
    Key key,
  }) : super(key: key);

  Widget _body(RowColumnState state) {
    List<Widget> children = [
      Icon(
        Icons.add_a_photo,
        size: 50,
      ),
      Icon(
        Icons.add_a_photo,
        size: 100,
      ),
      Icon(
        Icons.add_a_photo,
        size: 50,
      )
    ];

    return state.layType == LayType.column
        ? Column(
            mainAxisSize: state.size,
            mainAxisAlignment: state.mainAlign,
            crossAxisAlignment: state.crossAlign,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          )
        : Row(
            mainAxisSize: state.size,
            mainAxisAlignment: state.mainAlign,
            crossAxisAlignment: state.crossAlign,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RowColumnBloc>(
      create: (context) => RowColumnBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).iconTheme.color,
          title: Text(BOTTOM_TITLES[ItemType.row_column.index]),
          bottom: PreferredSize(
            preferredSize: Size(0, SELECTOR_TWO_HEIGHT),
            child: RowColumnSelector(),
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: BlocBuilder<RowColumnBloc, RowColumnState>(
            builder: (context, state) {
              return _body(state);
            },
          ),
        ),
      ),
    );
  }
}
