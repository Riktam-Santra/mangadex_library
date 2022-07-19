// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUrl _$BaseUrlFromJson(Map<String, dynamic> json) => BaseUrl(
      result: json['result'] as String,
      baseUrl: json['baseUrl'] as String,
      chapter: Chapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseUrlToJson(BaseUrl instance) => <String, dynamic>{
      'result': instance.result,
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter,
    };
