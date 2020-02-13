import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stagger_animate_widget.dart';

///
/// author：wangbufan
/// time: 2020/2/3
/// email: wangbufan00@gmail.com
///

class StaggerPage extends StatefulWidget {
  static launch(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StaggerPage()));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StaggerPageState();
  }
}

class _StaggerPageState extends State<StaggerPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
  }

  _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAnimation,
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimationWidget(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}
