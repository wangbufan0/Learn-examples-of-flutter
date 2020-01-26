import 'package:bloc/bloc.dart';
import 'package:flutter_app/translation/dio/translation_api_provider.dart';
import 'package:flutter_app/translation/dio/translation_entity.dart';
import 'package:flutter_app/translation/sql/history_data.dart';

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
  @override
  TranslationState get initialState => TranslationState().initial();

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {
    if (event is TranslationNewDataEvent) {
      if (event.q.isNotEmpty) {
        var history = await getNewData(event.q, state);
        await event.provider.insert(history);
        yield state.copyWith(
          q: history.src,
          result: history.dst,
          isShowResult: true,
          historys: state.historys
            ..remove(history)
            ..add(history),
        );
      } else {
        yield state.copyWith(
          q: '',
          result: '',
          isShowResult: false,
        );
      }
    } else if (event is TranslationHistoryEvent) {
      var historys = await event.provider.getAll();
      var from = event.sp.getInt('translation_from') ?? 0;
      var to = event.sp.get('translation_to') ?? 0;
      yield state.copyWith(
        historys: historys,
        from: from,
        to: to,
        canExchange: from==0?false:true,
      );
    } else if (event is TranslationFromToEvent) {
      event.sp.setInt('translation_from', event.from);
      event.sp.setInt('translation_to', event.to);
      yield state.copyWith(
        from: event.from,
        to: event.to,
        canExchange: event.from==0?false:true,
      );
      if (event.q.isNotEmpty) {
        add(TranslationNewDataEvent(
          provider: event.provider,
          q: event.q,
        ));
      }
    } else if (event is TranslationCheckHistoryEvent) {
      await event.provider.insert(event.data);
      var from = TranslationLanguageShrthand.indexOf(event.data.from);
      var to = TranslationLanguageShrthand.indexOf(event.data.to)-1;
      event.sp.setInt('translation_from', from);
      event.sp.setInt('translation_to', to);
      yield state.copyWith(
        q: event.data.src,
        from: from,
        to: to,
        isShowResult: true,
        result: event.data.dst,
        historys: state.historys
          ..remove(event.data)
          ..add(event.data),
        canExchange: from==0?false:true,
      );
    }
  }

  getNewData(String q, TranslationState state) async {
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
}
