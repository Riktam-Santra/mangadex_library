// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aggregate _$AggregateFromJson(Map<String, dynamic> json) => Aggregate(
      json['result'] as String?,
      (json['volumes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Volume.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AggregateToJson(Aggregate instance) => <String, dynamic>{
      'result': instance.result,
      'volumes': instance.volumes,
    };

Volume _$VolumeFromJson(Map<String, dynamic> json) => Volume(
      json['volume'] as String?,
      json['count'] as int?,
      (json['chapters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ChapterInfo.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$VolumeToJson(Volume instance) => <String, dynamic>{
      'volume': instance.volume,
      'count': instance.count,
      'chapters': instance.chapters,
    };

ChapterInfo _$ChapterInfoFromJson(Map<String, dynamic> json) => ChapterInfo(
      json['chapter'] as String?,
      json['id'] as String?,
      (json['others'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['count'] as int?,
    );

Map<String, dynamic> _$ChapterInfoToJson(ChapterInfo instance) =>
    <String, dynamic>{
      'chapter': instance.chapter,
      'id': instance.id,
      'others': instance.others,
      'count': instance.count,
    };
