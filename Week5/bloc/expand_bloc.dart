import 'package:bloc/bloc.dart';
import 'package:flutter_layouts_exampls/bloc/event/expand_event.dart';
import 'package:flutter_layouts_exampls/bloc/state/expand_state.dart';

export 'package:flutter_layouts_exampls/bloc/event/expand_event.dart';
export 'package:flutter_layouts_exampls/bloc/state/expand_state.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

class ExpandBloc extends Bloc<ExpandEvent, ExpandState> {
  @override
  // TODO: implement initialState
  ExpandState get initialState => ExpandState.initial();

  @override
  Stream<ExpandState> mapEventToState(ExpandEvent event) async* {
    if (event is OneFlexChanged) {
      yield state.copyWith(oneFlex: event.oneFlex);
    } else if (event is TwoFlexChanged) {
      yield state.copyWith(twoFlex: event.twoFlex);
    }else if(event is ArrangeTypeChanged){
      yield state.copyWith(type: event.type);
    }
  }
}
