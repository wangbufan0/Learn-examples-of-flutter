import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextEditRoute extends StatefulWidget {
  TextEditRoute({Key key}) : super(key: key);

  static launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TextEditRoute()));
  }

  @override
  State createState() => _TextEditRouteState();
}

class _TextEditRouteState extends State<TextEditRoute> {
  TextEditingController _unameController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();
//    _unameController.text = '1235';
    _unameController.addListener(() {
      print(_unameController.text);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Edit Route'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _unameController,
            autofocus: true,
            focusNode: focusNode1,
            decoration: InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮件',
                prefixIcon: Icon(Icons.person),
                border: InputBorder.none),
            onEditingComplete: () {
              if (null == focusScopeNode)
                focusScopeNode = FocusScope.of(context);
              focusScopeNode.requestFocus(focusNode2);
            },
          ),
          TextField(
            obscureText: true,
            focusNode: focusNode2,
            decoration: InputDecoration(
                labelText: '密码',
                hintText: '你的密码',
                prefixIcon: Icon(Icons.lock),
                border: InputBorder.none),
            onSubmitted: (value) {},
          ),
          Builder(builder: (context) {
            return Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('移动'),
                  onPressed: () {
                    if (null == focusScopeNode)
                      focusScopeNode = FocusScope.of(context);
                    focusScopeNode.requestFocus(focusNode2);
                  },
                ),
                RaisedButton(
                  child: Text('隐藏'),
                  onPressed: () {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                )
              ],
            );
          })
        ],
      ),
    );
  }
}
