import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/base/bloc/base_state.dart';
import 'package:flutter_app/base/page/base_page.dart';
import 'package:flutter_app/translation/dio/translation_api_provider.dart';
import 'package:flutter_app/translation/dio/translation_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/18
/// email: wangbufan00@gmail.com
///

class TranslationEvent extends Equatable {
  final String q;
  final String from;
  final String to;

  TranslationEvent(this.q, this.from, this.to);

  @override
  List<Object> get props => [q, from, to];
}

class TranslationState extends BaseState {
  String q;
  String result;
  List<TranslationEntity> historys;

  TranslationState({this.q,this.result,this.historys});
  @override
  TranslationState initial() {
    q = '';
    result = null;
    historys = List<TranslationEntity>();
    return this;
  }

  TranslationState copyWith({
    String q,
    String result,
    TranslationEntity history,
  }) {
    return TranslationState(
      q: q??this.q,
      result: result,
      historys: history==null?this.historys:this.historys..add(history),
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [q, result, historys];
}

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  @override
  TranslationState get initialState => TranslationState().initial();

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {
    TranslationEntity data= await getTranslation(
      q: event.q,
      from: event.from,
      to: event.to,
    );
    var result=data.transResult[0];

    yield state.copyWith(q: result.src,result: result.dst,history: data);
  }
}
