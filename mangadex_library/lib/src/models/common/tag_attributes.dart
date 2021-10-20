import 'package:mangadex_library/src/models/common/name.dart';

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
