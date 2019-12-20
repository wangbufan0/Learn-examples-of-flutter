import 'package:bloc/bloc.dart';
import 'package:flutter_layouts_exampls/bloc/event/padding_event.dart';
import 'package:flutter_layouts_exampls/bloc/state/padding_state.dart';
export 'package:flutter_layouts_exampls/bloc/event/padding_event.dart';
export 'package:flutter_layouts_exampls/bloc/state/padding_state.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///  

class PaddingBloc extends Bloc<PaddingEvent,PaddingState>{
  @override
  PaddingState get initialState => PaddingState.initial();

  @override
  Stream<PaddingState> mapEventToState(PaddingEvent event) async*{
    if(event is LeftEvent){
      yield state.copyWith(left: event.left*5.0);
    }else if(event is RightEvent){
      yield state.copyWith(right: event.right*5.0);
    }else if(event is TopEvent){
      yield state.copyWith(top: event.top*5.0);
    }else if(event is BottomEvent){
      yield state.copyWith(bottom: event.bottom*5.0);
    }
  }

}

