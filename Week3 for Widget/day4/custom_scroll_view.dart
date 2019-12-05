import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewRoute extends StatelessWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CustomScrollViewRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('CustomScrollView Route'),
              background: Image.asset(
                './images/girl.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: new SliverGrid(
              delegate: new SliverChildBuilderDelegate(
                (context, index) {
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
            ),
          ),

          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
                (context,index){
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100*(index%9)],
                    child: Text('list item $index'),
                  );
                },
              childCount: 50
            ),
          )

        ],
      ),
    );
  }
}
