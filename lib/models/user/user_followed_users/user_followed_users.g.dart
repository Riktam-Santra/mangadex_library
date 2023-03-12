// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_followed_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowedUsers _$UserFollowedUsersFromJson(Map<String, dynamic> json) =>
    UserFollowedUsers(
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$UserFollowedUsersToJson(UserFollowedUsers instance) =>
    <String, dynamic>{
      'data': instance.data,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as String?,
      json['type'] as String?,
      json['attributes'] == null
          ? null
          : Attributes.fromJson(json['attributes'] as Map<String, dynamic>),
      (json['relationships'] as List<dynamic>?)
          ?.map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'relationships': instance.relationships,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      json['username'] as String?,
      json['roles'] == null
          ? null
          : Role.fromJson(json['roles'] as Map<String, dynamic>),
      json['version'] as int?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'username': instance.username,
      'roles': instance.roles,
      'version': instance.version,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'roles': instance.roles,
    };
