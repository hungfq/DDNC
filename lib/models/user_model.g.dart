// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['serial'] as String,
      json['code'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['role'] as String?,
      json['picture'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'serial': instance.serial,
      'code': instance.code,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'picture': instance.picture,
      'token': instance.token,
    };
