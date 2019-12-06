

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';



class DialogTestRoute extends StatefulWidget {


  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
        builder: (context)=>DialogTestRoute()
    ));
  }


  @override
  State createState() {
    return _DialogTestRouteState();
  }

}

class _DialogTestRouteState extends State<DialogTestRoute>{

  int  count=0;

  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }


  Future<String> changeLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      return "选择了：${i == 1 ? "中文简体" : "美国英语"}";
    }
    return null;
  }


  Future<String> showListDialog() async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      return "点击了：$index";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('InheritedWidget Route')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('对话框1'),
              onPressed: ()async{
                bool delete = await showDeleteConfirmDialog1();
                if(delete==null)
                  Toast.show('取消删除', context);
                else
                  Toast.show('已确认删除', context);
              },
            ),
            RaisedButton(
              child: Text('选择语言'),
              onPressed: ()async{
                String str = await changeLanguage();
                if(str==null)
                  Toast.show('取消选择', context);
                else
                  Toast.show(str, context);
              },
            ),
            RaisedButton(
              child: Text('列表Dialog'),
              onPressed: ()async{
                String str = await showListDialog();
                if(str==null)
                  Toast.show('取消选择', context);
                else
                  Toast.show(str, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}