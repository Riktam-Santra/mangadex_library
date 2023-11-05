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
          : CustomListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleCustomListResponseToJson(
        SingleCustomListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };

CustomListData _$CustomListDataFromJson(Map<String, dynamic> json) =>
    CustomListData(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : CustomListAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>?)
          ?.map(
              (e) => CustomListRelationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomListDataToJson(CustomListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

CustomListAttributes _$CustomListAttributesFromJson(
        Map<String, dynamic> json) =>
    CustomListAttributes(
      json['name'] as String?,
      json['visibility'] as String?,
      json['version'] as int?,
    );

Map<String, dynamic> _$CustomListAttributesToJson(
        CustomListAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': instance.visibility,
      'version': instance.version,
    };

CustomListRelationship _$CustomListRelationshipFromJson(
        Map<String, dynamic> json) =>
    CustomListRelationship(
      json['id'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$CustomListRelationshipToJson(
        CustomListRelationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
