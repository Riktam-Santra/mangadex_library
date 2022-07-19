import 'package:json_annotation/json_annotation.dart';
part 'scanlations_result.g.dart';

@JsonSerializable()
class ScanlationsResult {
  final String result;
  final String response;
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  ScanlationsResult({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory ScanlationsResult.fromJson(Map<String, dynamic> json) =>
      _$ScanlationsResultFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationsResultToJson(this);
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

@JsonSerializable()
class Attributes {
  final String name;
  final List<Map<String, String>> altNames;
  final String website;
  final String ircServer;
  final String ircChannel;
  final String discord;
  final String contactEmail;
  final String description;
  final String twitter;
  final String mangaUpdates;
  final List<String> focussedLanguage;
  final bool locked;
  final bool official;
  final bool inactive;
  final String publishDelay;
  final int version;
  final String createdAt;
  final String updatedAt;
  Attributes({
    required this.name,
    required this.altNames,
    required this.website,
    required this.ircServer,
    required this.ircChannel,
    required this.discord,
    required this.contactEmail,
    required this.description,
    required this.twitter,
    required this.mangaUpdates,
    required this.focussedLanguage,
    required this.locked,
    required this.official,
    required this.inactive,
    required this.publishDelay,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

@JsonSerializable()
class Relationship {
  final String id;
  final String type;
  final String related;
  final Map<String, dynamic> attributes;
  Relationship({
    required this.attributes,
    required this.id,
    required this.type,
    required this.related,
  });
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
