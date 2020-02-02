import 'package:flutter/cupertino.dart';

///
/// author：wangbufan
/// time: 2020/2/2
/// email: wangbufan00@gmail.com
///

class FadeRoute extends PageRoute {
  FadeRoute({@required this.builder});

  final WidgetBuilder builder;

  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if(isActive){
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }else{
      return Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: child,
      );
    }
  }
}
