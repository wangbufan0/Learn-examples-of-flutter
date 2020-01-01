import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_week6/user_response_entity.dart';
import 'package:flutter_app_week6/user_respository.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class GetUserEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetUserState extends Equatable{

  UserResponseEntity users;

  GetUserState({this.users});

  factory GetUserState.initial(){
    return GetUserState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [users];
}

class UserBloc extends Bloc<GetUserEvent,GetUserState>{
  @override
  GetUserState get initialState => GetUserState.initial();

  @override
  Stream<GetUserState> mapEventToState(GetUserEvent event) async*{
    UserResponseEntity users= await UserRepository().getUser();
    yield GetUserState(users: users);
  }

}


