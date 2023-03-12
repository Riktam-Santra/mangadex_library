// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cover _$CoverFromJson(Map<String, dynamic> json) => Cover(
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
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
      'relationships': instance.relationships,
      'attributes': instance.attributes,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      json['volume'] as String?,
      json['fileName'] as String?,
      json['description'] as String?,
      json['version'] as int?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'fileName': instance.fileName,
      'description': instance.description,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
