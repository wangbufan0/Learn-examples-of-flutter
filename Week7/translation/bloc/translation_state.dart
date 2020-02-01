import 'package:flutter_app/translation/sql/history_data.dart';

///
/// author：wangbufan
/// time: 2020/1/20
/// email: wangbufan00@gmail.com
///


class TranslationState {
  String q;
  String result;
  List<HistoryData> historys;
  int from;
  int to;
  bool isShowResult;
  bool canExchange;
  double headPadding;

  TranslationState({
    this.q,
    this.result,
    this.historys,
    this.from,
    this.to,
    this.isShowResult,
    this.canExchange,
    this.headPadding,
  });

  @override
  TranslationState initial() {
    q = '';
    result = '';
    historys = List<HistoryData>();
    from = 0;
    to = 0;
    isShowResult = false;
    canExchange = false;
    headPadding=20.0;
    return this;
  }

  TranslationState copyWith({
    String q,
    String result,
    List<HistoryData> historys,
    int from,
    int to,
    bool isShowResult,
    bool canExchange,
    double headPadding,
  }) {
    return TranslationState(
      q: q ?? this.q,
      result: result??this.result,
      historys: historys ?? this.historys,
      from: from ?? this.from,
      to: to ?? this.to,
      isShowResult: isShowResult ?? this.isShowResult,
      canExchange: canExchange ?? this.canExchange,
      headPadding: headPadding??this.headPadding,
    );
  }
}
