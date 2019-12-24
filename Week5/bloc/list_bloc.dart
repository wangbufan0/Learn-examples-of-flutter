import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

///
///time:  2019/12/24
///author: wangbufan
///email: wangbufan00@gmail.com
///


class ListBloc extends Bloc<int,Axis>{
  @override
  Axis get initialState => Axis.vertical;

  @override
  Stream<Axis> mapEventToState(int event) async*{
    if(event==0)
      yield Axis.vertical;
    else
      yield Axis.horizontal;

  }


}




