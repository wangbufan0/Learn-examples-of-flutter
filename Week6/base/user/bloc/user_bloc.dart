import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_week6/user/bloc/user_state.dart';
import 'package:flutter_app_week6/base/request.dart';
import 'package:flutter_app_week6/user/dio/response/user_response_entity.dart';
import 'package:flutter_app_week6/user/dio/user_api_provider.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class GetUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserBloc extends Bloc<GetUserEvent, UserState> {
  @override
  UserState get initialState => UserState().initial();

  @override
  Stream<UserState> mapEventToState(GetUserEvent event) async* {
    ResultData result = await UserApiProvider.getUser();
    if (result.result) {
      var data = UserResponseEntity().fromJson(result.data);
      yield UserState(
        state: UserStateValues.success,
        data: data.results,
      );
    } else {
      var data = result.data.toString();
      yield UserState(
        state: UserStateValues.error,
        data: data,
      );
    }
  }
}
