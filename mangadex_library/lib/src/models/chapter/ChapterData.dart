import 'package:mangadex_library/src/models/common/relationships.dart';

class ChapterData {
  late final List<Data> data;
  late final int limit;
  late final int offset;
  late final int total;
  ChapterData(this.data, this.limit, this.offset, this.total);
  ChapterData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    limit = json['limit'] ?? '';
    offset = json['offset'] ?? '';
    total = json['total'] ?? '';
  }
}

class Data {
  late final String id;
  late final String type;
  late Attributes attributes;
  late List<Relationship> relationships;
  Data(this.id, this.type, this.attributes);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']!);
    relationships = <Relationship>[];
    json['relationships'].forEach((v) {
      relationships.add(Relationship.fromJson(v));
    });
  }
}

class Attributes {
  late final String volume;
  late final String chapter;
  late final String title;
  late final String translatedLanguage;
  late final String hash;
  late final List<String> chapterData;
  late final List<String> chapterDataSaver;
  late final String publishAt;
  late final String createdAt;
  late final String updatedAt;
  late final int version;
  Attributes(
      this.volume,
      this.chapter,
      this.title,
      this.translatedLanguage,
      this.hash,
      this.chapterData,
      this.chapterDataSaver,
      this.publishAt,
      this.createdAt,
      this.updatedAt,
      this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    volume = json['volume'] ?? '';
    chapter = json['chapter'] ?? '';
    title = json['title'] ?? '';
    translatedLanguage = json['translatedLanguage'] ?? '';
    hash = json['hash'] ?? '';
    if (json['data'] != null) {
      chapterData = List<String>.from(json['data']);
    }
    if (json['dataSaver'] != null) {
      chapterDataSaver = List<String>.from(json['dataSaver']);
    }
    publishAt = json['publishAt'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    version = json['version'] ?? '';
  }
}
