///@nodoc
import 'package:mangadex_library/models/common/relationships.dart';

///@nodoc
class UserDetails {
  late final String result;
  late final String response;
  late final Data data;

  UserDetails(this.result, this.data);
  UserDetails.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    data = Data.fromjson(json['data']!);
  }
  Map<String, dynamic> toJson() => {
        'result': result,
        'response': response,
        'data': data.toJson(),
      };
}

///@nodoc
class Data {
  late final String id;
  late final String type;
  late final Attributes attributes;
  late final List<Relationship> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  Data.fromjson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']!);
    relationships = [];
    json['relationships']!.forEach((v) {
      relationships.add(Relationship.fromJson(v));
    });
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'attributes': attributes.toJson(),
        'relationships': relationships.map((e) => e.toJson()).toString(),
      };
}

///@nodoc
class Attributes {
  late final String username;
  late final List<String> roles;
  late final int version;
  Attributes(this.username, this.roles, this.version);
  Attributes.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    roles = [];
    json['roles'].forEach((v) {
      roles.add(v);
    });
    version = json['version'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'username': username,
        'roles': roles,
        'version': version.toString(),
      };
}
