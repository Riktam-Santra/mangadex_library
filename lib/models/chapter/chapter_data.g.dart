// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterData _$ChapterDataFromJson(Map<String, dynamic> json) => ChapterData(
      json['result'] as String?,
      json['response'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$ChapterDataToJson(ChapterData instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>?)
          ?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      json['volume'] as String?,
      json['chapter'] as String?,
      json['title'] as String?,
      json['transdLanguage'] as String?,
      json['hash'] as String?,
      (json['chapterData'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['chapterDataSaver'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['publishAt'] as String?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
      json['version'] as int?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'chapter': instance.chapter,
      'title': instance.title,
      'transdLanguage': instance.transdLanguage,
      'hash': instance.hash,
      'chapterData': instance.chapterData,
      'chapterDataSaver': instance.chapterDataSaver,
      'publishAt': instance.publishAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'version': instance.version,
    };
