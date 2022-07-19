import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'user_feed.g.dart';

///@nodoc
@JsonSerializable()
class UserFeed {
  final String result;
  final String response;
  final List<Data> data;
  UserFeed({
    required this.result,
    required this.response,
    required this.data,
  });
  factory UserFeed.fromJson(Map<String, dynamic> json) =>
      _$UserFeedFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedToJson(this);
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
  final String volume;
  final String chapter;
  final String title;
  final String translatedLanguage;
  final String? externalUrl;
  final String publishAt;
  final String readableAt;
  final String createdAt;
  final String updatedAt;
  final int pages;
  final int version;
  Attributes({
    required this.volume,
    required this.chapter,
    required this.title,
    required this.translatedLanguage,
    required this.externalUrl,
    required this.publishAt,
    required this.readableAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pages,
    required this.version,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
