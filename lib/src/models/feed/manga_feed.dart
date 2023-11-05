import 'package:json_annotation/json_annotation.dart';

part 'manga_feed.g.dart';

///@nodoc
@JsonSerializable()
class MangaFeed {
  final String? result;
  final String? response;
  final List<MangaFeedData>? data;
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
class MangaFeedData {
  final String? id;
  final String? type;
  final MangaFeedAttributes? attributes;
  MangaFeedData(this.id, this.type, this.attributes);
  factory MangaFeedData.fromJson(Map<String, dynamic> json) =>
      _$MangaFeedDataFromJson(json);

  Map<String, dynamic> toJson() => _$MangaFeedDataToJson(this);
}

///@nodoc
@JsonSerializable()
class MangaFeedAttributes {
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
  final List<MangaFeedRelationship>? relationships;
  MangaFeedAttributes(
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

  factory MangaFeedAttributes.fromJson(Map<String, dynamic> json) =>
      _$MangaFeedAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$MangaFeedAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class MangaFeedRelationship {
  final String? id;
  final String? type;
  final String? related;
  MangaFeedRelationship(this.id, this.type, this.related);
  factory MangaFeedRelationship.fromJson(Map<String, dynamic> json) =>
      _$MangaFeedRelationshipFromJson(json);

  Map<String, dynamic> toJson() => _$MangaFeedRelationshipToJson(this);
}
