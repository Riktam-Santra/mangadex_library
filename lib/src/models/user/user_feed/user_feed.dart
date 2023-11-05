import 'package:json_annotation/json_annotation.dart';
part 'user_feed.g.dart';

///@nodoc
@JsonSerializable()
class UserFeed {
  final String result;
  final String response;
  final List<UserFeedData> data;
  UserFeed(this.result, this.response, this.data);
  factory UserFeed.fromJson(Map<String, dynamic> json) =>
      _$UserFeedFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedToJson(this);
}

///@nodoc
@JsonSerializable()
class UserFeedData {
  final String id;
  final String type;
  final UserFeedAttributes attributes;
  final List<UserFeedRelationship> relationships;
  UserFeedData(this.id, this.type, this.attributes, this.relationships);
  factory UserFeedData.fromJson(Map<String, dynamic> json) =>
      _$UserFeedDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedDataToJson(this);
}

///@nodoc
@JsonSerializable()
class UserFeedAttributes {
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
  UserFeedAttributes(
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
  factory UserFeedAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserFeedAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class UserFeedRelationship {
  final String id;
  final String type;
  UserFeedRelationship(this.id, this.type);
  factory UserFeedRelationship.fromJson(Map<String, dynamic> json) =>
      _$UserFeedRelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedRelationshipToJson(this);
}
