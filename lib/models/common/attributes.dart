///@nodoc
// import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/alt_titles.dart';
import 'package:mangadex_library/models/common/description.dart';
import 'package:mangadex_library/models/common/tags.dart';
import 'package:mangadex_library/models/common/title.dart';

part 'attributes.g.dart';

// @JsonSerializable()
class Attributes {
  final Title title;
  final List<AltTitles> altTitles;
  final Description description;
  final bool isLocked;
  final String originalLanguage;
  final String? lastVolume;
  final String? lastChapter;
  final String? publicationDemographic;
  final String status;
  final int? year;
  final String contentRating;
  final List<Tags> tags;
  final String createdAt;
  final String updatedAt;
  final int version;
  Attributes({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.isLocked,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    required this.publicationDemographic,
    required this.status,
    required this.year,
    required this.contentRating,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
