import 'package:flutter/material.dart';
import 'package:flutter_week2/week2/day1/button.dart';
import 'package:flutter_week2/week2/day1/image.dart';
import 'package:flutter_week2/week2/day1/text.dart';
import 'package:flutter_week2/week2/day2/check.dart';
import 'package:flutter_week2/week2/day2/form.dart';
import 'package:flutter_week2/week2/day2/text_edit.dart';
import 'package:flutter_week2/week2/day3/column.dart';
import 'package:flutter_week2/week2/day3/progress.dart';
import 'package:flutter_week2/week2/day3/row.dart';
import 'package:flutter_week2/week2/day4/align.dart';
import 'package:flutter_week2/week2/day4/flex.dart';
import 'package:flutter_week2/week2/day4/stack.dart';
import 'package:flutter_week2/week2/day4/wrap.dart';
import 'package:flutter_week2/week2/day5/decorated_box.dart';
import 'package:flutter_week2/week2/day5/padding.dart';
import 'package:flutter_week2/week2/day5/size_box.dart';
import 'package:flutter_week2/week3/day1/container.dart';
import 'package:flutter_week2/week3/day1/scaffold.dart';
import 'package:flutter_week2/week3/day1/transform.dart';
import 'package:flutter_week2/week3/day2/clip.dart';
import 'package:flutter_week2/week3/day2/list_view/list_view_home.dart';
import 'package:flutter_week2/week3/day2/single_child_scroll_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        'text_page': (context) => TextRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Wrap(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          direction: Axis.horizontal,
          spacing: 10,
          runSpacing: 8,
          children: <Widget>[
            RaisedButton(
              child: Text('Text'),
              onPressed: () {
                Navigator.pushNamed(context, 'text_page');
              },
            ),
            RaisedButton(
              child: Text('Button'),
              onPressed: () => ButtonRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Image'),
              onPressed: () => ImageRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Check'),
              onPressed: () => CheckRoute.launch(context),
            ),
            RaisedButton(
              child: Text('TextEdit'),
              onPressed: () => TextEditRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Form'),
              onPressed: () => FormRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Progress'),
              onPressed: () => ProgressRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Row'),
              onPressed: () => RowRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Column'),
              onPressed: () => ColumnRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Flex'),
              onPressed: () => FlexRoute.launch(context),
            ),
            RaisedButton(
              child: Text('wrap'),
              onPressed: () => WrapRoute.launch(context),
            ),
            RaisedButton(
              child: Text('stack'),
              onPressed: () => StackRoute.launch(context),
            ),
            RaisedButton(
              child: Text('align'),
              onPressed: () => AlignRoute.launch(context),
            ),
            RaisedButton(
              child: Text('padding'),
              onPressed: () => PaddingRoute.launch(context),
            ),
            RaisedButton(
              child: Text('SizeBox'),
              onPressed: () => SizeBoxRoute.launch(context),
            ),
            RaisedButton(
              child: Text('DecoratedBox'),
              onPressed: () => DecoratedBoxRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Transform'),
              onPressed: () => TransformRoute.launch(context),
            ),
            RaisedButton(
              child: Text('container'),
              onPressed: () => ContainerRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Scaffold'),
              onPressed: () => ScaffoldRoute.launch(context),
            ),
            RaisedButton(
              child: Text('Clip'),
              onPressed: () => ClipTestRoute.launch(context),
            ),
            RaisedButton(
              child: Text('ScrollView'),
              onPressed: () => SingleChildScrollViewTextRoute.launch(context),
            ),
            RaisedButton(
              child: Text('ListView'),
              onPressed: () => ListViewHomeRoute.launch(context),
            ),
          ],
        ),
      ),
    );
  }
}
