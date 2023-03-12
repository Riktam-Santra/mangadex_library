import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/cover/cover.dart';
part 'relationships.g.dart';

///@nodoc
@JsonSerializable()
class Relationship {
  final String? id;
  final String? type;
  final Attributes? attributes;
  Relationship(this.id, this.type, this.attributes);
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
