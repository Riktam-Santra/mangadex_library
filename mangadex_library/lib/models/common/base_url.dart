///@nodoc
import 'package:mangadex_library/mangadexServerException.dart';
import 'package:mangadex_library/models/common/chapter.dart';

class BaseUrl {
  late String result;
  late String baseUrl;
  late Chapter chapter;
  BaseUrl(this.result, this.baseUrl);
  BaseUrl.fromJson(Map<String, dynamic> json) {
    try {
      result = json['result'] ?? '';
      baseUrl = json['baseUrl'] ?? '';
      chapter = Chapter.fromJson(json['chapter']!);
    } on Exception {
      throw MangadexServerException(json);
    }
  }
}
