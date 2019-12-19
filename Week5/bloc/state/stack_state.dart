import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layouts_exampls/bloc/event/stack_event.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

class StackState extends Equatable {

  final AlignmentDirectional align;
  final StackTypeValues type;

  const StackState({@required this.align, @required this.type});

  factory StackState.initial() {
    return StackState(
        align: AlignmentDirectional.topStart, type: StackTypeValues.Align);
  }

  StackState copyWith({AlignmentDirectional align, StackTypeValues type}) {
    return StackState(align: align ?? this.align, type: type ?? this.type);
  }

  @override
  List<Object> get props => [align, type];
}
