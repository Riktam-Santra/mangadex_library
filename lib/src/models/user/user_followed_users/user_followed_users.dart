///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';
part 'user_followed_users.g.dart';

///@nodoc
@JsonSerializable()
class UserFollowedUsers {
  final List<FollowedUsersData>? data;
  final int? limit;
  final int? offset;
  final int? total;
  UserFollowedUsers(this.data, this.limit, this.offset, this.total);
  factory UserFollowedUsers.fromJson(Map<String, dynamic> json) =>
      _$UserFollowedUsersFromJson(json);
  Map<String, dynamic> toJson() => _$UserFollowedUsersToJson(this);
}

///@nodoc
@JsonSerializable()
class FollowedUsersData {
  final String? id;
  final String? type;
  final FollowedUsersAttributes? attributes;
  final List<Relationship>? relationships;
  FollowedUsersData(this.id, this.type, this.attributes, this.relationships);
  factory FollowedUsersData.fromJson(Map<String, dynamic> json) =>
      _$FollowedUsersDataFromJson(json);
  Map<String, dynamic> toJson() => _$FollowedUsersDataToJson(this);
}

///@nodoc
@JsonSerializable()
class FollowedUsersAttributes {
  final String? username;
  final Role? roles;
  final int? version;
  FollowedUsersAttributes(this.username, this.roles, this.version);
  factory FollowedUsersAttributes.fromJson(Map<String, dynamic> json) =>
      _$FollowedUsersAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$FollowedUsersAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class Role {
  final List<String>? roles;
  Role(this.roles);
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
