// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanlations_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanlationsResult _$ScanlationsResultFromJson(Map<String, dynamic> json) =>
    ScanlationsResult(
      result: json['result'] as String,
      response: json['response'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
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
      name: json['name'] as String,
      altNames: (json['altNames'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      website: json['website'] as String,
      ircServer: json['ircServer'] as String,
      ircChannel: json['ircChannel'] as String,
      discord: json['discord'] as String,
      contactEmail: json['contactEmail'] as String,
      description: json['description'] as String,
      twitter: json['twitter'] as String,
      mangaUpdates: json['mangaUpdates'] as String,
      focussedLanguage: (json['focussedLanguage'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locked: json['locked'] as bool,
      official: json['official'] as bool,
      inactive: json['inactive'] as bool,
      publishDelay: json['publishDelay'] as String,
      version: json['version'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
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

Relationship _$RelationshipFromJson(Map<String, dynamic> json) => Relationship(
      attributes: json['attributes'] as Map<String, dynamic>,
      id: json['id'] as String,
      type: json['type'] as String,
      related: json['related'] as String,
    );

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'related': instance.related,
      'attributes': instance.attributes,
    };
