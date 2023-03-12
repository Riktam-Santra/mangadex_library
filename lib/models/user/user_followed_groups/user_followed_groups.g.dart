// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_followed_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFollowedGroups _$UserFollowedGroupsFromJson(Map<String, dynamic> json) =>
    UserFollowedGroups(
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int?,
      json['offset'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$UserFollowedGroupsToJson(UserFollowedGroups instance) =>
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
      json['name'] as String?,
      json['website'] as String?,
      json['ircServer'] as String?,
      json['ircChannel'] as String?,
      json['discord'] as String?,
      json['contactEmail'] as String?,
      json['description'] as String?,
      json['locked'] as bool?,
      json['official'] as bool?,
      json['version'] as int?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'website': instance.website,
      'ircServer': instance.ircServer,
      'ircChannel': instance.ircChannel,
      'discord': instance.discord,
      'contactEmail': instance.contactEmail,
      'description': instance.description,
      'locked': instance.locked,
      'official': instance.official,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
