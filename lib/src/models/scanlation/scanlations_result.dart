import 'package:json_annotation/json_annotation.dart';

part 'scanlations_result.g.dart';

///@nodoc
@JsonSerializable()
class ScanlationsResult {
  final String? result;
  final String? response;
  final List<ScanlationsResultData>? data;
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
class ScanlationsResultData {
  final String id;
  final String type;
  final ScanlationsResultAttributes attributes;
  final List<ScanlationsResultRelationShip> relationships;
  ScanlationsResultData(
      this.id, this.type, this.attributes, this.relationships);
  factory ScanlationsResultData.fromJson(Map<String, dynamic> json) =>
      _$ScanlationsResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationsResultDataToJson(this);
}

///@nodoc
@JsonSerializable()
class ScanlationsResultAttributes {
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
  ScanlationsResultAttributes(
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
  factory ScanlationsResultAttributes.fromJson(Map<String, dynamic> json) =>
      _$ScanlationsResultAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationsResultAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class ScanlationsResultRelationShip {
  final String? id;
  final String? type;
  final String? refinald;
  final Map<String, dynamic>? attributes;
  ScanlationsResultRelationShip(
      this.id, this.type, this.refinald, this.attributes);
  factory ScanlationsResultRelationShip.fromJson(Map<String, dynamic> json) =>
      _$ScanlationsResultRelationShipFromJson(json);
  Map<String, dynamic> toJson() => _$ScanlationsResultRelationShipToJson(this);
}
