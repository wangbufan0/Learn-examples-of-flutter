import 'package:equatable/equatable.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///

class PaddingState extends Equatable {
  final double left;
  final double right;
  final double top;
  final double bottom;

  PaddingState(this.left, this.right, this.top, this.bottom);

  factory PaddingState.initial() {
    return PaddingState(0, 0, 0, 0);
  }

  PaddingState copyWith({
    double left,
    double right,
    double top,
    double bottom,
  }) {
    return PaddingState(left ?? this.left, right ?? this.right, top ?? this.top,
        bottom ?? this.bottom);
  }

  @override
  List<Object> get props => [left, right, top, bottom];
}
