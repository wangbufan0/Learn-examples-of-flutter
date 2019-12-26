import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///

class NestedState extends Equatable {
  final Axis direction;
  final int parentCount;
  final int childCount;

  NestedState({this.direction, this.parentCount, this.childCount});

  factory NestedState.initial() {
    return NestedState(
      direction: Axis.vertical,
      parentCount: 2,
      childCount: 10,
    );
  }

  NestedState copyWith({direction, parentCount, childCount}) {
    return NestedState(
        direction: direction ?? this.direction,
        parentCount: parentCount ?? this.parentCount,
        childCount: childCount ?? this.childCount);
  }

  @override
  // TODO: implement props
  List<Object> get props => [direction, parentCount, childCount];
}
