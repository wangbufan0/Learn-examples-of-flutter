import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_layouts_exampls/bloc/event/row_column_event.dart';


///
///time:  2019/12/18
///author: wangbufan
///email: wangbufan00@gmail.com
///

class RowColumnState extends Equatable {
  final LayType layType;
  final MainAxisSize size;
  final MainAxisAlignment mainAlign;
  final CrossAxisAlignment crossAlign;

  const RowColumnState(
      {@required this.layType,
      @required this.size,
      @required this.mainAlign,
      @required this.crossAlign});

  factory RowColumnState.initial() {
    return RowColumnState(
      layType: LayType.row,
      size: MainAxisSize.min,
      mainAlign: MainAxisAlignment.start,
      crossAlign: CrossAxisAlignment.start,
    );
  }

  RowColumnState copyWith({
    LayType layType,
    MainAxisSize size,
    MainAxisAlignment mainAlign,
    CrossAxisAlignment crossAlign,
  }) {
    return RowColumnState(
        layType: layType ?? this.layType,
        size: size ?? this.size,
        mainAlign: mainAlign ?? this.mainAlign,
        crossAlign: crossAlign ?? this.crossAlign);
  }

  @override
  List<Object> get props => [layType, size, mainAlign, crossAlign];
}
