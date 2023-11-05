// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanlations_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanlationsResult _$ScanlationsResultFromJson(Map<String, dynamic> json) =>
    ScanlationsResult(
      json['result'] as String?,
      json['response'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ScanlationsResultData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$ScanlationsResultToJson(ScanlationsResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

ScanlationsResultData _$ScanlationsResultDataFromJson(
        Map<String, dynamic> json) =>
    ScanlationsResultData(
      json['id'] as String,
      json['type'] as String,
      ScanlationsResultAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>)
          .map((e) =>
              ScanlationsResultRelationShip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScanlationsResultDataToJson(
        ScanlationsResultData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

ScanlationsResultAttributes _$ScanlationsResultAttributesFromJson(
        Map<String, dynamic> json) =>
    ScanlationsResultAttributes(
      json['name'] as String?,
      (json['altNames'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      json['website'] as String?,
      json['ircServer'] as String?,
      json['ircChannel'] as String?,
      json['discord'] as String?,
      json['contactEmail'] as String?,
      json['description'] as String?,
      json['twitter'] as String?,
      json['mangaUpdates'] as String?,
      (json['focussedLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['locked'] as bool?,
      json['official'] as bool?,
      json['inactive'] as bool?,
      json['publishDelay'] as String?,
      json['version'] as int?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ScanlationsResultAttributesToJson(
        ScanlationsResultAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'altNames': instance.altNames,
      'website': instance.website,
      'ircServer': instance.ircServer,
      'ircChannel': instance.ircChannel,
      'discord': instance.discord,
      'contactEmail': instance.contactEmail,
      'description': instance.description,
      'twitter': instance.twitter,
      'mangaUpdates': instance.mangaUpdates,
      'focussedLanguage': instance.focussedLanguage,
      'locked': instance.locked,
      'official': instance.official,
      'inactive': instance.inactive,
      'publishDelay': instance.publishDelay,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ScanlationsResultRelationShip _$ScanlationsResultRelationShipFromJson(
        Map<String, dynamic> json) =>
    ScanlationsResultRelationShip(
      json['id'] as String?,
      json['type'] as String?,
      json['refinald'] as String?,
      json['attributes'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ScanlationsResultRelationShipToJson(
        ScanlationsResultRelationShip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'refinald': instance.refinald,
      'attributes': instance.attributes,
    };
