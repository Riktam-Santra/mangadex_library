import 'package:json_annotation/json_annotation.dart';

part 'manga_feed.g.dart';

///@nodoc
@JsonSerializable()
class MangaFeed {
  final String? result;
  final String? response;
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  MangaFeed(this.result, this.response, this.data, this.limit, this.offset,
      this.total);

  factory MangaFeed.fromJson(Map<String, dynamic> json) =>
      _$MangaFeedFromJson(json);

  Map<String, dynamic> toJson() => _$MangaFeedToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  final Attributes? attributes;
  Data(this.id, this.type, this.attributes);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
  final String? title;
  final String? volume;
  final String? chapter;
  final int? pages;
  final String? translatedLanguage;
  final String? uploader;
  final String? externalUrl;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final String? publishedAt;
  final String? readableAt;
  final List<Relationship>? relationships;
  Attributes(
      this.title,
      this.volume,
      this.chapter,
      this.pages,
      this.translatedLanguage,
      this.uploader,
      this.externalUrl,
      this.version,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.readableAt,
      this.relationships);

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class Relationship {
  final String? id;
  final String? type;
  final String? related;
  Relationship(this.id, this.type, this.related);
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);

  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
