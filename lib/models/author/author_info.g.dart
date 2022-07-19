// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorInfo _$AuthorInfoFromJson(Map<String, dynamic> json) => AuthorInfo(
      result: json['result'] as String,
      response: json['response'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorInfoToJson(AuthorInfo instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'relationships': instance.relationships,
    };
