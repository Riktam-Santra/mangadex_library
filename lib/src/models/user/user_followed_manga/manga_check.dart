import 'package:json_annotation/json_annotation.dart';
part 'manga_check.g.dart';

///@nodoc
@JsonSerializable()
class MangaCheck {
  final String? result;

  MangaCheck(this.result);

  factory MangaCheck.fromJson(Map<String, dynamic> json) =>
      _$MangaCheckFromJson(json);
  Map<String, dynamic> toJson() => _$MangaCheckToJson(this);
}
