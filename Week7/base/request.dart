import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}

///网络请求错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;
}

class Request {
  static String _baseUrl = "http://fanyi-api.baidu.com/api/trans/vip/translate";
  static Dio _dio;
  static int _sendTimeout = 5000;

  static int _receiveTimeout = 5000;

  Request._();

  static Dio get dio {
    if (_dio == null) {
      _dio = new Dio();
      // 添加拦截器
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("\n================== 请求数据 ==========================");
          print("url = ${options.uri.toString()}");
          print("headers = ${options.headers}");
          print("params = ${options.data}");
        },
        onResponse: (Response response) {
          print("\n================== 响应数据 ==========================");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print("\n");
        },
        onError: (DioError e) {
          print("\n================== 错误响应数据 ======================");
          print("type = ${e.type}");
          print("message = ${e.message}");
          print("\n");
        },
      ));
    }
    return _dio;
  }

  static get({
    @required url,
    param,
  }) async {
    return await request(
      _baseUrl + url,
      param,
      null,
      Options(method: "GET"),
    );
  }

  static post({
    @required url,
    param,
  }) async {
    return await request(
        _baseUrl + url,
        param,
        {'content-type': 'application/x-www-form-urlencoded'},
        Options(
          method: 'POST',
        ));
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static request(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData("无网络", false, Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.receiveTimeout = _receiveTimeout;
    option.sendTimeout = _sendTimeout;

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse = e.response ?? Response(statusCode: 666);
      return ResultData(e, false, errorResponse.statusCode);
    }

    try {
      if (option.contentType != null && option.contentType == "text") {
        return ResultData(response.data, true, Code.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return ResultData('未知错误', false, response.statusCode);
  }
}
