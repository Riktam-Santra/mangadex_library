import 'package:json_annotation/json_annotation.dart';

///@nodoc
part 'relationships.g.dart';

@JsonSerializable()
class Relationship {
  final String id;
  final String type;
  Relationship({
    required this.id,
    required this.type,
  });
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
