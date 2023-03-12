///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'user_followed_users.g.dart';

///@nodoc
@JsonSerializable()
class UserFollowedUsers {
  final List<Data>? data;
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
class Data {
  final String? id;
  final String? type;
  final Attributes? attributes;
  final List<Relationship>? relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
  final String? username;
  final Role? roles;
  final int? version;
  Attributes(this.username, this.roles, this.version);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class Role {
  final List<String>? roles;
  Role(this.roles);
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
