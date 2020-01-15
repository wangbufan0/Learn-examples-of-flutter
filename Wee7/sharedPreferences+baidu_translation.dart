import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initCounter();
  }

  _initCounter() async {
    prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('counter') ?? 0;
    setState(() {});
  }

  void _incrementCounter() async {
    _counter += 1;
    await prefs.setInt('counter', _counter);
    setState(() {});
  }

  _getTranslation() async {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
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
    String path = 'http://fanyi-api.baidu.com/api/trans/vip/translate';
    String appid = '20190602000304123';
    String q = 'apple';
    String salt = DateTime.now().millisecondsSinceEpoch.toString();
    String securityKey = "13h2Q37ayuJy_kAxkkER";
    var params = Map<String, String>();
    params['q'] = q;
    params['from'] = 'en';
    params['to'] = 'zh';
    params['appid'] = appid;
    params['salt'] = salt;
    String src = appid + q + salt + securityKey;
    params['sign'] = md5.convert(utf8.encode(src)).toString();
    var options = Options(contentType: 'application/x-www-form-urlencoded');
    Response response = await dio.post(
      path,
      data: params,
      options: options,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              child: Text('translation'),
              onPressed: () {
                _getTranslation();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
