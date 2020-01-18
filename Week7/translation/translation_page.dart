import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/base/page/base_page.dart';
import 'package:flutter_app/translation/bloc/translation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// author：wangbufan
/// time: 2020/1/18
/// email: wangbufan00@gmail.com
///

class TranslationPage extends BasePage<TranslationPage, TranslationBloc> {
  static launch(BuildContext context) {
    BasePage.launch(context, (context) {
      return BlocProvider<TranslationBloc>(
        create: (context) => TranslationBloc(),
        child: TranslationPage(),
      );
    });
  }

  TextEditingController qController;
  TextEditingController resultController;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);
    qController = TextEditingController();
    resultController = TextEditingController();
  }

  @override
  // TODO: implement barTile
  String get barTile => 'Translation(baidu api)';

  Widget getQBody(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextField(
        maxLines: null,
        controller: qController,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            hintText: '点按输入',
            contentPadding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onSubmitted: (s) {
          bloc.add(TranslationEvent(s, 'en', 'zh'));
        },
      ),
    );
  }

  Widget getResultBody(context, String s) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.tightFor(
        width: double.infinity,
        height: 200,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(
        s,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (BuildContext context, TranslationState state) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '英语',
                    style: TextStyle(fontSize: 40),
                  ),
                  Icon(Icons.translate),
                  Text(
                    '中文',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: getQBody(context),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: state.result == null
                    ? null
                    : getResultBody(context, state.result),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                  (context,index){
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(state.historys[index].transResult[0].dst),
                          Text(state.historys[index].transResult[0].src),
                        ],
                      ),
                    );
                  },
                childCount: state.historys.length,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void loadData({int i}) {
    // TODO: implement loadData
  }
}
