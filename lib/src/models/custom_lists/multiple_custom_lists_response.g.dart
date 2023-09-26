// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_custom_lists_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultipleCustomListResponse _$MultipleCustomListResponseFromJson(
        Map<String, dynamic> json) =>
    MultipleCustomListResponse(
      json['result'] as String?,
      json['response'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultipleCustomListResponseToJson(
        MultipleCustomListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };
