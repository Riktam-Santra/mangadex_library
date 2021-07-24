class Chapter {
  late final List<Result> result;
  late final int limit;
  late final int offset;
  late final int total;
  Chapter(this.result, this.limit, this.offset, this.total);
  Chapter.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      result = <Result>[];
      json['results'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
    limit = json['limit'] ?? '';
    offset = json['offset'] ?? '';
    total = json['total'] ?? '';
  }
}

class Result {
  late final String result;
  late final Data data;
  late final List<Relationships> relationships;
  Result(this.result, this.data, this.relationships);
  Result.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
    if (json['relationships'] != null) {
      relationships = <Relationships>[];
      json['relationships'].forEach((v) {
        relationships.add(Relationships.fromJson(v));
      });
    }
  }
}

class Data {
  late final String id;
  late final String type;
  late Attributes attributes;
  Data(this.id, this.type, this.attributes);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';

    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    }
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

class Relationships {
  late final String id;
  late final String type;
  Relationships(this.id, this.type);
  Relationships.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
  }
}
