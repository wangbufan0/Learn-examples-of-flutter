import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// author：wangbufan
/// time: 2020/1/12
/// email: wangbufan00@gmail.com
///


abstract class BasePage1<T extends BasePage1<T,B>,B extends Bloc> extends StatefulWidget{


  Widget getBody(BuildContext context);
  String get barTile;
  Bloc get getBloc;
  void onCreate(BuildContext context);
  void onDestroy(BuildContext context){

  }
  Widget getBar(context){
    return barTile==null
        ?null
        : AppBar(
      title: Text(barTile),
    );
  }

  @override
  State createState() =>BasePage1State<T,B>();
}

class BasePage1State<T extends BasePage1<T,B>,B extends Bloc> extends State<T>{

  @override
  void initState() {
    super.initState();
    widget.onCreate(context);
  }

  @override
  void dispose() {
    widget.onDestroy(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: widget.getBar(context),
      body: BlocProvider<B>(
        create: (context)=>widget.getBloc,
        child: widget.getBody(context),
      ),
    );
  }

}

