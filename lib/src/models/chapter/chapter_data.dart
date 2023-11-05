import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';

part 'chapter_data.g.dart';

///@nodoc
@JsonSerializable()
class ChapterData {
  final String? result;
  final String? response;
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  ChapterData(this.result, this.response, this.data, this.limit, this.offset,
      this.total);
  factory ChapterData.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterDataToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  ChapterAttributes? attributes;
  List<Relationship>? relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class ChapterAttributes {
  final String? volume;
  final String? chapter;
  final String? title;
  final String? transdLanguage;
  final String? hash;
  final List<String>? chapterData;
  final List<String>? chapterDataSaver;
  final String? publishAt;
  final String? createdAt;
  final String? updatedAt;
  final int? version;
  ChapterAttributes(
      this.volume,
      this.chapter,
      this.title,
      this.transdLanguage,
      this.hash,
      this.chapterData,
      this.chapterDataSaver,
      this.publishAt,
      this.createdAt,
      this.updatedAt,
      this.version);
  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      _$ChapterAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterAttributesToJson(this);
}
