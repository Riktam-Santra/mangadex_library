import 'package:json_annotation/json_annotation.dart';

part 'token_check.g.dart';

@JsonSerializable()
class AuthenticationCheck {
  final String result;
  final bool isAuthenticated;
  final List<String> roles;
  final List<String> permissions;
  AuthenticationCheck({
    required this.result,
    required this.isAuthenticated,
    required this.roles,
    required this.permissions,
  });
  factory AuthenticationCheck.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationCheckFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationCheckToJson(this);
}
