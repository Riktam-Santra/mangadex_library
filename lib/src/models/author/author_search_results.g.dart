// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorSearchResults _$AuthorSearchResultsFromJson(Map<String, dynamic> json) =>
    AuthorSearchResults(
      json['result'] as String?,
      json['response'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$AuthorSearchResultsToJson(
        AuthorSearchResults instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
