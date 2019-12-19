import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layouts_exampls/bloc/event/stack_event.dart';
import 'package:flutter_layouts_exampls/bloc/state/stack_state.dart';

export 'package:flutter_layouts_exampls/bloc/event/stack_event.dart';
export 'package:flutter_layouts_exampls/bloc/state/stack_state.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

class StackBloc extends Bloc<StackEvent, StackState> {
  @override
  StackState get initialState => StackState.initial();

  @override
  Stream<StackState> mapEventToState(StackEvent event) async*{

    if(event is StackTypeChanged){
      yield state.copyWith(type: event.stackType);
    }else if(event is AlignDirectionChanged){
      yield state.copyWith(align: _changeAlignDirection(event.alignDirectionValues.index));
    }

  }
  AlignmentDirectional _changeAlignDirection(pos){
    var align = AlignmentDirectional.topStart;
    switch (pos) {
      case 0:
        align = AlignmentDirectional.topStart;
        break;
      case 1:
        align = AlignmentDirectional.topCenter;
        break;
      case 2:
        align = AlignmentDirectional.topEnd;
        break;
      case 3:
        align = AlignmentDirectional.centerStart;
        break;
      case 4:
        align = AlignmentDirectional.center;
        break;
      case 5:
        align = AlignmentDirectional.centerEnd;
        break;
      case 6:
        align = AlignmentDirectional.bottomStart;
        break;
      case 7:
        align = AlignmentDirectional.bottomCenter;
        break;
      case 8:
        align = AlignmentDirectional.bottomEnd;
        break;
      default:
        align = AlignmentDirectional.topStart;
        break;
    }
    return align;
  }

}
