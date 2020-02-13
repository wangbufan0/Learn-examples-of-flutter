import 'package:flutter/material.dart';
import 'package:flutter_animate_app/aniated_switcher/animated_switcher_page.dart';

import 'animation1.dart';
import 'hero/hero_animate_page.dart';
import 'page_route_animate/page_route_animate_page.dart';
import 'stagger/stagger_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'animatedSwitcher':(context)=>AnimatedSwitcherPage(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () {
                Animation1Page.launch(context);
              },
              child: Text('Animation1'),
            ),
            RaisedButton(
              onPressed: () {
                PageRouteAnimatePage.launch(context);
              },
              child: Text('PageRoute Animate'),
            ),
            RaisedButton(
              onPressed: () {
                HeroAnimatePage.launch(context);
              },
              child: Text('Hero Animate'),
            ),
            RaisedButton(
              onPressed: () {
                StaggerPage.launch(context);
              },
              child: Text('Stagger'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('animatedSwitcher');
              },
              child: Text('Animated Switcher'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
