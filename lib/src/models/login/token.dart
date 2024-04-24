import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

///@nodoc
@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  @JsonKey(name: 'refresh_expires_in')
  final int refreshExpiresIn;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  Token(this.accessToken, this.expiresIn, this.refreshExpiresIn,
      this.refreshToken);
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
