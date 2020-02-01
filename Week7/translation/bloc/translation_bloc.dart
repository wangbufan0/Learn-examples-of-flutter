import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_app/translation/dio/translation_api_provider.dart';
import 'package:flutter_app/translation/dio/translation_entity.dart';
import 'package:flutter_app/translation/sql/history_data.dart';
import 'package:flutter_app/translation/sql/history_sql_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'translation_event.dart';
import 'translation_state.dart';
export 'translation_event.dart';
export 'translation_state.dart';

///
/// author：wangbufan
/// time: 2020/1/18
/// email: wangbufan00@gmail.com
///

var TranslationLanguageShrthand = [
  'auto',
  'zh',
  'en',
  'yue',
  'wyw',
  'jp',
];

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationHistoryProvider provider;
  SharedPreferences sp;
  AnimationController controller;
  Animation<double> animation;

  initStorage() async {
    provider = TranslationHistoryProvider();
    sp = await SharedPreferences.getInstance();
    await provider.open('history_db3.db');
    add(TranslationHistoryEvent());
  }

  TranslationBloc() : super() {
    initStorage();
  }

  @override
  Future<void> close() async {
    controller.dispose();
    await provider.close();
    return super.close();
  }

  @override
  TranslationState get initialState => TranslationState().initial();

  _TranslationFromTo(event) {
    ///
    /// @author: wangbufan
    /// @function: 当源语言或者目标语言发生改变的逻辑
    ///
    sp.setInt('translation_from', event.from);
    sp.setInt('translation_to', event.to);
    if (event.q.isNotEmpty) {
      add(TranslationNewDataEvent(q: event.q));
    }
    return state.copyWith(
      from: event.from,
      to: event.to,
      canExchange: event.from == 0 ? false : true,
    );
  }

  animate(vsync, int i) {
    ///
    /// @author: wangbufan
    /// @function: 交换动画配置
    ///
    if (controller == null || animation == null) {
      controller = AnimationController(
        vsync: vsync,
        duration: Duration(milliseconds: 500),
      );
      animation = Tween(begin: 20.0, end: 90.0).animate(controller)
        ..addListener(() {
          add(TranslationHeadPaddingChangeEvent(animation.value));
          // print(animation.value);
        });
    }
    if (i == 0) {
      controller.forward();
    } else if (i == 1) {
      controller.reverse();
    }
  }

  getNewData(String q, TranslationState state) async {
    ///
    /// @author: wangbufan
    /// @function: 进行网络请求
    ///
    var from = TranslationLanguageShrthand[state.from];
    var to = TranslationLanguageShrthand[state.to + 1];
    TranslationEntity data = await getTranslation(
      q: q,
      from: from,
      to: to,
    );
    return HistoryData(
      src: data.transResult[0].src,
      dst: data.transResult[0].dst,
      from: data.from,
      to: data.to,
    );
  }

  _TranslationNewData(TranslationNewDataEvent event) async {
    ///
    /// @author: wangbufan
    /// @function: 通过网络请求一个新数据的翻译，抛出结果
    ///
    if (event.q.isNotEmpty) {
      var history = await getNewData(event.q, state);
      provider.insert(history);
      return state.copyWith(
        q: history.src,
        result: history.dst,
        isShowResult: true,
        historys: state.historys
          ..remove(history)
          ..add(history),
      );
    } else {
      return state.copyWith(
        q: '',
        result: '',
        isShowResult: false,
      );
    }
  }

  _TranslationHistory() async {
    ///
    /// @author: wangbufan
    /// @function: 获取本地存储数据
    ///
    var historys = await provider.getAll();
    var from = sp.getInt('translation_from') ?? 0;
    var to = sp.get('translation_to') ?? 0;
    return state.copyWith(
      historys: historys,
      from: from,
      to: to,
      canExchange: from == 0 ? false : true,
    );
  }

  _TranslationCheckHistory(event) {
    provider.insert(event.data);
    var from = TranslationLanguageShrthand.indexOf(event.data.from);
    var to = TranslationLanguageShrthand.indexOf(event.data.to) - 1;
    sp.setInt('translation_from', from);
    sp.setInt('translation_to', to);
    return state.copyWith(
      q: event.data.src,
      from: from,
      to: to,
      isShowResult: true,
      result: event.data.dst,
      historys: state.historys
        ..remove(event.data)
        ..add(event.data),
      canExchange: from == 0 ? false : true,
    );
  }

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {
    if (event is TranslationNewDataEvent) {
      yield await _TranslationNewData(event);
    } else if (event is TranslationHistoryEvent) {
      yield await _TranslationHistory();
    } else if (event is TranslationFromToEvent) {
      yield _TranslationFromTo(event);
    } else if (event is TranslationCheckHistoryEvent) {
      yield _TranslationCheckHistory(event);
    } else if (event is TranslationFromToExchangeEvent) {
      //当点击交换按钮的逻辑，启动动画，交换
      animate(event.vsync, 0);
      Timer(Duration(milliseconds: 500), () {
        animate(event.vsync, 1);
        add(TranslationFromToEvent(
          from: state.to + 1,
          to: state.from - 1,
          q: event.q,
        ));
      });
    } else if (event is TranslationHeadPaddingChangeEvent) {
      //用于动画
      yield state.copyWith(headPadding: event.padding);
    }
  }
}
