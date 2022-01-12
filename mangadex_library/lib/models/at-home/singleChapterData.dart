import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/models/at-home/chapter.dart';

class SingleChapterData {
  late String result;
  late String baseUrl;
  late Chapter chapter;
  SingleChapterData(this.result, this.chapter);
  SingleChapterData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (result == 'ok') {
      baseUrl = json['baseUrl'] ?? '';
      try {
        chapter = Chapter.fromJson(json['chapter']!);
      } catch (e) {
        throw MangadexServerException(json);
      }
    } else {
      throw MangadexServerException(json);
    }
  }
}
