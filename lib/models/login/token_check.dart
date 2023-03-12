import 'package:json_annotation/json_annotation.dart';
part 'token_check.g.dart';

///@nodoc
@JsonSerializable()
class AuthenticationCheck {
  final String? result;
  final bool? isAuthenticated;
  final List<String>? roles;
  final List<String>? permissions;
  AuthenticationCheck(
      this.result, this.isAuthenticated, this.roles, this.permissions);
  factory AuthenticationCheck.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationCheckFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationCheckToJson(this);
}
