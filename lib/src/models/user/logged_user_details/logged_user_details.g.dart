// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      json['result'] as String?,
      json['data'] == null
          ? null
          : UserDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      json['response'] as String?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'result': instance.result,
      'response': instance.response,
      'data': instance.data,
    };

UserDetailsData _$UserDetailsDataFromJson(Map<String, dynamic> json) =>
    UserDetailsData(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : UserDetailsAttributes.fromJson(
              json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>?)
          ?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDetailsDataToJson(UserDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

UserDetailsAttributes _$UserDetailsAttributesFromJson(
        Map<String, dynamic> json) =>
    UserDetailsAttributes(
      json['username'] as String?,
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['version'] as int?,
    );

Map<String, dynamic> _$UserDetailsAttributesToJson(
        UserDetailsAttributes instance) =>
    <String, dynamic>{
      'username': instance.username,
      'roles': instance.roles,
      'version': instance.version,
    };
