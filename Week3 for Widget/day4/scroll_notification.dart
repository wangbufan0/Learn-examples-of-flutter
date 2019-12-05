import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollNotificationTestRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ScrollNotificationTestRoute()));
  }

  @override
  State createState() => _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = '0%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scroll Controller'),
        ),
        body: Scrollbar(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              double progress = notification.metrics.pixels /
                  notification.metrics.maxScrollExtent;
              setState(() {
                _progress = '${(progress * 100.0).toInt()}%';
              });
              print('BottomEdge: ${notification.metrics.extentAfter == 0}');
              return true;
           },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                    );
                  },
                  itemCount: 100,
                  itemExtent: 50,
                ),
                CircleAvatar(
                  radius: 30,
                  child: Text(_progress),
                  backgroundColor: Colors.black54,
                )
              ],
            ),
          ),
        ));
  }
}
