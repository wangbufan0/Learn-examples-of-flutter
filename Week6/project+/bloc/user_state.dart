import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../dio/user_response_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///


abstract class GetUserState extends Equatable{

  const GetUserState();

  factory GetUserState.initial()=>GetUserLoadingState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
class GetUserLoadingState extends GetUserState{
}

class GetUserErrorState extends GetUserState{
  final String error;
  const GetUserErrorState({@required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class GetUserSuccessState extends GetUserState{
  final UserResponseEntity users;

  const GetUserSuccessState({@required this.users});
  @override
  // TODO: implement props
  List<Object> get props => [users];
}


