import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layouts_exampls/bloc/event/nested_event.dart';
import 'package:flutter_layouts_exampls/bloc/state/nested_state.dart';

export 'package:flutter_layouts_exampls/bloc/event/nested_event.dart';
export 'package:flutter_layouts_exampls/bloc/state/nested_state.dart';

///
///time:  2019/12/25
///author: wangbufan
///email: wangbufan00@gmail.com
///

class NestedBloc extends Bloc<NestedEvent, NestedState> {
  @override
  // TODO: implement initialState
  NestedState get initialState => NestedState.initial();

  @override
  Stream<NestedState> mapEventToState(NestedEvent event) async* {
    if (event is ParentScrollChanged) {
      yield state.copyWith(
          direction: event.index == 0 ? Axis.vertical : Axis.horizontal);
    } else if (event is ParentCountChanged) {
      yield state.copyWith(parentCount: 2*(event.index+1));
    } else if (event is ChildCountChanged) {
      yield state.copyWith(childCount: 10*(event.index+1));
    }
  }
}
