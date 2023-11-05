///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/src/models/common/relationships.dart';
part 'logged_user_details.g.dart';

///@nodoc
@JsonSerializable()
class UserDetails {
  final String? result;
  final String? response;
  final UserDetailsData? data;

  UserDetails(this.result, this.data, this.response);
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

///@nodoc
@JsonSerializable()
class UserDetailsData {
  final String? id;
  final String? type;
  final UserDetailsAttributes? attributes;
  final List<Relationship>? relationships;
  UserDetailsData(this.id, this.type, this.attributes, this.relationships);
  factory UserDetailsData.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsDataToJson(this);
}

///@nodoc
@JsonSerializable()
class UserDetailsAttributes {
  final String? username;
  final List<String>? roles;
  final int? version;
  UserDetailsAttributes(this.username, this.roles, this.version);
  factory UserDetailsAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsAttributesToJson(this);
}
