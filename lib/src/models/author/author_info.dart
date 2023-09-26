import 'package:json_annotation/json_annotation.dart';

part 'author_info.g.dart';

///@nodoc
@JsonSerializable()
class AuthorInfo {
  final String? result;
  final String? response;
  final Data? data;
  final List<Relationship>? relationships;
  AuthorInfo(this.result, this.response, this.data, this.relationships);
  factory AuthorInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorInfoToJson(this);
}

///@nodoc
@JsonSerializable()
class Data {
  final String? id;
  final String? type;
  final Attributes? attributes;
  Data(this.id, this.type, this.attributes);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

///@nodoc
@JsonSerializable()
class Attributes {
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
  Attributes(
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
