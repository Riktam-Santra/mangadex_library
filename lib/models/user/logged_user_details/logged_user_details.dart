///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';
part 'logged_user_details.g.dart';

///@nodoc
@JsonSerializable()
class UserDetails {
  final String? result;
  final String? response;
  final Data? data;

  UserDetails(this.result, this.data, this.response);
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

///@nodoc
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

///@nodoc
@JsonSerializable()
class Attributes {
  final String? username;
  final List<String>? roles;
  final int? version;
  Attributes(this.username, this.roles, this.version);
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
