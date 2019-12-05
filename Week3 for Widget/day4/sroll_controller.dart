import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SrollControllerRoute extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SrollControllerRoute()));
  }

  @override
  State createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<SrollControllerRoute> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Controller'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemExtent: 50,
          itemCount: 100,
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
