

import 'package:bloc/src/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_week6/base/page/base_page1.dart';
import 'package:flutter_app_week6/user/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_state.dart';
import 'dio/response/user_response_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/12
/// email: wangbufan00@gmail.com
///

class UserPage1 extends BasePage1<UserPage1,UserBloc>{
  static launch(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserPage1()));
  }


  Widget _buildLoadingWidget(context) {
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

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('Error occured: $error')],
      ),
    );
  }

  Widget _buildUserWidget(context,List<UserResponseResults> data) {
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
  Widget getBody(context) {
    return Container(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.state == UserStateValues.loading) {
            BlocProvider.of<UserBloc>(context).add(GetUserEvent());
            return _buildLoadingWidget(context);
          } else if (state.state == UserStateValues.success) {
            return _buildUserWidget(context,state.data);
          } else if (state.state == UserStateValues.error) {
            return _buildErrorWidget(state.data);
          } else {
            return _buildErrorWidget("未知错误");
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
  // TODO: implement barTile
  String get barTile => 'UserPage';

  @override
  // TODO: implement getBloc
  Bloc get getBloc => UserBloc();

  @override
  void onCreate(BuildContext context) {
//    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }

}


