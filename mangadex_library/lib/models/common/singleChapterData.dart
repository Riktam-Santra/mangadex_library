import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/models/chapter/chapterData.dart';

class SingleChapterData {
  late final String result;
  late final String response;
  late final Data data;
  SingleChapterData(this.result, this.response, this.data);
  SingleChapterData.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    if (result == 'ok') {
      data = Data.fromJson(json['data']);
    } else {
      throw MangadexServerException(json);
    }
  }
}
