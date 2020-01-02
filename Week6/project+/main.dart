import 'package:flutter/material.dart';
import 'package:flutter_app_week6/bloc/user_bloc.dart';
import 'package:flutter_app_week6/dio/user_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: TextTheme(
            title: TextStyle(fontSize: 30, color: Colors.white),
            subtitle: TextStyle(fontSize: 20, color: Colors.white),
            body1: TextStyle(fontSize: 15, color: Colors.white)),
      ),
      home: BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _myHomePageState();
  }
}

class _myHomePageState extends State<MyHomePage> {
  Widget _buildLoadingWidget() {
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

  Widget _buildUserWidget(List<UserResponseResults> data) {
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BlocBuilder<UserBloc, GetUserState>(
        builder: (context, state) {
          if (state is GetUserLoadingState) {
            return _buildLoadingWidget();
          } else if (state is GetUserSuccessState) {
            return _buildUserWidget(state.users.results);
          } else if (state is GetUserErrorState) {
            return _buildErrorWidget(state.error);
          } else {
            return _buildErrorWidget("出错");
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
    ));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }
}
