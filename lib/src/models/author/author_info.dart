import 'package:json_annotation/json_annotation.dart';

part 'author_info.g.dart';

///@nodoc
@JsonSerializable()
class AuthorInfo {
  final String? result;
  final String? response;
  final AuthorData? data;
  final List<AuthorRelationship>? relationships;
  AuthorInfo(this.result, this.response, this.data, this.relationships);
  factory AuthorInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorInfoToJson(this);
}

///@nodoc
@JsonSerializable()
class AuthorData {
  final String? id;
  final String? type;
  final AuthorAttributes? attributes;
  AuthorData(this.id, this.type, this.attributes);
  factory AuthorData.fromJson(Map<String, dynamic> json) =>
      _$AuthorDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorDataToJson(this);
}

///@nodoc
@JsonSerializable()
class AuthorAttributes {
  final String? name;
  final String? imageUrl;
  final String? twitter;
  final String? pixiv;
  final String? melonBook;
  final String? fanBox;
  final String? booth;
  final String? nicoVideo;
  final String? skeb;
  final String? fantia;
  final String? tumblr;
  final String? youtube;
  final String? weibo;
  final String? naver;
  final String? website;
  final String? createdAt;
  final String? updateAt;
  final int? version;
  AuthorAttributes(
      this.name,
      this.imageUrl,
      this.twitter,
      this.pixiv,
      this.melonBook,
      this.fanBox,
      this.booth,
      this.nicoVideo,
      this.skeb,
      this.fantia,
      this.tumblr,
      this.youtube,
      this.weibo,
      this.naver,
      this.website,
      this.createdAt,
      this.updateAt,
      this.version);

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) =>
      _$AuthorAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorAttributesToJson(this);
}

///@nodoc
@JsonSerializable()
class AuthorRelationship {
  final String? id;
  final String? type;
  AuthorRelationship(this.id, this.type);
  factory AuthorRelationship.fromJson(Map<String, dynamic> json) =>
      _$AuthorRelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorRelationshipToJson(this);
}
