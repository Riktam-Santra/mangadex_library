// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      group: json['group'] as String,
      version: json['version'] as int,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group': instance.group,
      'version': instance.version,
    };
