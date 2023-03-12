// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagsToJson(Tags instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
    };
