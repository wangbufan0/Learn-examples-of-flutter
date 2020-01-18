import 'package:equatable/equatable.dart';

///
/// author：wangbufan
/// time: 2020/1/3
/// email: wangbufan00@gmail.com
///


abstract class BaseState extends Equatable{

  const BaseState();
  ///初始化
  BaseState initial();
}

