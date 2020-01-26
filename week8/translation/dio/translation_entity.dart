import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/generated/json/base/json_filed.dart';

class TranslationEntity with JsonConvert<TranslationEntity> {
	String from;
	String to;
	@JSONField(name: "trans_result")
	List<TranslationTransResult> transResult;
}

class TranslationTransResult with JsonConvert<TranslationTransResult> {
	String src;
	String dst;
}
