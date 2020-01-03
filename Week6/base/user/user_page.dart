

import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_week6/base/page/base_page.dart';
import 'package:flutter_app_week6/user/bloc/user_bloc.dart';

///
/// author：wangbufan
/// time: 2020/1/3
/// email: wangbufan00@gmail.com
///

class UserPage extends BasePage{

  static launch(context){
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context)=>UserPage()
    ));
  }

  @override
  BasePageState<BasePage, Bloc> getState() {
    return _UserPageState();
  }
}

class _UserPageState extends BasePageState<UserPage,UserBloc>{
  @override
  // TODO: implement barTile
  String get barTile => 'UserPage';

  @override
  // TODO: implement getBloc
  Bloc get getBloc => UserBloc();

  @override
  Widget getBody() {
    // TODO: implement getBody
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading data from API...',
            style: Theme.of(context).textTheme.subtitle,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }


}

