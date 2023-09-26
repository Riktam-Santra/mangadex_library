// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_followed_manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowedManga _$UserFollowedMangaFromJson(Map<String, dynamic> json) =>
    UserFollowedManga(
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$UserFollowedMangaToJson(UserFollowedManga instance) =>
    <String, dynamic>{
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
