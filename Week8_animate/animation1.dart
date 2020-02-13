import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/1/30
/// email: wangbufan00@gmail.com
///

class SizeAnimated extends AnimatedWidget {
  SizeAnimated({Key key, Animation<double> animation,this.child})
      : super(key: key, listenable: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        width: animation.value,
        child: child,
      ),
    );
  }
}

class Animation1Page extends StatefulWidget {
  static launch(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => Animation1Page(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<Animation1Page>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeAnimated(
        animation: animation,
        child: Image.asset('images/girl.jpg'),
      ),
//      body: AnimatedBuilder(
//          animation: animation,
//          builder: (context, child) {
//            return Center(
//              child: Container(
//                color: Colors.grey,
//                width: animation.value,
//                child: Image.asset('images/girl.jpg'),
//              ),
//            );
//          }),
    );
  }
}
