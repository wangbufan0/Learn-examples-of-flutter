import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///

enum LayType {
  row,
  column,
}
enum SizeType {
  min,
  max,
}
enum MainAlignValues {
  start,
  end,
  center,
  space_between,
  space_around,
  space_evenly,
}
enum CrossAlignValues {
  start,
  end,
  center,
  stretch,
  baseline,
}

abstract class RowColumnEvent extends Equatable {
  const RowColumnEvent();

  @override
  List<Object> get props => [];
}

class LayoutChanged extends RowColumnEvent {
  final LayType layType;

  const LayoutChanged({@required this.layType});

  @override
  List<Object> get props => [layType];
}

class SizeChanged extends RowColumnEvent {
  final SizeType sizeType;

  const SizeChanged({@required this.sizeType});

  @override
  // TODO: implement props
  List<Object> get props => [sizeType];
}

class MainAlignChanged extends RowColumnEvent{
  final MainAlignValues mainAlignValues;

  const MainAlignChanged({@required this.mainAlignValues});
  @override
  // TODO: implement props
  List<Object> get props => [mainAlignValues];
}

class CrossAlignChanged extends RowColumnEvent{
  final CrossAlignValues crossAlignValues;
  const CrossAlignChanged({@required this.crossAlignValues});
  @override
  // TODO: implement props
  List<Object> get props => [crossAlignValues];
}
