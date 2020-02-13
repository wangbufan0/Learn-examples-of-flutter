import 'package:flutter/material.dart';

import 'fade_route.dart';

///
/// author：wangbufan
/// time: 2020/2/2
/// email: wangbufan00@gmail.com
///

class PageRouteAnimatePage extends StatelessWidget {
  static launch(BuildContext context) {
    Navigator.push(
      context,
//      PageRouteBuilder(
//        transitionDuration: Duration(milliseconds: 500),
//        pageBuilder: (context, animate, secondaryAnimation) {
//          return FadeTransition(
//            opacity: animate,
//            child: PageRouteAnimatePage(),
//          );
//        },
//      ),
    FadeRoute(builder: (context)=>PageRouteAnimatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}
