///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/name.dart';
part 'tag_attributes.g.dart';

@JsonSerializable()
class Attributes {
  final Name name;
  // final Description description;
  final String group;
  final int version;
  Attributes(
      {required this.name,
      /*required this.description,*/ required this.group,
      required this.version});
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
