import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/base/page/base_page.dart';
import 'package:flutter_app/translation/bloc/translation_bloc.dart';
import 'package:flutter_app/translation/sql/history_sql_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sql/history_data.dart';

///
/// author：wangbufan
/// time: 2020/1/18
/// email: wangbufan00@gmail.com
///

var TranslationLanguage = [
  '自动检测',
  '中文',
  '英文',
  '粤语',
  '文言文',
  '日语',
];

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
  TranslationHistoryProvider provider;
  SharedPreferences sp;

  @override
  void onCreate(BuildContext context) async {
    super.onCreate(context);
    qController = TextEditingController();
    provider = TranslationHistoryProvider();
    sp = await SharedPreferences.getInstance();
    await provider.open('history_db3.db');
    bloc.add(TranslationHistoryEvent(
      provider: provider,
      sp: sp,
    ));
  }

  @override
  void onDestroy(BuildContext context) {
    provider.close();
    super.onDestroy(context);
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
          bloc.add(TranslationNewDataEvent(q: s, provider: provider));
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

  Widget getHistoryBody(context, List<HistoryData> historys) {
    return SliverFixedExtentList(
      itemExtent: 80,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var data = historys[historys.length - index - 1];
          return Card(
            child: ListTile(
              title: Text(data.src),
              subtitle: Text(data.dst),
              onTap: () {
                bloc.add(TranslationCheckHistoryEvent(
                  data: data,
                  sp: sp,
                  provider: provider,
                ));
              },
            ),
          );
        },
        childCount: historys.length,
      ),
    );
  }

  List<DropdownMenuItem> getHeadItem(List<String> values) {
    return values
        .map((value) => DropdownMenuItem(
              value: values.indexOf(value),
              child: Text(
                value,
                style: TextStyle(color: Colors.blue),
              ),
            ))
        .toList();
  }

  Widget getHeadBody(TranslationState state) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DropdownButton(
            value: state.from,
            items: getHeadItem(TranslationLanguage),
            onChanged: (value) {
              bloc.add(TranslationFromToEvent(
                provider: provider,
                from: value,
                to: state.to,
                q: qController.text,
                sp: sp,
              ));
            },
            underline: Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.swap_horiz,
              color: state.canExchange ? Colors.blue : Colors.grey,
            ),
            onPressed: state.canExchange
                ? () {
                    bloc.add(TranslationFromToEvent(
                      provider: provider,
                      from: state.to + 1,
                      to: state.from - 1,
                      q: qController.text,
                      sp: sp,
                    ));
                  }
                : null,
          ),
          DropdownButton(
            value: state.to,
            items: getHeadItem(TranslationLanguage.sublist(1)),
            onChanged: (value) {
              bloc.add(TranslationFromToEvent(
                provider: provider,
                from: state.from,
                to: value,
                q: qController.text,
                sp: sp,
              ));
            },
            underline: Container(
              height: 1,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.transparent,
                width: 0,
              ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return WillPopScope(
      onWillPop: () async {
        if (qController.text.isNotEmpty) {
          qController.text = '';
          bloc.add(TranslationNewDataEvent(
            q: qController.text,
          ));
          return false;
        } else {
          return true;
        }
      },
      child: BlocBuilder<TranslationBloc, TranslationState>(
        builder: (BuildContext context, TranslationState state) {
          qController.text = state.q;
          return Container(
            color: Colors.grey[100],
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  sliver: getHeadBody(state),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  sliver: SliverToBoxAdapter(
                    child: getQBody(context),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  sliver: state.isShowResult
                      ? SliverToBoxAdapter(
                          child: getResultBody(context, state.result),
                        )
                      : getHistoryBody(context, state.historys),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void loadData({
    int i,
  }) {}
}
