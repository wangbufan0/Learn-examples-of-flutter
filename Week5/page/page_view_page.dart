import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layouts_exampls/constant/constant.dart';
import 'package:flutter_layouts_exampls/view/indicator.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///

const _IMAGES=[
 'assets/pic_01.jpg',
 'assets/pic_02.jpg',
 'assets/pic_03.jpg',
 'assets/pic_04.jpg',
 'assets/pic_05.jpg',
];


class PageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageViewPageState();
  }
}

class PageViewPageState extends State<PageViewPage> {
  final PageController _controller = PageController(initialPage: 200);
  final StreamController<int> indicatorStream=StreamController();
  Timer autoNext;

  @override
  void initState() {
    super.initState();
    autoNext=Timer.periodic(Duration(seconds: 3), (timer){
      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    });
  }


  @override
  void dispose() {
    indicatorStream.close();
    autoNext.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BOTTOM_TITLES[ItemType.page_view.index]),
      ),
      body: SizedBox(
        height: 250,
        child: Container(
          color: Colors.grey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PageView.builder(
                  controller: _controller,
                  onPageChanged: (index){
                    indicatorStream.add(index);
                  },
                  itemBuilder: (context,index){
                    return Image.asset(_IMAGES[index%5]);
                  }
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: StreamBuilder(
                  stream: indicatorStream.stream,
                  initialData: 0,
                  builder: (context,snapshot){
                    return Indicator(
                      itemChosen: snapshot.data,
                      itemCount: 5,
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
