///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/tag_attributes.dart';
part 'tags.g.dart';

@JsonSerializable()
class Tags {
  final String id;
  final String type;
  final Attributes attributes;
  Tags({required this.id, required this.type, required this.attributes});
  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
