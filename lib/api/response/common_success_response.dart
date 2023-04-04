
import 'package:json_annotation/json_annotation.dart';

part 'common_success_response.g.dart';

@JsonSerializable()
class CommonSuccessResponse {
  @JsonKey(name: "message")
  String message;

  CommonSuccessResponse(this.message);

  factory CommonSuccessResponse.fromJson(dynamic json) => _$CommonSuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonSuccessResponseToJson(this);
}
