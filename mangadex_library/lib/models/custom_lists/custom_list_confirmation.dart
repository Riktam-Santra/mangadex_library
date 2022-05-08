///@nodoc
class CustomListResponse {
  late String result;
  late String response;
  late Data data;
  CustomListResponse(this.result, this.response, this.data);
  CustomListResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }
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
}

class Attributes {
  late String name;
  late String visibility;
  late int version;
  Attributes(this.name, this.visibility, this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    visibility = json['visibility'] ?? '';
    version = json['version'] ?? 0;
  }
}

class Relationship {
  late String id;
  late String type;
  late String related;
  late Object attributes;
  Relationship(this.id, this.type, this.related, this.attributes);
  Relationship.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    related = json['related'] ?? '';
    attributes = json['attributes'] ?? {};
  }
}
