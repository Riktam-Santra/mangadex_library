// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeed _$UserFeedFromJson(Map<String, dynamic> json) => UserFeed(
      json['result'] as String,
      json['response'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => UserFeedData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFeedToJson(UserFeed instance) => <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };

UserFeedData _$UserFeedDataFromJson(Map<String, dynamic> json) => UserFeedData(
      json['id'] as String,
      json['type'] as String,
      UserFeedAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>)
          .map((e) => UserFeedRelationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFeedDataToJson(UserFeedData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

UserFeedAttributes _$UserFeedAttributesFromJson(Map<String, dynamic> json) =>
    UserFeedAttributes(
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

Map<String, dynamic> _$UserFeedAttributesToJson(UserFeedAttributes instance) =>
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

UserFeedRelationship _$UserFeedRelationshipFromJson(
        Map<String, dynamic> json) =>
    UserFeedRelationship(
      json['id'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$UserFeedRelationshipToJson(
        UserFeedRelationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
