
import 'package:flutter_app_week6/dio/request.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class UserApiProvider {
  static getUser() async {
    return Request.get('', []);
  }
}
