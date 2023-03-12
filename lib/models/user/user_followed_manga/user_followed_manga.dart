///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/data.dart';
part 'user_followed_manga.g.dart';

///@nodoc
@JsonSerializable()
class UserFollowedManga {
  final List<Data>? data;
  final int? limit;
  final int? offset;
  final int? total;
  UserFollowedManga(this.data, this.limit, this.offset, this.total);
  factory UserFollowedManga.fromJson(Map<String, dynamic> json) =>
      _$UserFollowedMangaFromJson(json);
  Map<String, dynamic> toJson() => _$UserFollowedMangaToJson(this);
}
