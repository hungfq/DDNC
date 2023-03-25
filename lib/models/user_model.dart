import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String serial;
  String? code;
  String? name;
  String? email;
  String? role;
  String? picture;
  String? token;

  UserModel(this.serial, this.code, this.name, this.email, this.role,
      this.picture, this.token);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
