
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'error.g.dart';

@JsonSerializable()
class Error{
  @JsonKey(name: "error")
  Message message;

  Error(this.message);

  factory Error.fromJson(dynamic json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}