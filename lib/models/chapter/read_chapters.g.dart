// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_chapters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadChapters _$ReadChaptersFromJson(Map<String, dynamic> json) => ReadChapters(
      json['result'] as String,
      (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ReadChaptersToJson(ReadChapters instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };
