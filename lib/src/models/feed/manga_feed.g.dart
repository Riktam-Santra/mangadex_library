// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaFeed _$MangaFeedFromJson(Map<String, dynamic> json) => MangaFeed(
      json['result'] as String?,
      json['response'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => MangaFeedData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$MangaFeedToJson(MangaFeed instance) => <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

MangaFeedData _$MangaFeedDataFromJson(Map<String, dynamic> json) =>
    MangaFeedData(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : MangaFeedAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MangaFeedDataToJson(MangaFeedData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
    };

MangaFeedAttributes _$MangaFeedAttributesFromJson(Map<String, dynamic> json) =>
    MangaFeedAttributes(
      json['title'] as String?,
      json['volume'] as String?,
      json['chapter'] as String?,
      json['pages'] as int?,
      json['translatedLanguage'] as String?,
      json['uploader'] as String?,
      json['externalUrl'] as String?,
      json['version'] as int?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
      json['publishedAt'] as String?,
      json['readableAt'] as String?,
      (json['relationships'] as List<dynamic>?)
          ?.map(
              (e) => MangaFeedRelationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MangaFeedAttributesToJson(
        MangaFeedAttributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'volume': instance.volume,
      'chapter': instance.chapter,
      'pages': instance.pages,
      'translatedLanguage': instance.translatedLanguage,
      'uploader': instance.uploader,
      'externalUrl': instance.externalUrl,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
      'readableAt': instance.readableAt,
      'relationships': instance.relationships,
    };

MangaFeedRelationship _$MangaFeedRelationshipFromJson(
        Map<String, dynamic> json) =>
    MangaFeedRelationship(
      json['id'] as String?,
      json['type'] as String?,
      json['related'] as String?,
    );

Map<String, dynamic> _$MangaFeedRelationshipToJson(
        MangaFeedRelationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'related': instance.related,
    };
