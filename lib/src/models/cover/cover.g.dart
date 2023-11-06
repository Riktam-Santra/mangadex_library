// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cover _$CoverFromJson(Map<String, dynamic> json) => Cover(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CoverData.fromJson(e as Map<String, dynamic>))
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

CoverData _$CoverDataFromJson(Map<String, dynamic> json) => CoverData(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : CoverAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>?)
          ?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoverDataToJson(CoverData instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'relationships': instance.relationships,
      'attributes': instance.attributes,
    };

CoverAttributes _$CoverAttributesFromJson(Map<String, dynamic> json) =>
    CoverAttributes(
      json['volume'] as String?,
      json['fileName'] as String?,
      json['description'] as String?,
      json['version'] as int?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CoverAttributesToJson(CoverAttributes instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'fileName': instance.fileName,
      'description': instance.description,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
