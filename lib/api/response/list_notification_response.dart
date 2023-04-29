import 'package:json_annotation/json_annotation.dart';

import 'meta_response.dart';

part 'list_notification_response.g.dart';

@JsonSerializable()
class ListNotificationResponse {
  @JsonKey(name: "data")
  List<NotificationInfo> data;
  @JsonKey(name: "meta")
  MetaResponse meta;

  ListNotificationResponse(this.data, this.meta);

  factory ListNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ListNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListNotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationInfo {
  @JsonKey(name: "_id")
  int id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "isRead")
  bool? isRead;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "created_by_name")
  String? createdBy;

  NotificationInfo(this.id, this.title, this.message, this.isRead,
      this.createdAt, this.createdBy);

  factory NotificationInfo.fromJson(Map<String, dynamic> json) =>
      _$NotificationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationInfoToJson(this);
}
