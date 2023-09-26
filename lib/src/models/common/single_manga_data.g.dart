// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_manga_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleMangaData _$SingleMangaDataFromJson(Map<String, dynamic> json) =>
    SingleMangaData(
      json['result'] as String?,
      json['response'] as String?,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleMangaDataToJson(SingleMangaData instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };
