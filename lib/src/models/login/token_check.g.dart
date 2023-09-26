// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationCheck _$AuthenticationCheckFromJson(Map<String, dynamic> json) =>
    AuthenticationCheck(
      json['result'] as String?,
      json['isAuthenticated'] as bool?,
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['permissions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuthenticationCheckToJson(
        AuthenticationCheck instance) =>
    <String, dynamic>{
      'result': instance.result,
      'isAuthenticated': instance.isAuthenticated,
      'roles': instance.roles,
      'permissions': instance.permissions,
    };
