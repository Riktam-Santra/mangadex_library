class ScanlationsResult {
  late String result;
  late String response;
  late List<Data> data;
  late int limit;
  late int offset;
  late int total;
  ScanlationsResult(this.result, this.response, this.data, this.limit,
      this.offset, this.total);
  ScanlationsResult.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((e) {
        data.add(Data.fromJson(e));
      });
    }
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    total = json['total'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.map((e) => e.toJson()).toString(),
        'limit': limit.toString(),
        'offset': offset.toString(),
        'total': total.toString(),
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
    attributes = Attributes.fromJson(json['attributes']);
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
  late String name;
  late List<Map<String, String>> altNames;
  late String website;
  late String ircServer;
  late String ircChannel;
  late String discord;
  late String contactEmail;
  late String description;
  late String twitter;
  late String mangaUpdates;
  late List<String> focussedLanguage;
  late bool locked;
  late bool official;
  late bool inactive;
  late String publishDelay;
  late int version;
  late String createdAt;
  late String updatedAt;
  Attributes(
      this.name,
      this.altNames,
      this.website,
      this.ircServer,
      this.ircChannel,
      this.discord,
      this.contactEmail,
      this.description,
      this.twitter,
      this.mangaUpdates,
      this.focussedLanguage,
      this.locked,
      this.official,
      this.inactive,
      this.publishDelay,
      this.version,
      this.createdAt,
      this.updatedAt);
  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    altNames = json['altNames'] == null
        ? (json['altNames'] as List<dynamic>)
            .map((e) => (e as Map<String, dynamic>).cast<String, String>())
            .toList()
        : [
            {'': ''},
          ];
    website = json['website'] ?? '';
    ircServer = json['ircServer'] ?? '';
    discord = json['discord'] ?? '';
    contactEmail = json['contactEmail'] ?? '';
    description = json['description'] ?? '';
    twitter = json['twitter'] ?? '';
    mangaUpdates = json['mangaUpdates'] ?? '';
    focussedLanguage = [];
    if (json['focussedLanguage'] != null) {
      focussedLanguage = json['focussedLanguage'].forEach((e) {
        focussedLanguage.add(e);
      });
    }
    locked = json['locked'] ?? false;
    official = json['official'] ?? false;
    inactive = json['inactive'] ?? false;
    publishDelay = json['publishDelay'] ?? '';
    version = json['version'] ?? 0;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'altNames': altNames,
        'website': website,
        'ircServer': ircServer,
        'discord': discord,
        'contactEmail': contactEmail,
        'description': description,
        'twitter': twitter,
        'mangaUpdates': mangaUpdates,
        'focussedLanguage': focussedLanguage,
        'locked': locked.toString(),
        'official': official.toString(),
        'inactive': inactive.toString(),
        'publishDelay': publishDelay,
        'version': version.toString(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class Relationship {
  late String id;
  late String type;
  late String related;
  late Map<String, dynamic> attributes;
  Relationship(this.id, this.type, this.related);
  Relationship.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    related = json['related'] ?? '';
    attributes = json['attributes'] ?? {};
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'related': related,
        'attributes': attributes,
      };
}
