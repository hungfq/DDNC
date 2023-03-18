import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String serial;
  String? name;
  String? email;
  String? role;
  String? picture;

  UserModel(this.serial, this.name, this.email, this.role, this.picture);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

