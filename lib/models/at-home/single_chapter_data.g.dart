// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_chapter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleChapterData _$SingleChapterDataFromJson(Map<String, dynamic> json) =>
    SingleChapterData(
      json['result'] as String?,
      json['chapter'] == null
          ? null
          : Chapter.fromJson(json['chapter'] as Map<String, dynamic>),
      json['baseUrl'] as String?,
    );

Map<String, dynamic> _$SingleChapterDataToJson(SingleChapterData instance) =>
    <String, dynamic>{
      'result': instance.result,
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter,
    };
