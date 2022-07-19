import 'package:json_annotation/json_annotation.dart';
part 'custom_list_confirmation.g.dart';

///@nodoc
@JsonSerializable()
class SingleCustomListResponse {
  final String result;
  final String response;
  final Data data;
  SingleCustomListResponse({
    required this.result,
    required this.response,
    required this.data,
  });
  factory SingleCustomListResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleCustomListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCustomListResponseToJson(this);
}

@JsonSerializable()
class Data {
  final String id;
  final String type;
  final Attributes attributes;
  final List<Relationship> relationships;
  Data({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Attributes {
  final String name;
  final String visibility;
  final int version;
  Attributes({
    required this.name,
    required this.visibility,
    required this.version,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

@JsonSerializable()
class Relationship {
  final String id;
  final String type;
  final String related;
  final Map<String, dynamic> attributes;
  Relationship({
    required this.id,
    required this.type,
    required this.related,
    required this.attributes,
  });
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
