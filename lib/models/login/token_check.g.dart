// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationCheck _$AuthenticationCheckFromJson(Map<String, dynamic> json) =>
    AuthenticationCheck(
      result: json['result'] as String,
      isAuthenticated: json['isAuthenticated'] as bool,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthenticationCheckToJson(
        AuthenticationCheck instance) =>
    <String, dynamic>{
      'result': instance.result,
      'isAuthenticated': instance.isAuthenticated,
      'roles': instance.roles,
      'permissions': instance.permissions,
    };
