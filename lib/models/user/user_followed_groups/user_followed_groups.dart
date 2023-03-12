import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'user_followed_groups.g.dart';

///@nodoc
@JsonSerializable()
class UserFollowedGroups {
  final List<Data>? data;
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
  Attributes(
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
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
