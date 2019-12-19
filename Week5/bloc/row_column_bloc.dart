import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layouts_exampls/bloc/event/row_column_event.dart';
import 'package:flutter_layouts_exampls/bloc/state/row_column_state.dart';
export  'package:flutter_layouts_exampls/bloc/event/row_column_event.dart';
export 'package:flutter_layouts_exampls/bloc/state/row_column_state.dart';


///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

class RowColumnBloc extends Bloc<RowColumnEvent, RowColumnState> {
  @override
  RowColumnState get initialState => RowColumnState.initial();

  @override
  Stream<RowColumnState> mapEventToState(RowColumnEvent event) async* {
    if (event is LayoutChanged) {
      yield state.copyWith(layType: event.layType);
    } else if (event is SizeChanged) {
      yield state.copyWith(size: _changeMainSize(event.sizeType));
    } else if (event is MainAlignChanged) {
      yield state.copyWith(mainAlign: _changeMainAlign(event.mainAlignValues));
    } else if (event is CrossAlignChanged) {
      yield state.copyWith(crossAlign: _changeCrossAlign(event.crossAlignValues));
    }
  }

  MainAxisSize _changeMainSize(sizeType) {
    switch (sizeType) {
      case SizeType.min:
        return MainAxisSize.min;
      case SizeType.max:
        return MainAxisSize.max;
      default:
        return MainAxisSize.min;
    }
  }

  MainAxisAlignment _changeMainAlign(mainAlign) {
    switch (mainAlign) {
      case MainAlignValues.start:
        return MainAxisAlignment.start;
      case MainAlignValues.end:
        return MainAxisAlignment.end;
      case MainAlignValues.center:
        return MainAxisAlignment.center;
      case MainAlignValues.space_between: //space_between
        return MainAxisAlignment.spaceBetween;
      case MainAlignValues.space_evenly: //space_around
        return MainAxisAlignment.spaceEvenly;
      case MainAlignValues.space_around: //space_evenly
        return MainAxisAlignment.spaceAround;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _changeCrossAlign(crossAlign) {
    switch (crossAlign) {
      case CrossAlignValues.start: //start
        return CrossAxisAlignment.start;
      case CrossAlignValues.end: //end
        return  CrossAxisAlignment.end;
      case CrossAlignValues.center: //center
        return  CrossAxisAlignment.center;
      case CrossAlignValues.stretch: //stretch
        return  CrossAxisAlignment.stretch;
      case CrossAlignValues.baseline:
        return  CrossAxisAlignment.baseline;
      default: ////start
        return  CrossAxisAlignment.start;
    }
  }
}
