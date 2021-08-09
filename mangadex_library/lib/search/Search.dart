class Search {
  late final List<Results> results;
  late final int limit;
  late final int offset;
  late final int total;
  Search(this.results, this.limit, this.offset, this.total);
  Search.fromJson(Map<String, dynamic> json) {
    results = <Results>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
}

class Results {
  late final String result;
  late final Data data;
  late final List<Relationships> relationships;
  Results(this.result, this.data, this.relationships);
  Results.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = Data.fromjson(json['data']);
    relationships = <Relationships>[];
    if (json['relationships'] != null) {
      json['relationships'].forEach((v) {
        relationships.add(Relationships.fromJson(v));
      });
    }
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

class Data {
  late final String id;
  late final String type;
  late final Attributes attributes;
  Data(this.id, this.type, this.attributes);
  Data.fromjson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']);
  }
}

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
}

class Title {
  late final String en;
  late final String fr;
  Title(this.en, this.fr);
  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}

class AltTitles {
  late final String en;
  late final String fr;
  AltTitles(this.en, this.fr);
  AltTitles.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}

class Description {
  late final String en;
  late final String fr;
  Description(this.en, this.fr);
  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}

class Tags {
  late final String id;
  late final String type;
  late final TagAttributes attributes;
  Tags(this.id, this.type, this.attributes);
  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    if (json['attributes'] != null) {
      attributes = TagAttributes.fromJson(json['attributes']);
    }
  }
}

class TagAttributes {
  late final Name name;
  late final List<Description> description;
  late final String group;
  late final int version;
  TagAttributes(this.name, this.description, this.group, this.version);
  TagAttributes.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      name = Name.fromJson(json['name']);
    }
    description = <Description>[];
    if (json['description'] != null) {
      json['description'].forEach((v) {
        description.add(Description.fromJson(v));
      });
      if (description.isEmpty) {
        print(
            'Tag description is empty. Please be careful, if you aren\'t dealing with the description of the tags involved, this shouldn\'t be a matter of concern.');
      }
    }
    group = json['group'] ?? '';
  }
}

class Name {
  late final String en;
  late final String fr;
  Name(this.en, this.fr);
  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'] ?? '';
    fr = json['fr'] ?? '';
  }
}
