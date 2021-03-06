///@nodoc
import 'package:mangadex_library/models/common/alt_titles.dart';
import 'package:mangadex_library/models/common/description.dart';
import 'package:mangadex_library/models/common/tags.dart';
import 'package:mangadex_library/models/common/title.dart';

class Attributes {
  late final Title title;
  late final List<AltTitles> altTitles;
  late final Description description;
  late final bool isLocked;
  late final String originalLanguage;
  late final String lastVolume;
  late final String lastChapter;
  late final String publicationDemographic;
  late final String status;
  late final int year;
  late final String contentRating;
  late final List<Tags> tags;
  late final String createdAt;
  late final String updatedAt;
  late final int version;
  Attributes(
      this.title,
      this.altTitles,
      this.description,
      this.isLocked,
      this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      this.status,
      this.year,
      this.contentRating,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    if (json['title'] != null) {
      title = Title.fromJson(json['title']);
    }
    altTitles = <AltTitles>[];
    if (json['altTitles'] != null) {
      json['altTitles'].forEach((v) {
        altTitles.add(AltTitles.fromJson(v));
      });
    }
    if (json['description'] != null) {
      description = Description.fromJson(json['description']);
    }
    isLocked = json['isLocked'] ?? true;
    originalLanguage = json['originalLanguage'] ?? '';
    lastVolume = json['lastVolume'] ?? '';
    lastChapter = json['lastChapter'] ?? '';
    publicationDemographic = json['publicationDemographic'] ?? '';
    status = json['status'] ?? '';
    year = json['year'] ?? 0;
    contentRating = json['contentRating'] ?? '';
    tags = <Tags>[];
    if (json['tags'] != null) {
      json['tags'].forEach((v) {
        tags.add(Tags.fromJson(v));
      });
    }
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    version = json['version'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'title': title.toJson(),
        'altTitles': altTitles.map((e) => e.toJson()),
        'description': description.toJson(),
        'isLocked': isLocked.toString(),
        'originalLanguage': originalLanguage,
        'lastVolume': lastVolume,
        'lastChapter': lastChapter,
        'publicationDemographic': publicationDemographic,
        'status': status,
        'year': year.toString(),
        'contentRating': contentRating,
        'tags': tags.map((e) => e.toJson()).toString(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'version': version.toString(),
      };
}
