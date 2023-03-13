// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_custom_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCustomListResponse _$SingleCustomListResponseFromJson(
        Map<String, dynamic> json) =>
    SingleCustomListResponse(
      json['result'] as String?,
      json['response'] as String?,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleCustomListResponseToJson(
        SingleCustomListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
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
      json['name'] as String?,
      json['visibility'] as String?,
      json['version'] as int?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': instance.visibility,
      'version': instance.version,
    };

Relationship _$RelationshipFromJson(Map<String, dynamic> json) => Relationship(
      json['id'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
