import 'package:mangadex_library/models/common/attributes.dart';
import 'package:mangadex_library/models/common/relationships.dart';

class Data {
  late final String id;
  late final String type;
  late final Attributes attributes;
  late final List<Relationship> relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
    attributes = Attributes.fromJson(json['attributes']!);
    relationships = <Relationship>[];
    json['relationships']!.forEach((v) {
      relationships.add(Relationship.fromJson(v));
    });
  }
}
