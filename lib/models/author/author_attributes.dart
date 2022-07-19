import 'package:json_annotation/json_annotation.dart';

part 'author_attributes.g.dart';

@JsonSerializable()
class Attributes {
  final String name;
  final String? imageUrl;
  final String twitter;
  final String pixiv;
  final String melonBook;
  final String fanBox;
  final String booth;
  final String nicoVideo;
  final String skeb;
  final String fantia;
  final String tumblr;
  final String youtube;
  final String weibo;
  final String naver;
  final String website;
  final String createdAt;
  final String updateAt;
  final int version;
  Attributes({
    required this.name,
    required this.imageUrl,
    required this.twitter,
    required this.pixiv,
    required this.melonBook,
    required this.fanBox,
    required this.booth,
    required this.nicoVideo,
    required this.skeb,
    required this.fantia,
    required this.tumblr,
    required this.youtube,
    required this.weibo,
    required this.naver,
    required this.website,
    required this.createdAt,
    required this.updateAt,
    required this.version,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}
