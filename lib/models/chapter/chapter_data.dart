import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'chapter_data.g.dart';

///@nodoc
@JsonSerializable()
class ChapterData {
  final String result;
  final String response;
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  ChapterData({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory ChapterData.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterDataToJson(this);
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
  final String hash;
  final List<String> chapterData;
  final List<String> chapterDataSaver;
  final String publishAt;
  final String createdAt;
  final String updatedAt;
  final int version;
  Attributes({
    required this.volume,
    required this.chapter,
    required this.title,
    required this.translatedLanguage,
    required this.hash,
    required this.chapterData,
    required this.chapterDataSaver,
    required this.publishAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
