import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/12
/// email: wangbufan00@gmail.com
///

class AnimatedSwitcherPage extends StatefulWidget {
  @override
  State createState() => _AnimatedSwitcherPageState();
}

class _AnimatedSwitcherPageState extends State<AnimatedSwitcherPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child:  Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            _count+=1;
          });
        },
      ),
    );
  }
}
