import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

///@nodoc
@JsonSerializable()
class Login {
  final String result;
  final Token token;
  Login({
    required this.result,
    required this.token,
  });
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

///@nodoc
@JsonSerializable()
class Token {
  final String session;
  final String refresh;
  Token({
    required this.session,
    required this.refresh,
  });
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
