import 'dart:convert';

import 'package:chopper/chopper.dart';

const _commonDataKey = "data";
const _commonMetaKey = "meta";

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  const JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          response.body, typeToJsonFactoryMap[InnerType]!),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);
    var jsonMapData = jsonMap[_commonDataKey];
    var jsonMapMeta = jsonMap[_commonMetaKey];

    if (InnerType.toString() == "DictionaryResponse") {
      return jsonParser(jsonMap);
    }

    if (jsonMap is List) {
      return jsonMap
          .map((item) => jsonParser(item as Map<String, dynamic>) as InnerType)
          .toList() as T;
    } else if (jsonMapData != null &&
        jsonMapData is List &&
        jsonMapMeta == null) {
      return jsonMap[_commonDataKey]
          .map((item) => jsonParser(item as Map<String, dynamic>))
          .toList()
          .cast<InnerType>() as T;
    } else if (jsonMapData != null &&
        jsonMapData is Object &&
        jsonMapMeta == null) {
      return jsonParser(jsonMapData);
    }

    return jsonParser(jsonMap);
  }
}
