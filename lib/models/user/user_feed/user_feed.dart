import 'package:mangadex_library/models/common/relationships.dart';

///@nodoc
class UserFeed {
  late String result;
  late String response;
  late List<Data> data;
  UserFeed(this.result, this.response, this.data);
  UserFeed.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((e) {
        data.add(Data.fromJson(e));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.map((e) => e.toJson()).toString(),
      };
}

class Data {
  late String id;
  late String type;
  late Attributes attributes;
  late List<Relationship> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    }
    relationships = [];
    if (json['relationships'] != null) {
      json['relationships'].forEach((e) {
        relationships.add(Relationship.fromJson(e));
      });
    }
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'attributes': attributes.toJson(),
        'relationships': relationships.map((e) => e.toJson()).toString(),
      };
}

class Attributes {
  late String volume;
  late String chapter;
  late String title;
  late String translatedLanguage;
  late String? externalUrl;
  late String publishAt;
  late String readableAt;
  late String createdAt;
  late String updatedAt;
  late int pages;
  late int version;
  Attributes(
      this.volume,
      this.chapter,
      this.title,
      this.translatedLanguage,
      this.externalUrl,
      this.publishAt,
      this.readableAt,
      this.createdAt,
      this.updatedAt,
      this.pages,
      this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    volume = json['volume'] ?? '';
    chapter = json['chapter'] ?? '';
    title = json['title'] ?? '';
    translatedLanguage = json['translatedLanguage'] ?? '';
    externalUrl = json['externalUrl'];
    publishAt = json['publishAt'] ?? '';
    readableAt = json['readableAt'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    pages = json['pages'] ?? 0;
    version = json['version'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'volume': volume,
        'chapter': chapter,
        'title': title,
        'translatedLanguage': translatedLanguage,
        'externalUrl': externalUrl,
        'publishAt': publishAt,
        'readableAt': readableAt,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'pages': pages.toString(),
        'version': version.toString(),
      };
}
