import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/base/page/base_page.dart';
import 'package:flutter_app/translation/bloc/translation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void onCreate(BuildContext context) async {
    super.onCreate(context);
    qController = TextEditingController();
  }

  @override
  void onDestroy(BuildContext context) {
    super.onDestroy(context);
  }

  @override
  // TODO: implement barTile
  String get barTile => 'Translate (power by Baidu)';

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
    ///
    /// @author: wangbufan
    /// @function: 页面头，包含翻译源和目标语言
    ///
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: state.headPadding),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DropdownButton(
                value: state.from,
                items: getHeadItem(TranslationLanguage),
                iconEnabledColor: Colors.blue,
                onChanged: (value) {
                  bloc.add(TranslationFromToEvent(
                    from: value,
                    to: state.to,
                    q: qController.text,
                  ));
                },
                underline: Container(),
              ),
              IconButton(
                icon: Icon(
                  Icons.swap_horiz,
                  color: state.canExchange ? Colors.blue : Colors.grey,
                  size: 30,
                ),
                onPressed: state.canExchange
                    ? () {
                        bloc.add(TranslationFromToExchangeEvent(
                          q: qController.text,
                          vsync: vsync,
                        ));
                      }
                    : null,
              ),
              DropdownButton(
                value: state.to,
                items: getHeadItem(TranslationLanguage.sublist(1)),
                iconEnabledColor: Colors.blue,
                onChanged: (value) {
                  bloc.add(TranslationFromToEvent(
                    from: state.from,
                    to: value,
                    q: qController.text,
                  ));
                },
                underline: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getQBody(context) {
    ///
    /// @author: wangbufan
    /// @function: 输入框
    ///
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 1.0,
              ),
            ]),
        child: TextField(
          maxLines: null,
          controller: qController,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: '点按即可输入文本',
            contentPadding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          ),
          onSubmitted: (s) {
            bloc.add(TranslationNewDataEvent(
              q: s,
            ));
          },
        ),
      ),
    );
  }

  Widget getResultBody(context, String s) {
    ///
    /// @author: wangbufan
    /// @function: 翻译结果
    ///
    return SliverToBoxAdapter(
      child: Container(
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
      ),
    );
  }

  Widget getHistoryBody(context, List<HistoryData> historys) {
    ///
    /// @author: wangbufan
    /// @function: 翻译历史
    ///
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
                bloc.add(
                  TranslationCheckHistoryEvent(
                    data: data,
                  ),
                );
              },
            ),
          );
        },
        childCount: historys.length,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    ///
    /// @author: wangbufan
    /// @function: 拦截返返回键，当输入框不为空时不返回
    ///
    if (qController.text.isNotEmpty) {
      qController.text = '';
      bloc.add(TranslationNewDataEvent(
        q: qController.text,
      ));
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<TranslationBloc, TranslationState>(
        builder: (BuildContext context, TranslationState state) {
          if(qController!=null){
            qController.text = state.q;
          }
          return Container(
            color: Colors.grey[100],
            child: CustomScrollView(
              slivers: <Widget>[
                getHeadBody(state),
                getQBody(context),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  sliver: state.isShowResult
                      ? getResultBody(context, state.result)
                      : getHistoryBody(context, state.historys),
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
