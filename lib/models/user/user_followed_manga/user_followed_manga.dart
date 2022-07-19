///@nodoc
import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/data.dart';
part 'user_followed_manga.g.dart';

@JsonSerializable()
class UserFollowedManga {
  final List<Data> data;
  final int limit;
  final int offset;
  final int total;
  UserFollowedManga({
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
  factory UserFollowedManga.fromJson(Map<String, dynamic> json) =>
      _$UserFollowedMangaFromJson(json);
  Map<String, dynamic> toJson() => _$UserFollowedMangaToJson(this);
}
