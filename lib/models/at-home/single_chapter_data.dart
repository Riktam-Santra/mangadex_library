import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/at-home/chapter.dart';
part 'single_chapter_data.g.dart';

///@nodoc
@JsonSerializable()
class SingleChapterData {
  final String? result;
  final String? baseUrl;
  final Chapter? chapter;
  SingleChapterData(this.result, this.chapter, this.baseUrl);
  factory SingleChapterData.fromJson(Map<String, dynamic> json) =>
      _$SingleChapterDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleChapterDataToJson(this);
}
