import 'package:json_annotation/json_annotation.dart';
part 'single_custom_list_response.g.dart';

///@nodoc
@JsonSerializable()
class SingleCustomListResponse {
  final String? result;
  final String? response;
  final Data? data;
  SingleCustomListResponse(this.result, this.response, this.data);
  factory SingleCustomListResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleCustomListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCustomListResponseToJson(this);
}

@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  final Attributes? attributes;
  final List<Relationship>? relationships;
  Data(this.id, this.type, this.attributes, this.relationships);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Attributes {
  final String? name;
  final String? visibility;
  final int? version;
  Attributes(this.name, this.visibility, this.version);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class Relationship {
  final String? id;
  final String? type;
  Relationship(this.id, this.type);
  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}
