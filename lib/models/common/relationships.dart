import 'package:mangadex_library/models/cover/Cover.dart';

///@nodoc
class Relationship {
  final String id;
  final String type;
  final Attributes? attributes;
  Relationship(this.id, this.type, this.attributes);
  factory Relationship.fromJson(Map<String, dynamic> json) {
    var ats = (json['attributes'] != null)
        ? Attributes.fromJson(json['attributes'])
        : null;
    return Relationship(
      json['id'] ?? '',
      json['type'] ?? '',
      ats,
    );
  }
}
