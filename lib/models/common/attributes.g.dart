// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      altTitles: (json['altTitles'] as List<dynamic>)
          .map((e) => AltTitles.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: (json['description'].runtimeType == List)
          ? Description(en: '', fr: '')
          : Description.fromJson(json['description'] as Map<String, dynamic>),
      isLocked: json['isLocked'] as bool,
      originalLanguage: json['originalLanguage'] as String,
      lastVolume: json['lastVolume'] as String?,
      lastChapter: json['lastChapter'] as String?,
      publicationDemographic: json['publicationDemographic'] as String?,
      status: json['status'] as String,
      year: json['year'] as int?,
      contentRating: json['contentRating'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'altTitles': instance.altTitles,
      'description': instance.description,
      'isLocked': instance.isLocked,
      'originalLanguage': instance.originalLanguage,
      'lastVolume': instance.lastVolume,
      'lastChapter': instance.lastChapter,
      'publicationDemographic': instance.publicationDemographic,
      'status': instance.status,
      'year': instance.year,
      'contentRating': instance.contentRating,
      'tags': instance.tags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'version': instance.version,
    };
