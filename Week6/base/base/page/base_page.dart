import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// author：wangbufan
/// time: 2020/1/3
/// email: wangbufan00@gmail.com
///

abstract  class BasePage extends StatefulWidget {

  BasePageState getState();

  @override
  State<StatefulWidget> createState() =>getState();
}

abstract class BasePageState<T extends BasePage,B extends Bloc> extends State<T>{

  @override
  void initState() {
    super.initState();
    onCreate();
  }


  @override
  void dispose() {
    onDestroy();
    super.dispose();
  }
  onDestroy(){

  }
  void onCreate();
  String get barTile;
  Bloc get getBloc;
  Widget getBody();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(barTile),
      ),
      body: BlocProvider<B>(
        create: (context)=>getBloc,
        child: getBody(),
      ),
    );
  }
}




