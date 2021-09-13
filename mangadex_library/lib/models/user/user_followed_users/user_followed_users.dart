class UserFollowedUsers {
  late final List<Results> results;
  late final int limit;
  late final int offset;
  late final int total;
  UserFollowedUsers(this.results, this.limit, this.offset, this.total);
  UserFollowedUsers.fromJson(Map<String, dynamic> json) {
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
    data = Data.fromJson(json['data']);
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
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']);
  }
}

class Attributes {
  late final String username;
  late final Role roles;
  late final int version;
  Attributes(this.username, this.roles, this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    roles = Role.fromJson(json['roles']);
    version = json['version'] ?? 0;
  }
}

class Role {
  late final List<String> roles;
  Role(this.roles);
  Role.fromJson(Map<String, dynamic> json) {
    roles = <String>[];
    if (json['roles'] != null) {
      json[roles].forEach((v) {
        roles.add(v);
      });
    }
  }
}
