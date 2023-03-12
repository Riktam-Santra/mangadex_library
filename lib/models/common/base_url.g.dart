// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUrl _$BaseUrlFromJson(Map<String, dynamic> json) => BaseUrl(
      json['result'] as String?,
      json['baseUrl'] as String?,
      json['chapter'] == null
          ? null
          : Chapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseUrlToJson(BaseUrl instance) => <String, dynamic>{
      'result': instance.result,
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter,
    };
