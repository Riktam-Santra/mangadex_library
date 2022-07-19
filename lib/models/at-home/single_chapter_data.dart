import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex_library/models/common/chapter.dart';
part 'single_chapter_data.g.dart';

///@nodoc
@JsonSerializable()
class SingleChapterData {
  final String result;
  final String baseUrl;
  final Chapter chapter;
  SingleChapterData({
    required this.result,
    required this.baseUrl,
    required this.chapter,
  });
  factory SingleChapterData.fromJson(Map<String, dynamic> json) =>
      _$SingleChapterDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleChapterDataToJson(this);
}
