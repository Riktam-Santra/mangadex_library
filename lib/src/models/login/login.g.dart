// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      json['result'] as String?,
      json['token'] == null
          ? null
          : Token.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'result': instance.result,
      'token': instance.token,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      json['session'] as String?,
      json['refresh'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'session': instance.session,
      'refresh': instance.refresh,
    };
