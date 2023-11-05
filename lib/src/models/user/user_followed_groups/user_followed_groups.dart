import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';
part 'user_followed_groups.g.dart';

///@nodoc
@JsonSerializable()
class UserFollowedGroups {
  final List<FollowedGroupsData>? data;
  final int? limit;
  final int? offset;
  final int? total;
  UserFollowedGroups(this.data, this.limit, this.offset, this.total);
  factory UserFollowedGroups.fromJson(Map<String, dynamic> json) =>
      _$UserFollowedGroupsFromJson(json);
  Map<String, dynamic> toJson() => _$UserFollowedGroupsToJson(this);
}

///@nodoc
@JsonSerializable()
class FollowedGroupsData {
  final String? id;
  final String? type;
  final FollowedGroupsAttributes? attributes;
  final List<Relationship>? relationships;
  FollowedGroupsData(this.id, this.type, this.attributes, this.relationships);
  factory FollowedGroupsData.fromJson(Map<String, dynamic> json) =>
      _$FollowedGroupsDataFromJson(json);
  Map<String, dynamic> toJson() => _$FollowedGroupsDataToJson(this);
}

///@nodoc
@JsonSerializable()
class FollowedGroupsAttributes {
  final String? name;
  final String? website;
  final String? ircServer;
  final String? ircChannel;
  final String? discord;
  final String? contactEmail;
  final String? description;
  final bool? locked;
  final bool? official;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  FollowedGroupsAttributes(
      this.name,
      this.website,
      this.ircServer,
      this.ircChannel,
      this.discord,
      this.contactEmail,
      this.description,
      this.locked,
      this.official,
      this.version,
      this.createdAt,
      this.updatedAt);
  factory FollowedGroupsAttributes.fromJson(Map<String, dynamic> json) =>
      _$FollowedGroupsAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$FollowedGroupsAttributesToJson(this);
}
