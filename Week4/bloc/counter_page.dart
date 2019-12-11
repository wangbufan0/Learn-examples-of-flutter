


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';

class CounterPage extends StatelessWidget{

  static void launch(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context)=>CounterPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text('Counter'),),
        body: BlocBuilder<CounterBloc,int>(
          builder: (context,count){
            return Center(
              child: Text('$count',style: TextStyle(fontSize: 24),),
            );
          },
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: FloatingActionButton(
                heroTag: 'btn1',
                child: Icon(Icons.add),
                onPressed: (){
                  BlocProvider.of<CounterBloc>(context).add(CounterEvent.decrement);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: FloatingActionButton(
                heroTag: 'btn2',
                child: Icon(Icons.remove),
                onPressed: (){
                  BlocProvider.of<CounterBloc>(context).add(CounterEvent.increment);
                },
              ),
            ),
          ],
        ),
      );
  }
}