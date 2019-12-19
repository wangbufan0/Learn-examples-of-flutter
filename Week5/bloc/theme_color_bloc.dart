import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///  

class ThemeColorChangeEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}
const List<MaterialColor> BAR_BACK_COLORS = [
  Colors.green,
  Colors.blue,
];

class ThemeColorBloc extends Bloc<ThemeColorChangeEvent,MaterialColor>{
  @override
  // TODO: implement initialState
  MaterialColor get initialState => BAR_BACK_COLORS[0];

  @override
  Stream<MaterialColor> mapEventToState(ThemeColorChangeEvent event)async* {
    // TODO: implement mapEventToState
    yield state==BAR_BACK_COLORS[0]?BAR_BACK_COLORS[1]:BAR_BACK_COLORS[0];
  }

}

