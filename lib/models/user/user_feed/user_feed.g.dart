// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeed _$UserFeedFromJson(Map<String, dynamic> json) => UserFeed(
      json['result'] as String,
      json['response'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFeedToJson(UserFeed instance) => <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String,
      json['type'] as String,
      Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>)
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
      json['volume'] as String,
      json['chapter'] as String,
      json['title'] as String,
      json['transfinaldLanguage'] as String,
      json['externalUrl'] as String?,
      json['publishAt'] as String,
      json['readableAt'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      json['pages'] as int,
      json['version'] as int,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'chapter': instance.chapter,
      'title': instance.title,
      'transfinaldLanguage': instance.transfinaldLanguage,
      'externalUrl': instance.externalUrl,
      'publishAt': instance.publishAt,
      'readableAt': instance.readableAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'pages': instance.pages,
      'version': instance.version,
    };

Relationship _$RelationshipFromJson(Map<String, dynamic> json) => Relationship(
      json['id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
