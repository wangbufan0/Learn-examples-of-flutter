import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/3
/// email: wangbufan00@gmail.com
///

class StaggerAnimationWidget extends StatelessWidget {
  StaggerAnimationWidget({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(begin: .0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 1.0, curve: Curves.ease),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
