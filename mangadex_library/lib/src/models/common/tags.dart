import 'package:mangadex_library/src/models/common/tag_attributes.dart';

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
