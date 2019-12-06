import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareDateWidget extends InheritedWidget {
  ShareDateWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  static ShareDateWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDateWidget);
  }

  @override
  bool updateShouldNotify(ShareDateWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {


  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context)=>InheritedWidgetTestRoute()
    ));
  }


  @override
  State createState() {
    return _InheritedWidgetTestRouteState();
  }

}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute>{

  int  count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidget Route')
      ),
      body: ShareDateWidget(
        data: count,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            RaisedButton(
              child: Text('Increment'),
              onPressed: ()=> setState(()=>++count),
            )
          ],
        ),
      ),
    );
  }
}






class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDateWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Dependencies change');
  }
}


