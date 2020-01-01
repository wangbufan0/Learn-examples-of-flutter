import 'package:flutter_app_week6/user_api_provider.dart';
import 'package:flutter_app_week6/user_response_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class UserRepository{
  UserApiProvider _apiProvider=UserApiProvider();

  Future<UserResponseEntity> getUser(){
    return _apiProvider.getUser();
  }

}


