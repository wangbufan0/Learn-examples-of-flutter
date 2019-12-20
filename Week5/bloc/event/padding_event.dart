import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///  

abstract class PaddingEvent extends Equatable{

  const PaddingEvent();
  @override
  List<Object> get props => [];
}

class LeftEvent extends PaddingEvent{
  final int left;

  const LeftEvent({@required this.left});
  @override
  List<Object> get props => [left];
}

class RightEvent extends PaddingEvent{
  final int right;

  const RightEvent({@required this.right});
  @override
  List<Object> get props => [right];
}

class TopEvent extends PaddingEvent{
  final int top;

  const TopEvent({@required this.top});
  @override
  List<Object> get props => [top];
}

class BottomEvent extends PaddingEvent{
  final int bottom;

  const BottomEvent({@required this.bottom});
  @override
  List<Object> get props => [bottom];
}

