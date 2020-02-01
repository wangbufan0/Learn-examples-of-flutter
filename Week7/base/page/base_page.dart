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
              Text('Error occured: $error'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State createState() => _BasePageState<T, B>();

  TickerProvider vsync;
}

class _BasePageState<T extends BasePage<T, B>, B extends Bloc>
    extends State<T> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    widget.bloc = BlocProvider.of<B>(context);
    widget.onCreate(context);
    widget.vsync=this;
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
