import 'package:equatable/equatable.dart';

///
/// author：wangbufan
/// time: 2020/1/20
/// email: wangbufan00@gmail.com
///

final String _tableName = 'translation_history';
final String _src = '_src';
final String _dst = '_dst';
final String _from = '_from';
final String _to = '_to';

class HistoryData extends Equatable {
  String src;
  String dst;
  String from;
  String to;

  Map<String, String> toMap() {
    return <String, String>{
      _src: src,
      _dst: dst,
      _from: from,
      _to: to,
    };
  }

  HistoryData({this.src, this.dst, this.from, this.to});

  HistoryData.fromMap(Map map) {
    src = map[_src];
    dst = map[_dst];
    from = map[_from];
    to = map[_to];
  }

  @override
  // TODO: implement props
  List<Object> get props => [src, dst, from, to];
}
