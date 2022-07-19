// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_list_confirmation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCustomListResponse _$SingleCustomListResponseFromJson(
        Map<String, dynamic> json) =>
    SingleCustomListResponse(
      result: json['result'] as String,
      response: json['response'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleCustomListResponseToJson(
        SingleCustomListResponse instance) =>
    <String, dynamic>{
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
      name: json['name'] as String,
      visibility: json['visibility'] as String,
      version: json['version'] as int,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': instance.visibility,
      'version': instance.version,
    };

Relationship _$RelationshipFromJson(Map<String, dynamic> json) => Relationship(
      id: json['id'] as String,
      type: json['type'] as String,
      related: json['related'] as String,
      attributes: json['attributes'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'related': instance.related,
      'attributes': instance.attributes,
    };
