///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/scanlation/scanlations_result.dart';
part 'user_followed_groups.g.dart';

@JsonSerializable()
class UserFollowedGroups {
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  UserFollowedGroups({
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory UserFollowedGroups.fromJson(Map<String, dynamic> json) =>
      _$UserFollowedGroupsFromJson(json);
  Map<String, dynamic> toJson() => _$UserFollowedGroupsToJson(this);
}

@JsonSerializable()
class Data {
  final String id;
  final String type;
  final Attributes attributes;
  final List<Relationship> relationships;
  Data({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
// class Attributes {
//   late final String name;
//   late final String website;
//   late final String ircServer;
//   late final String ircChannel;
//   late final String discord;
//   late final String contactEmail;
//   late final String description;
//   late final bool locked;
//   late final bool official;
//   late final int version;
//   late final String createdAt;
//   late final String updatedAt;
//   Attributes(
//       this.name,
//       this.website,
//       this.ircServer,
//       this.ircChannel,
//       this.discord,
//       this.contactEmail,
//       this.description,
//       this.locked,
//       this.official,
//       this.version,
//       this.createdAt,
//       this.updatedAt);
//   Attributes.fromJson(Map<String, dynamic> json) {
//     name = json['name'] ?? '';
//     website = json['website'] ?? '';
//     ircServer = json['ircServer'] ?? '';
//     ircChannel = json['ircChannel'] ?? '';
//     discord = json['discord'] ?? '';
//     contactEmail = json['contactEmail'] ?? '';
//     locked = json['locked'] ?? true;
//     official = json['official'] ?? true;
//     createdAt = json['createdAt'] ?? '';
//     updatedAt = json['updatedAt'] ?? '';
//     version = json['version'] ?? '';
//   }
// }
