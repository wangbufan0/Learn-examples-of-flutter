import 'package:equatable/equatable.dart';
import 'package:flutter_app/translation/sql/history_data.dart';
import 'package:flutter_app/translation/sql/history_sql_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// author：wangbufan
/// time: 2020/1/20
/// email: wangbufan00@gmail.com
///

abstract class TranslationEvent extends Equatable {
  final TranslationHistoryProvider provider;

  const TranslationEvent({this.provider});
}

class TranslationNewDataEvent extends TranslationEvent {
  final String q;

  TranslationNewDataEvent({
    TranslationHistoryProvider provider,
    this.q,
  }) : super(provider: provider);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TranslationHistoryEvent extends TranslationEvent {
  final SharedPreferences sp;
  TranslationHistoryEvent({TranslationHistoryProvider provider,this.sp})
      : super(provider: provider);

  @override
  List<Object> get props => [provider];
}

class TranslationFromToEvent extends TranslationEvent {
  final int from;
  final int to;
  final String q;
  final SharedPreferences sp;
  TranslationFromToEvent({
    TranslationHistoryProvider provider,
    this.from,
    this.to,
    this.q,
    this.sp,
  }) : super(provider: provider);

  @override
  // TODO: implement props
  List<Object> get props => [from, to];
}

class TranslationCheckHistoryEvent extends TranslationEvent{
  final HistoryData data;
  final SharedPreferences sp;

  TranslationCheckHistoryEvent({this.data, this.sp,TranslationHistoryProvider provider,}):super(provider:provider);

  @override
  // TODO: implement props
  List<Object> get props => [data];

}
