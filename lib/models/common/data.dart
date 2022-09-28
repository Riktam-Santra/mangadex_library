///@nodoc
import 'package:mangadex_library/models/common/attributes.dart';
import 'package:mangadex_library/models/common/relationships.dart';

class Data {
  late final String id;
  late final String type;
  late Attributes attributes;
  late final List<Relationship> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    } else {
      print(json['attributes'].toString());
    }
    relationships = <Relationship>[];
    if (json['relationships'] != null) {
      json['relationships'].forEach((v) {
        relationships.add(Relationship.fromJson(v));
      });
    }
  }
}
