// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanlation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scanlation _$ScanlationFromJson(Map<String, dynamic> json) => Scanlation(
      result: json['result'] as String,
      response: json['response'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
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
