import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/models/common/relationships.dart';

class UserDetails {
  late final String result;
  late final String response;
  late final Data data;

  UserDetails(this.result, this.data);
  UserDetails.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (result == 'ok') {
      response = json['response'] ?? '';
      data = Data.fromjson(json['data']!);
    } else {
      throw MangadexServerException(json);
    }
  }
}

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
}

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
}
