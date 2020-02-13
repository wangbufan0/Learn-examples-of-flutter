import 'package:flutter/material.dart';

import 'hero_animate_page_b.dart';

///
/// author：wangbufan
/// time: 2020/2/3
/// email: wangbufan00@gmail.com
///

class HeroAnimatePage extends StatelessWidget {
  static launch(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HeroAnimatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: 'avatar',
            child: ClipOval(
              child: Image.asset('images/girl.jpg'),
            ),
          ),
          onTap: () {
            HeroAnimatePageB.launch(context);
          },
        ),
      ),
    );
  }
}
