

网络包Dio的使用，并尝试封装基类BasePage，使用到Bloc和Dio。



# 1. Dio

DIo包的[pub地址](https://pub.dev/packages/dio)，他是一个十分强大方便的库，我使用这个库做网络请求，他的简单实用在pub上有，主要记录一下在应用中的封装。

首先是Dio实例应该是单例模式会比较好，并且在实例初始化的时候，可以添加拦截器，将请求和返回数据进行打印。

```dart
class Request {
  static String _baseUrl = "https://randomuser.me/api/";
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
}
```

新建类接受返回的的数据。

```dart
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
```

最会就是网络的处理，这几个方法放在request类内。

```dart
static get({
    @required url,
    param,
  }) async {
    return await request(_baseUrl + url, param, null, Options(method: "GET"));
  }

  static post({
    @required url,
    param,
  }) async {
    return await request(_baseUrl + url, param, null, Options(method: 'POST'));
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
	//请求成功处理
    if (option.contentType != null && option.contentType == "text") {
          return ResultData(response.data, true, Code.SUCCESS);
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
          return ResultData(response.data, true, Code.SUCCESS,
                            headers: response.headers);
    }
   return ResultData(response.data, false, response.statusCode,
                        headers: response.headers);
  }
```

这样封装完成后，就可以通过request的get或者post方法快捷的进行网络请求。

# 2. BasePage

对于基类的封装想了很久，怎样才可以最方便的调用，然后再向其中加入了loading界面。其中的解释直接注释在了代码里面。

```dart
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// author：wangbufan
/// time: 2020/1/12
/// email: wangbufan00@gmail.com
///

abstract class BasePage<T extends BasePage<T, B>, B extends Bloc>
    extends StatefulWidget {
  static launch(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  //页面实体
  Widget getBody(BuildContext context);

  //标题，如果置空隐藏标题
  String get barTile;

  //bloc
  B bloc;

  //初始化
  void onCreate(BuildContext context) {}

  //销毁时
  void onDestroy(BuildContext context) {}

  //获取数据
  void loadData({int i});

  //获得标题实体
  Widget getBar(context) {
    return barTile == null
        ? null
        : AppBar(
            title: Text(barTile),
          );
  }

  //加载中的界面
  Widget getLoadingWidget(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading data ...',
            style: Theme.of(context).textTheme.subtitle,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  //加载失败界面
  Widget getErrorWidget(String error) {
    return Container(
      color: Colors.deepOrange,
      child: InkWell(
        onTap: () => loadData(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Error occured: $error，click to retry'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State createState() => _BasePageState<T, B>();
}

class _BasePageState<T extends BasePage<T, B>, B extends Bloc>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.bloc = BlocProvider.of<B>(context);
    widget.onCreate(context);
  }

  @override
  void dispose() {
    widget.onDestroy(context);
    widget.bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: widget.getBar(context),
      body: widget.getBody(context),
    );
  }
}
```

# 3. How to use

使用request的baseurl作请求，它返回的数据是一个虚假的名片信息，对这个数据进行请求和展示。

## 3.1. 生成数据类

根据请求数据格式生成数据类，我使用的是插件FlutterJsonBeanFactory，一般需要生成的数据类包含fromJson方法。

## 3.2. UserApiProvider

具体的网络请求再次包装起来，方便调用更改。

```dart

import 'package:flutter_app_week6/base/request.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

class UserApiProvider {
  static getUser() async {
    return Request.get(url:'',param: []);
  }
}
```

## 3.3. UserState

UserState就是请求的数据，具有三个状态，loading、error、success。

```dart

import 'package:flutter_app_week6/base/bloc/base_state.dart';

///
/// author：wangbufan
/// time: 2020/1/2
/// email: wangbufan00@gmail.com
///

enum UserStateValues {
  loading,
  error,
  success,
}

// ignore: must_be_immutable
class UserState extends BaseState {

  UserStateValues state;
  var data;

  UserState({this.state,this.data});

  @override
  BaseState initial() {
    state=UserStateValues.loading;
    data=null;
    return this;
  }

  @override
  List<Object> get props => [state,data];
}
```

## 3.4. UserBloc

根据请求道德数据抛出三种状态。

```dart
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
    yield UserState().initial();
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
```

## 3.5. Userpage

实即页面，继承实现BasePage

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_week6/base/page/base_page.dart';
import 'package:flutter_app_week6/user/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_state.dart';
import 'dio/response/user_response_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/12
/// email: wangbufan00@gmail.com
///

class UserPage extends BasePage<UserPage, UserBloc> {
  static launch(BuildContext context) {
    BasePage.launch(context,
            (context) =>
            BlocProvider<UserBloc>(
              create: (context) => UserBloc(),
              child: UserPage(),
            ));
  }
    
  @override
  void onCreate(BuildContext context) {
    loadData();
  }

  Widget getUserWidget(context,List<UserResponseResults> data) {
    UserResponseResults user = data[0];
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user.picture.large),
            ),
            Text(
              "${user.name.first} ${user.name.last}",
              style: Theme.of(context).textTheme.title,
            ),
            Text(user.email, style: Theme.of(context).textTheme.subtitle),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(user.location.city, style: Theme.of(context).textTheme.body1),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(user.location.state, style: Theme.of(context).textTheme.body1),
          ],
        ));
  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
      child: BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.state == UserStateValues.loading) {
            return getLoadingWidget(context);
          } else if (state.state == UserStateValues.success) {
            return getUserWidget(context,state.data);
          } else if (state.state == UserStateValues.error) {
            return getErrorWidget(state.data);
          } else {
            return getErrorWidget("未知错误");
          }
        },
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.7],
          colors: [
            Color(0xFFF12711),
            Color(0xFFf5af19),
          ],
        ),
      ),
    );
  }

  @override
  void loadData({int i}) {
    bloc.add(GetUserEvent());
  }

  @override
  // TODO: implement barTile
  String get barTile =>'UserPage';
}
```



