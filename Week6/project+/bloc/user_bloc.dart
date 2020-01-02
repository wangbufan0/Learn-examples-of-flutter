import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_week6/bloc/user_state.dart';
import 'package:flutter_app_week6/dio/request.dart';
import 'package:flutter_app_week6/dio/user_api_provider.dart';
import 'package:flutter_app_week6/dio/user_response_entity.dart';


///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class GetUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserBloc extends Bloc<GetUserEvent, GetUserState> {
  @override
  GetUserState get initialState => GetUserState.initial();

  @override
  Stream<GetUserState> mapEventToState(GetUserEvent event) async* {
    ResultData result = await UserApiProvider.getUser();
    if (result.result) {
      yield GetUserSuccessState(
          users: UserResponseEntity().fromJson(result.data));
    } else {
      yield GetUserErrorState(error: result.data.toString());
    }
  }
}
