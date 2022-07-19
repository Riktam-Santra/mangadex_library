// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorSearchResult _$AuthorSearchResultFromJson(Map<String, dynamic> json) =>
    AuthorSearchResult(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
      result: json['result'] as String,
      response: json['response'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorSearchResultToJson(AuthorSearchResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
