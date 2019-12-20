import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layouts_exampls/bloc/expand_bloc.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

class ExpandState extends Equatable {
  final int oneFlex;
  final int twoFlex;
  final ArrangeTypeValues type;

  const ExpandState(
      {@required this.oneFlex, @required this.twoFlex, @required this.type});

  factory ExpandState.initial() {
    return ExpandState(oneFlex: 0, twoFlex: 0,type:ArrangeTypeValues.Row);
  }

  ExpandState copyWith({int oneFlex, int twoFlex, ArrangeTypeValues type}) {
    return ExpandState(
      oneFlex: oneFlex ?? this.oneFlex,
      twoFlex: twoFlex ?? this.twoFlex,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [oneFlex, twoFlex,type];
}
