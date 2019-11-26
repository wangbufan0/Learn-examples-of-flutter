

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormRoute extends StatefulWidget{

  static launch(BuildContext context){
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context)=>FormRoute()
      )
    );
  }


  @override
  State createState() {
    return _FormROuteState();
  }
}

class _FormROuteState extends State<FormRoute>{

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 24),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名和邮箱',
                  icon: Icon(Icons.person)
                ),
                validator: (v){
                  return v.trim().length>0?null:'用户名不能为空';
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '你的密码',
                  icon: Icon(Icons.lock)
                ),
                obscureText: true,
                validator: (v){
                  return v.trim().length>5?null:'密码不能小于6位';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Builder(builder: (context){
                  return RaisedButton(
                    padding: EdgeInsets.all(15),
                    child: Text('登录'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if(Form.of(context).validate()){
                        
                      }
                    }
                  );
                },),
//                child: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: RaisedButton(
//                        padding: EdgeInsets.all(15),
//                        child: Text('登录'),
//                        color: Theme.of(context).primaryColor,
//                        textColor: Colors.white,
//                        onPressed: (){
//                          if((_formKey.currentState as FormState).validate()){
//
//                          }
//                        },
//                      ),
//                    )
//                  ],
//                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}