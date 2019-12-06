import 'package:flutter/cupertino.dart';

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  final T data;


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}


