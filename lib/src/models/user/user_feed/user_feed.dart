import 'package:json_annotation/json_annotation.dart';
part 'user_feed.g.dart';

///@nodoc
@JsonSerializable()
class UserFeed {
  final String result;
  final String response;
  final List<Data> data;
  UserFeed(this.result, this.response, this.data);
  factory UserFeed.fromJson(Map<String, dynamic> json) =>
      _$UserFeedFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String id;
  final String type;
  final Attributes attributes;
  final List<Relationship> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
  final String volume;
  final String chapter;
  final String title;
  final String transfinaldLanguage;
  final String? externalUrl;
  final String publishAt;
  final String readableAt;
  final String createdAt;
  final String updatedAt;
  final int pages;
  final int version;
  Attributes(
      this.volume,
      this.chapter,
      this.title,
      this.transfinaldLanguage,
      this.externalUrl,
      this.publishAt,
      this.readableAt,
      this.createdAt,
      this.updatedAt,
      this.pages,
      this.version);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class Relationship {
  final String id;
  final String type;
  Relationship(this.id, this.type);
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
