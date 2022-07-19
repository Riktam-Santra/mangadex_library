// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_manga_reading_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMangaReadingStatus _$AllMangaReadingStatusFromJson(
        Map<String, dynamic> json) =>
    AllMangaReadingStatus(
      result: json['result'] as String,
      statuses: json['statuses'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AllMangaReadingStatusToJson(
        AllMangaReadingStatus instance) =>
    <String, dynamic>{
      'result': instance.result,
      'statuses': instance.statuses,
    };
