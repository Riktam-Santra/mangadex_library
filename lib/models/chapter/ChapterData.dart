import 'package:mangadex_library/models/common/relationships.dart';

///@nodoc
class ChapterData {
  late final String result;
  late final String response;
  late final List<Data> data;
  late final int limit;
  late final int offset;
  late final int total;
  ChapterData(this.result, this.response, this.data, this.limit, this.offset,
      this.total);
  ChapterData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
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
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.map((e) => e.toJson()),
        'limit': limit,
        'offset': offset,
        'total': total,
      };
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
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'attributes': attributes.toJson(),
        'relationships': relationships.map((e) => e.toJson()),
      };
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
    chapterData = [];
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
  Map<String, dynamic> toJson() => {
        'volume': volume,
        'chapter': chapter,
        'title': title,
        'translatedLanguage': translatedLanguage,
        'hash': hash,
        'data': chapterData,
        'dataSaver': chapterDataSaver,
        'publishAt': publishAt,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'version': version,
      };
}
