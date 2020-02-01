import 'package:sqflite/sqflite.dart';
import 'history_data.dart';

///
/// author：wangbufan
/// time: 2020/1/20
/// email: wangbufan00@gmail.com
///

final String _tableName = 'translation_history1';
final String _src = '_src';
final String _dst = '_dst';
final String _from = '_from';
final String _to = '_to';

class TranslationHistoryProvider {
  Database db;

  open(String path) async {
    //var path = await getDatabasesPath() + path1;
    db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        create table $_tableName(
        $_src text not null,
        $_dst text not null,
        $_from text not null,
        $_to text not null)
        ''');
      },
    );
  }

  insert(HistoryData history) async {
    await delete(history);
    var mm= await db.insert(_tableName, history.toMap());
    print(mm);
  }

  Future<List<HistoryData>> getAll() async {
    List<Map> maps = await db.query(_tableName,distinct: true);
    return maps.map((map) {
      return HistoryData.fromMap(map);
    }).toList();
  }

  delete(HistoryData data) async {
    await db.delete(
      _tableName,
      where: ' $_src =? and $_dst=? and $_from=? and $_to=? ',
      whereArgs: [data.src, data.dst, data.from, data.to],
    );
  }

  close() async => await db.close();
}
