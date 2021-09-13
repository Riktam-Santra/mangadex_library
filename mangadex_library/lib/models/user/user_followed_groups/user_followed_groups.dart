class UserFollowedGroups {
  late final List<Results> results;
  late final int limit;
  late final int offset;
  late final int total;
  UserFollowedGroups(this.results, this.limit, this.offset, this.total);
  UserFollowedGroups.fromJson(Map<String, dynamic> json) {
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
  late final String name;
  late final String website;
  late final String ircServer;
  late final String ircChannel;
  late final String discord;
  late final String contactEmail;
  late final String description;
  late final bool locked;
  late final bool official;
  late final int version;
  late final String createdAt;
  late final String updatedAt;
  Attributes(
      this.name,
      this.website,
      this.ircServer,
      this.ircChannel,
      this.discord,
      this.contactEmail,
      this.description,
      this.locked,
      this.official,
      this.version,
      this.createdAt,
      this.updatedAt);
  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    website = json['website'] ?? '';
    ircServer = json['ircServer'] ?? '';
    ircChannel = json['ircChannel'] ?? '';
    discord = json['discord'] ?? '';
    contactEmail = json['contactEmail'] ?? '';
    locked = json['locked'] ?? true;
    official = json['official'] ?? true;
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
  //late final Description description;
  late final String group;
  late final int version;
  TagAttributes(this.name, /*this.description,*/ this.group, this.version);
  TagAttributes.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      name = Name.fromJson(json['name']);
    }
    // if (json['description'] != null) {
    //   description = Description.fromJson(json['description']);
    // }
    group = json['group'] ?? '';
    version = json['version'] ?? 1;
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
