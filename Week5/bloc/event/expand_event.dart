import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///
///time:  2019/12/19
///author: wangbufan
///email: wangbufan00@gmail.com
///  

abstract class ExpandEvent extends Equatable{

  const ExpandEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OneFlexChanged extends ExpandEvent{
  final int oneFlex;
  const OneFlexChanged({@required this.oneFlex});
  @override
  // TODO: implement props
  List<Object> get props => [oneFlex];
}
class  TwoFlexChanged extends ExpandEvent{
  final int twoFlex;
  const TwoFlexChanged({@required this.twoFlex});
  @override
  // TODO: implement props
  List<Object> get props => [twoFlex];
}

enum ArrangeTypeValues { Row, Column }

class ArrangeTypeChanged extends ExpandEvent{
  final ArrangeTypeValues type;
  const ArrangeTypeChanged({@required this.type});
  @override
  // TODO: implement props
  List<Object> get props => [type];
}