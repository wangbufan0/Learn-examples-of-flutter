import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///

abstract class NestedEvent extends Equatable {
  const NestedEvent();
}

class ParentScrollChanged extends NestedEvent {
  final int index;

  const ParentScrollChanged({@required this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class ParentCountChanged extends NestedEvent {
  final int index;

  const ParentCountChanged({@required this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class ChildCountChanged extends NestedEvent {
  final int index;

  const ChildCountChanged({@required this.index});

  @override
  // TODO: implement props
  List<Object> get props => [index];
}
