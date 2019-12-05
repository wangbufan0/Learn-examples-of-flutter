import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewRoute extends StatelessWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GridViewRoute()));
  }

  Widget divider1 = Divider(
    color: Colors.blue,
  );
  Widget divider2 = Divider(
    color: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Separated'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 220,
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //横轴三个子widget
                    childAspectRatio: 1.0 //宽高比为1时，子widget
                    ),
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast)
                ]),
          ),
          SizedBox(
            height: 220,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120.0, childAspectRatio: 2.0 //宽高比为2
                  ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            ),
          ),
          SizedBox(
              height: 120,
              child: GridView.extent(
                maxCrossAxisExtent: 120.0,
                childAspectRatio: 2.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              )),
        ],
      ),
    );
  }
}
