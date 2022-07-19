// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerException _$ServerExceptionFromJson(Map<String, dynamic> json) =>
    ServerException(
      result: json['result'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => Error.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerExceptionToJson(ServerException instance) =>
    <String, dynamic>{
      'result': instance.result,
      'errors': instance.errors,
    };
