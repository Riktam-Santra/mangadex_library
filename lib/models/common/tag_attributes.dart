///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/description.dart';
import 'package:mangadex_library/models/common/name.dart';
part 'tag_attributes.g.dart';

///@nodoc
@JsonSerializable()
class TagAttributes {
  final Name? name;
  final Description? description;
  final String? group;
  final int? version;
  TagAttributes(this.name, this.description, this.group, this.version);
  factory TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$TagAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$TagAttributesToJson(this);
}
