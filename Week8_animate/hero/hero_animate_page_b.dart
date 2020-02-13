import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/3
/// email: wangbufan00@gmail.com
///

class HeroAnimatePageB extends StatelessWidget {
  static launch(BuildContext context) {
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (context, animation, secondAnimation) {
      return FadeTransition(
        opacity: animation,
        child: Scaffold(
          appBar: AppBar(
            title: Text('原图'),
          ),
          body: HeroAnimatePageB(),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar',
        child: Image.asset('images/girl.jpg'),
      ),
    );
  }
}
