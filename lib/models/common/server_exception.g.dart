// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerException _$ServerExceptionFromJson(Map<String, dynamic> json) =>
    ServerException(
      json['result'] as String?,
      (json['errors'] as List<dynamic>?)
          ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerExceptionToJson(ServerException instance) =>
    <String, dynamic>{
      'result': instance.result,
      'errors': instance.errors,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      json['id'] as String?,
      json['status'] as int?,
      json['title'] as String?,
      json['detail'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'detail': instance.detail,
    };
