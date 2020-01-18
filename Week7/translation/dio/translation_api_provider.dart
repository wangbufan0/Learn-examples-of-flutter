import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_app/base/request.dart';
import 'package:flutter_app/translation/dio/translation_entity.dart';

///
/// author：wangbufan
/// time: 2020/1/17
/// email: wangbufan00@gmail.com
///

getTranslation({String q, String from, String to}) async {
  String appid = '20190602000304123';
  String salt = DateTime.now().millisecondsSinceEpoch.toString();
  String securityKey = "13h2Q37ayuJy_kAxkkER";
  var params = Map<String, String>();
  params['q'] = q;
  params['from'] = from;
  params['to'] = to;
  params['appid'] = appid;
  params['salt'] = salt;
  String src = appid + q + salt + securityKey;
  params['sign'] = md5.convert(utf8.encode(src)).toString();
  ResultData resultData = await Request.post(url: '', param: params);
  if (resultData.result) return TranslationEntity().fromJson(resultData.data);
}
