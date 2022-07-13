import 'package:mangadex_library/models/at-home/chapter.dart';

///@nodoc
class SingleChapterData {
  late String result;
  late String baseUrl;
  late Chapter chapter;
  SingleChapterData(this.result, this.chapter);
  SingleChapterData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    baseUrl = json['baseUrl'] ?? '';
    chapter = Chapter.fromJson(json['chapter']!);
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'baseUrl': baseUrl,
        'chapter': chapter.toJson(),
      };
}
