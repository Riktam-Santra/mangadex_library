///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/relationships.dart';

part 'logged_user_details.g.dart';

@JsonSerializable()
class UserDetails {
  final String result;
  final String response;
  final Data data;

  UserDetails({
    required this.result,
    required this.data,
    required this.response,
  });
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

///@nodoc
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

///@nodoc
@JsonSerializable()
class Attributes {
  final String username;
  final List<String> roles;
  final int version;
  Attributes({
    required this.username,
    required this.roles,
    required this.version,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
