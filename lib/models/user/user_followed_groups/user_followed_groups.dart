///@nodoc
import 'package:mangadex_library/models/common/relationships.dart';

///@nodoc
class UserFollowedGroups {
  late final List<Data> data;
  late final int limit;
  late final int offset;
  late final int total;
  UserFollowedGroups(this.data, this.limit, this.offset, this.total);
  UserFollowedGroups.fromJson(Map<String, dynamic> json) {
    data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
}

///@nodoc
class Data {
  late final String id;
  late final String type;
  late final Attributes attributes;
  late final List<Relationship> relationships;
  Data(this.id, this.type, this.attributes);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']!);
    relationships = <Relationship>[];
    json['relationships']!.forEach((v) {
      relationships.add(Relationship.fromJson(v));
    });
  }
}

///@nodoc
class Attributes {
  late final String name;
  late final String website;
  late final String ircServer;
  late final String ircChannel;
  late final String discord;
  late final String contactEmail;
  late final String description;
  late final bool locked;
  late final bool official;
  late final int version;
  late final String createdAt;
  late final String updatedAt;
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
  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    website = json['website'] ?? '';
    ircServer = json['ircServer'] ?? '';
    ircChannel = json['ircChannel'] ?? '';
    discord = json['discord'] ?? '';
    contactEmail = json['contactEmail'] ?? '';
    locked = json['locked'] ?? true;
    official = json['official'] ?? true;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    version = json['version'] ?? '';
  }
}
