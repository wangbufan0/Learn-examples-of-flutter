import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/list_bloc.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/list_selector.dart';

///
///time:  2019/12/24
///author: wangbufan
///email: wangbufan00@gmail.com
///

class User {
  User({this.name, this.email});

  final String name;
  final String email;
}

const USER_NAMES = [
  "Isa Tusa",
  "Racquel Ricciardi",
  "Teresita Mccubbin",
  "Rhoda Hassinger",
  "Carson Cupps",
  "Devora Nantz",
  "Tyisha Primus",
  "Muriel Lewellyn",
  "Hunter Giraud",
  "Corina Whiddon",
  "Meaghan Covarrubias",
  "Ulysses Severson",
  "Richard Baxter",
  "Alessandra Kahn",
  "Libby Saari",
  "Valeria Salvador",
  "Fredrick Folkerts",
  "Delmy Izzi",
  "Leann Klock",
  "Rhiannon Macfarlane",
];
const USER_EMAILS = [
  "isa.tusa@me.com",
  "racquel.ricciardi@me.com",
  "teresita.mccubbin@me.com",
  "rhoda.hassinger@me.com",
  "carson.cupps@me.com",
  "devora.nantz@me.com",
  "tyisha.primus@me.com",
  "muriel.lewellyn@me.com",
  "hunter.giraud@me.com",
  "corina.whiddon@me.com",
  "meaghan.covarrubias@me.com",
  "ulysses.severson@me.com",
  "richard.baxter@me.com",
  "alessandra.kahn@me.com",
  "libby.saari@me.com",
  "valeria.salvador@me.com",
  "fredrick.folkerts@me.com",
  "delmy.izzi@me.com",
  "leann.klock@me.com",
  "rhiannon.macfarlane@me.com",
];

class ListPage extends StatelessWidget {
  List<User> _users() {
    var list = List<User>();
    for (int i = 0; i < USER_NAMES.length; i++) {
      var user = User(name: USER_NAMES[i], email: USER_EMAILS[i]);
      list.add(user);
    }
    return list;
  }

  Widget _itemTitle(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name[0]),
      ),
    );
  }

  Widget _bodyContent(Axis state) {
    var users = _users();

    return ListView.builder(
        itemExtent: state == Axis.vertical ? 80 : 260,
        scrollDirection: state,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.brown,
            margin: state==Axis.vertical
                ? EdgeInsets.only(bottom: 1.0)
                : EdgeInsets.only(right: 1.0),
            child:  _itemTitle(users[index]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListBloc>(
      create: (context) => ListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(BOTTOM_TITLES[ItemType.list.index]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(SELECTOR_ONE_HEIGHT),
            child: ListSelector(),
          ),
        ),
        body: BlocBuilder<ListBloc, Axis>(
          builder: (context, state) {
            return Container(
              constraints: state == Axis.vertical
                  ? null
                  : BoxConstraints.tightForFinite(height: 80),
              child: Center(
                child: _bodyContent(state),
              ),
            );
          },
        ),
      ),
    );
  }
}
