// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanlation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scanlation _$ScanlationFromJson(Map<String, dynamic> json) => Scanlation(
      json['result'] as String?,
      json['response'] as String?,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$ScanlationToJson(Scanlation instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
