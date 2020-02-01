import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/translation/sql/history_data.dart';

///
/// author：wangbufan
/// time: 2020/1/20
/// email: wangbufan00@gmail.com
///

abstract class TranslationEvent extends Equatable {
  const TranslationEvent();
}

class TranslationNewDataEvent extends TranslationEvent {
  final String q;

  TranslationNewDataEvent({
    this.q,
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TranslationHistoryEvent extends TranslationEvent {
  TranslationHistoryEvent();

  @override
  List<Object> get props => [];
}

class TranslationFromToEvent extends TranslationEvent {
  final int from;
  final int to;
  final String q;

  TranslationFromToEvent({
    this.from,
    this.to,
    this.q,
  });

  @override
  // TODO: implement props
  List<Object> get props => [from, to,q];
}

class TranslationCheckHistoryEvent extends TranslationEvent {
  final HistoryData data;

  TranslationCheckHistoryEvent({
    this.data,
  });

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class TranslationHeadPaddingChangeEvent extends TranslationEvent{
  final double padding;

  TranslationHeadPaddingChangeEvent(this.padding);
  @override
  // TODO: implement props
  List<Object> get props => [padding];
}
class TranslationFromToExchangeEvent extends TranslationEvent{

  final String q;
  final TickerProvider vsync;
  TranslationFromToExchangeEvent({this.q,this.vsync});
  @override
  // TODO: implement props
  List<Object> get props => [];
}