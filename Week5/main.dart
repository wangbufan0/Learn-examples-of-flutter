import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layouts_exampls/bloc/theme_color_bloc.dart';
import 'package:flutter_layouts_exampls/my_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider<ThemeColorBloc>(
      create: (context)=>ThemeColorBloc(),
      child: BlocBuilder<ThemeColorBloc,Color>(
        builder: (context,color){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: color,
                 primaryColor: Colors.grey[400],
                iconTheme: IconThemeData(color: color)
            ),
            home: MyMain(),
          );
        },
      ),
    );



  }
}
