// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagAttributes _$TagAttributesFromJson(Map<String, dynamic> json) =>
    TagAttributes(
      json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      json['description'] == null
          ? null
          : Description.fromJson(json['description'] as Map<String, dynamic>),
      json['group'] as String?,
      json['version'] as int?,
    );

Map<String, dynamic> _$TagAttributesToJson(TagAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'group': instance.group,
      'version': instance.version,
    };
