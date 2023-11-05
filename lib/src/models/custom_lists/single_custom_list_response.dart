import 'package:json_annotation/json_annotation.dart';
part 'single_custom_list_response.g.dart';

///@nodoc
@JsonSerializable()
class SingleCustomListResponse {
  final String? result;
  final String? response;
  final CustomListData? data;
  SingleCustomListResponse(this.result, this.response, this.data);
  factory SingleCustomListResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleCustomListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleCustomListResponseToJson(this);
}

@JsonSerializable()
class CustomListData {
  final String? id;
  final String? type;
  final CustomListAttributes? attributes;
  final List<CustomListRelationship>? relationships;
  CustomListData(this.id, this.type, this.attributes, this.relationships);
  factory CustomListData.fromJson(Map<String, dynamic> json) =>
      _$CustomListDataFromJson(json);
  Map<String, dynamic> toJson() => _$CustomListDataToJson(this);
}

@JsonSerializable()
class CustomListAttributes {
  final String? name;
  final String? visibility;
  final int? version;
  CustomListAttributes(this.name, this.visibility, this.version);
  factory CustomListAttributes.fromJson(Map<String, dynamic> json) =>
      _$CustomListAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$CustomListAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class CustomListRelationship {
  final String? id;
  final String? type;
  CustomListRelationship(this.id, this.type);
  factory CustomListRelationship.fromJson(Map<String, dynamic> json) =>
      _$CustomListRelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$CustomListRelationshipToJson(this);
}
