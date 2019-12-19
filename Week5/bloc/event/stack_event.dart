import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

abstract class StackEvent extends Equatable {
  const StackEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

enum StackTypeValues {
  Align,
  Position,
}

class StackTypeChanged extends StackEvent {
  final StackTypeValues stackType;

  const StackTypeChanged({@required this.stackType});

  @override
  List<Object> get props => [stackType];
}

enum AlignDirectionValues {
  TopStart,
  TopCenter,
  TopEnd,
  CenterStart,
  Center,
  CenterEnd,
  BottomStart,
  BottomCenter,
  BottomEnd,
}

class AlignDirectionChanged extends StackEvent{
  final AlignDirectionValues alignDirectionValues;
  const AlignDirectionChanged({@required this.alignDirectionValues});

  @override
  List<Object> get props => [alignDirectionValues];
}
