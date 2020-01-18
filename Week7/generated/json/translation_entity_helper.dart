import 'package:flutter_app/translation/dio/translation_entity.dart';

translationEntityFromJson(TranslationEntity data, Map<String, dynamic> json) {
	if (json['from'] != null) {
		data.from = json['from']?.toString();
	}
	if (json['to'] != null) {
		data.to = json['to']?.toString();
	}
	if (json['trans_result'] != null) {
		data.transResult = new List<TranslationTransResult>();
		(json['trans_result'] as List).forEach((v) {
			data.transResult.add(new TranslationTransResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> translationEntityToJson(TranslationEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['from'] = entity.from;
	data['to'] = entity.to;
	if (entity.transResult != null) {
		data['trans_result'] =  entity.transResult.map((v) => v.toJson()).toList();
	}
	return data;
}

translationTransResultFromJson(TranslationTransResult data, Map<String, dynamic> json) {
	if (json['src'] != null) {
		data.src = json['src']?.toString();
	}
	if (json['dst'] != null) {
		data.dst = json['dst']?.toString();
	}
	return data;
}

Map<String, dynamic> translationTransResultToJson(TranslationTransResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['src'] = entity.src;
	data['dst'] = entity.dst;
	return data;
}