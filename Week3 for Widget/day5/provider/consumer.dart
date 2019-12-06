

import 'package:flutter/cupertino.dart';
import 'package:flutter_week2/week3/day5/provider/change_notifier_provider.dart';

class Consumer<T> extends StatelessWidget{


  Consumer({
    Key key,
    @required this.builder,
    this.child
});

  final Widget child;
  final Widget Function(BuildContext context,T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context)
    ) ;
  }
}