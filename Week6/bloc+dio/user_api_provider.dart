import 'package:dio/dio.dart';
import 'package:flutter_app_week6/generated/json/base/json_convert_content.dart';
import 'package:flutter_app_week6/user_response_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class UserApiProvider{
  final String  _endPoint="https://randomuser.me/api/";
  final Dio _dio=Dio();

  Future<UserResponseEntity> getUser()async{
    try{
      Response response=await _dio.get(_endPoint);
      return UserResponseEntity().fromJson(response.data);
    }catch (error,stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponseEntity().withError("$error");
    }

  }


}


