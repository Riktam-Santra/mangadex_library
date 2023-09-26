import 'package:json_annotation/json_annotation.dart';

part 'scanlations_result.g.dart';

///@nodoc
@JsonSerializable()
class ScanlationsResult {
  final String? result;
  final String? response;
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  ScanlationsResult(this.result, this.response, this.data, this.limit,
      this.offset, this.total);
  factory ScanlationsResult.fromJson(Map<String, dynamic> json) =>
      _$ScanlationsResultFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationsResultToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String id;
  final String type;
  final Attributes attributes;
  final List<RelationShip> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
  final String? name;
  final List<Map<String, String>>? altNames;
  final String? website;
  final String? ircServer;
  final String? ircChannel;
  final String? discord;
  final String? contactEmail;
  final String? description;
  final String? twitter;
  final String? mangaUpdates;
  final List<String>? focussedLanguage;
  final bool? locked;
  final bool? official;
  final bool? inactive;
  final String? publishDelay;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  Attributes(
      this.name,
      this.altNames,
      this.website,
      this.ircServer,
      this.ircChannel,
      this.discord,
      this.contactEmail,
      this.description,
      this.twitter,
      this.mangaUpdates,
      this.focussedLanguage,
      this.locked,
      this.official,
      this.inactive,
      this.publishDelay,
      this.version,
      this.createdAt,
      this.updatedAt);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class RelationShip {
  final String? id;
  final String? type;
  final String? refinald;
  final Map<String, dynamic>? attributes;
  RelationShip(this.id, this.type, this.refinald, this.attributes);
  factory RelationShip.fromJson(Map<String, dynamic> json) =>
      _$RelationShipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationShipToJson(this);
}
