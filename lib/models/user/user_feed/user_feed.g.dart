// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeed _$UserFeedFromJson(Map<String, dynamic> json) => UserFeed(
      result: json['result'] as String,
      response: json['response'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFeedToJson(UserFeed instance) => <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String,
      type: json['type'] as String,
      attributes:
          Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      volume: json['volume'] as String,
      chapter: json['chapter'] as String,
      title: json['title'] as String,
      translatedLanguage: json['translatedLanguage'] as String,
      externalUrl: json['externalUrl'] as String?,
      publishAt: json['publishAt'] as String,
      readableAt: json['readableAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      pages: json['pages'] as int,
      version: json['version'] as int,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'chapter': instance.chapter,
      'title': instance.title,
      'translatedLanguage': instance.translatedLanguage,
      'externalUrl': instance.externalUrl,
      'publishAt': instance.publishAt,
      'readableAt': instance.readableAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'pages': instance.pages,
      'version': instance.version,
    };
